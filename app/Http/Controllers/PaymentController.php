<?php

namespace App\Http\Controllers;

use App\Jobs\SendWhatsAppMessageJob;
use App\Models\Order;
use App\Models\Payment;
use App\Models\Setting;
use App\Services\OrderService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class PaymentController extends Controller
{
    public function __construct(protected OrderService $orderService)
    {
    }

      private function sendWhatsAppMessage($phone, $message): void
    {
        if (!$phone) {
            return;
        }

        app(\App\Services\WhatsAppService::class)->sendText($phone, $message);
    }

    /**
     * بيانات التحويل (رقم فودافون كاش ومعرّف انستاباي).
     */
    public function methods()
    {
        $setting = Setting::first();

        return response()->json([
            'methods' => [
                [
                    'key' => 'cash',
                    'label' => 'كاش عند الاستلام',
                ],
                [
                    'key' => 'vodafone_cash',
                    'label' => 'فودافون كاش',
                    'number' => $setting?->vodafone_cash_number,
                ],
                [
                    'key' => 'instapay',
                    'label' => 'انستاباي',
                    'instapay_id' => $setting?->instapay_id,
                ],
            ],
        ]);
    }

    /**
     * العميل يرفع إيصال جديد للطلب (مثلًا بعد رفض الإيصال السابق).
     */
    public function uploadReceipt(Request $request, $orderId)
    {
        $data = $request->validate([
            'payment_type' => 'required|in:vodafone_cash,instapay',
            'sender_phone' => 'required_if:payment_type,vodafone_cash|nullable|string|max:30',
            'reference_number' => 'required_if:payment_type,instapay|nullable|string|max:255',
            'receipt' => 'required|file|mimes:jpg,jpeg,png,pdf|max:5120',
        ]);

        $order = Order::findOrFail($orderId);

        // لو الطلب مرتبط بمستخدم، لازم يكون هو صاحبه
        if ($order->user_id && $request->user('sanctum')?->id !== $order->user_id) {
            abort(403, 'غير مصرح لك بالدفع على هذا الطلب');
        }

        if (in_array($order->status, ['paid', 'completed', 'canceled'], true)) {
            throw ValidationException::withMessages([
                'order' => 'لا يمكن رفع إيصال لطلب حالته ' . $order->status . '.',
            ]);
        }

        $latest = $order->latestPayment;

        if ($latest && $latest->status === Payment::STATUS_PENDING && $latest->receipt_path) {
            throw ValidationException::withMessages([
                'receipt' => 'يوجد إيصال قيد المراجعة بالفعل لهذا الطلب.',
            ]);
        }

        if ($latest && $latest->status === Payment::STATUS_APPROVED) {
            throw ValidationException::withMessages([
                'order' => 'تم اعتماد الدفع لهذا الطلب بالفعل.',
            ]);
        }

        $receiptPath = $this->orderService->storeReceipt($request->file('receipt'));

        try {
            $payment = DB::transaction(function () use ($order, $data, $receiptPath, $latest) {

                // لو آخر محاولة كانت كاش معلقة بدون إيصال، بنحوّل الطلب لطريقة الدفع الجديدة
                $order->update(['payment_type' => $data['payment_type']]);

                return $this->orderService->createPayment($order, $data, $receiptPath);
            });
        } catch (\Throwable $e) {
            $this->orderService->discardUploadedReceipt($receiptPath);

            throw $e;
        }

        $this->notifyAdminsReceipt($order, $payment);

        return response()->json([
            'message' => 'تم رفع الإيصال وجاري مراجعته',
            'payment' => $payment,
        ], 201);
    }

    /**
     * قائمة المدفوعات للمراجعة (?status=pending|approved|rejected).
     */
    public function index(Request $request)
    {
        $query = Payment::with('order', 'reviewer')->latest();

        if ($request->filled('status')) {
            $query->where('status', $request->input('status'));
        }

        if ($request->filled('method')) {
            $query->where('method', $request->input('method'));
        }

        return response()->json([
            'status' => true,
            'payments' => $query->paginate(20),
        ]);
    }

    /**
     * اعتماد الدفع.
     */
    public function approve(Request $request, $id)
    {
        $payment = DB::transaction(function () use ($request, $id) {

            $payment = Payment::lockForUpdate()->findOrFail($id);

            if ($payment->status !== Payment::STATUS_PENDING) {
                throw ValidationException::withMessages([
                    'payment' => 'هذا الدفع تمت مراجعته بالفعل.',
                ]);
            }

            $payment->update([
                'status' => Payment::STATUS_APPROVED,
                'reviewed_by' => $request->user()->id,
                'reviewed_at' => now(),
                'rejection_reason' => null,
            ]);

            $order = $payment->order;

            if ($order && $order->status === 'pending') {
                $order->update(['status' => 'paid']);
            }

            return $payment;
        });

        $order = $payment->order;

        $currency = $this->orderService->currency($order->country);

        $this->sendWhatsAppMessage(
            $order->whatsapp_number ?: $order->phone,
            "تم تأكيد الدفع - شركة الأهرام\n\n" .
            "عزيزي {$order->name}، تم اعتماد دفعتك للطلب رقم {$order->id} بمبلغ {$payment->amount} {$currency}.\n\n" .
            "سنقوم بتجهيز طلبك قريبًا. شكرا لك."
        );

        return response()->json([
            'message' => 'تم اعتماد الدفع',
            'payment' => $payment->fresh(['order', 'reviewer']),
        ]);
    }

    /**
     * رفض الدفع مع سبب.
     */
    public function reject(Request $request, $id)
    {
        $data = $request->validate([
            'reason' => 'required|string|max:1000',
        ]);

        $payment = DB::transaction(function () use ($request, $id, $data) {

            $payment = Payment::lockForUpdate()->findOrFail($id);

            if ($payment->status !== Payment::STATUS_PENDING) {
                throw ValidationException::withMessages([
                    'payment' => 'هذا الدفع تمت مراجعته بالفعل.',
                ]);
            }

            $payment->update([
                'status' => Payment::STATUS_REJECTED,
                'reviewed_by' => $request->user()->id,
                'reviewed_at' => now(),
                'rejection_reason' => $data['reason'],
            ]);

            return $payment;
        });

        $order = $payment->order;

        $this->sendWhatsAppMessage(
            $order->whatsapp_number ?: $order->phone,
            "تعذر تأكيد الدفع - شركة الأهرام\n\n" .
            "عزيزي {$order->name}، لم يتم اعتماد دفعتك للطلب رقم {$order->id}.\n" .
            "السبب: {$data['reason']}\n\n" .
            "من فضلك ارفع إيصال صحيح من صفحة طلبك، أو تواصل معنا للمساعدة."
        );

        return response()->json([
            'message' => 'تم رفض الدفع',
            'payment' => $payment->fresh(['order', 'reviewer']),
        ]);
    }

    /**
     * حذف سجل دفع (Soft Delete) لصاحب الصلاحية فقط.
     */
    public function destroy(Request $request, $id)
    {
        if (!$request->user() || !$request->user()->can('delete-financial-records')) {
            abort(403, 'غير مصرح لك بحذف المدفوعات');
        }

        $payment = Payment::findOrFail($id);

        $payment->delete();

        return response()->json([
            'message' => 'تم حذف سجل الدفع (يمكن استرجاعه)',
        ]);
    }

    /**
     * تنبيه الأدمن بإيصال جديد محتاج مراجعة.
     */
    protected function notifyAdminsReceipt(Order $order, Payment $payment): void
    {
        $currency = $this->orderService->currency($order->country);

        $message = "تنبيه: إيصال دفع جديد محتاج مراجعة\n\n" .
            "رقم الطلب: {$order->id}\n" .
            "العميل: {$order->name}\n" .
            "الطريقة: {$payment->method}\n" .
            "المبلغ: {$payment->amount} {$currency}\n\n" .
            "يرجى مراجعته من لوحة التحكم.";

        $reviewers = \App\Models\User::permission('review-payments')->get();

        foreach ($reviewers as $user) {
            $this->sendWhatsAppMessage($user->phone, $message);
        }
    }
}