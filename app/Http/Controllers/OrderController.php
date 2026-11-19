<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreOrderRequest;
use App\Jobs\SendWhatsAppMessageJob;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\User;
use App\Services\OrderService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use App\Models\UserNotification;

class OrderController extends Controller
{
    public function __construct(protected OrderService $orderService)
    {
    }

    /**
     * إرسال رسالة واتساب عبر الطابور.
     */
      private function sendWhatsAppMessage($phone, $message): void
    {
        if (!$phone) {
            return;
        }

        app(\App\Services\WhatsAppService::class)->sendText($phone, $message);
    }
    /**
     * الأدمن والمدراء (Spatie Roles).
     */
    private function adminUsers()
    {
        return User::role(['admin', 'director'])->get();
    }

    /**
     * جلب جميع الطلبات.
     */
public function index(Request $request)
    {
        $query = Order::with('items.product', 'coupon', 'latestPayment')
            ->latest();

        $categoryIds = [];
        $brandId = $request->input('brand_id');
        $typeId  = $request->input('type_id');

        // ✅ فلترة بالكاتيجوري (+ الأبناء اختياريًا)
        if ($categoryId = $request->input('category_id')) {
            $categoryIds = [$categoryId];

            if ($request->boolean('include_children', false)) {
                $category = Category::find($categoryId);

                if ($category) {
                    $categoryIds = array_merge(
                        $categoryIds,
                        $category->children()->pluck('id')->all()
                    );
                }
            }

            $query->whereHas('items.product', function ($q) use ($categoryIds) {
                $q->whereIn('category_id', $categoryIds);
            });
        }

        // فلترة بالبراند
        if ($brandId) {
            $query->whereHas('items.product', function ($q) use ($brandId) {
                $q->where('brand_id', $brandId);
            });
        }

        // فلترة بنوع المنتج
        if ($typeId) {
            $query->whereHas('items.product', function ($q) use ($typeId) {
                $q->where('type_id', $typeId);
            });
        }

        // فلترة بالحالة
        if ($status = $request->input('status')) {
            $query->where('status', $status);
        }

        // فلترة بطريقة الدفع
        if ($paymentType = $request->input('payment_type')) {
            $query->where('payment_type', $paymentType);
        }

        // فلترة بالتاريخ
        if ($dateFrom = $request->input('date_from')) {
            $query->whereDate('created_at', '>=', $dateFrom);
        }
        if ($dateTo = $request->input('date_to')) {
            $query->whereDate('created_at', '<=', $dateTo);
        }

        // بحث
        if ($search = $request->input('search')) {
            $query->where(function ($q) use ($search) {
                $q->where('id', $search)
                    ->orWhere('name', 'like', "%{$search}%")
                    ->orWhere('phone', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%");
            });
        }

        // الترقيم (اختياري)
        if ($perPage = $request->input('paginate')) {
            $orders = $query->paginate((int) $perPage);
        } else {
            $orders = $query->get();
        }

        // لو عايز الـ items ترجع مفلترة كمان (بس اللي من الكاتيجوري/البراند)
        if ($request->boolean('only_matching_items')) {
            $collection = $orders instanceof \Illuminate\Pagination\LengthAwarePaginator
                ? $orders->getCollection()
                : $orders;

            $collection->each(function ($order) use ($categoryIds, $brandId) {
                $order->setRelation(
                    'items',
                    $order->items->filter(function ($item) use ($categoryIds, $brandId) {
                        $product = $item->product;
                        if (!$product) {
                            return false;
                        }
                        if ($categoryIds && !in_array($product->category_id, $categoryIds)) {
                            return false;
                        }
                        if ($brandId && $product->brand_id != $brandId) {
                            return false;
                        }
                        return true;
                    })->values()
                );
            });
        }

        return response()->json([
            'orders' => $orders,
        ]);
    }


    /**
     * إنشاء طلب جديد.
     */
    public function store(StoreOrderRequest $request)
    {
        $data = $request->validated();

        // لو العميل مسجل دخول بناخد الـ id من التوكن بدل ما نثق في الـ request
        $userId = $request->user('sanctum')?->id;

        $calc = $this->orderService->calculate(
            $data['products'],
            $data['country'],
            $data['coupon_code'] ?? null
        );

        $receiptPath = null;

        if ($request->hasFile('receipt') && $data['payment_type'] !== 'cash') {
            $receiptPath = $this->orderService->storeReceipt($request->file('receipt'));
        }

        try {
            $order = DB::transaction(function () use ($data, $calc, $userId, $receiptPath) {

                $order = Order::create([
                    'user_id' => $userId,

                    'name' => $data['name'],
                    'company' => $data['company'] ?? null,
                    'phone' => $data['phone'],
                    'whatsapp_number' => $data['whatsapp_number'] ?? null,
                    'email' => $data['email'] ?? null,

                    'country' => $data['country'],
                    'state' => $data['state'] ?? null,
                    'governorate' => $data['governorate'] ?? null,
                    'city' => $data['city'],
                    'district' => $data['district'] ?? null,
                    'address' => $data['address'],
                    'latitude' => $data['latitude'] ?? null,
                    'longitude' => $data['longitude'] ?? null,
                    'notes' => $data['notes'] ?? null,

                    'payment_type' => $data['payment_type'],
                    'status' => 'pending',

                    'discount_coupon_id' => $calc['coupon']?->id,
                    'discount_amount' => $calc['discount_amount'],
                    'shipping_cost' => $calc['shipping_cost'],
                    'vat_percentage' => $calc['vat_percentage'],
                    'vat_amount' => $calc['vat_amount'],
                    'total_price' => $calc['total'],

                    'terms_accepted_at' => now(),
                ]);

                foreach ($calc['items'] as $item) {
                    OrderItem::create([
                        'order_id' => $order->id,
                        'product_id' => $item['product_id'],
                        'quantity' => $item['quantity'],
                        'price' => $item['price'],
                    ]);
                }

                $this->orderService->createPayment($order, $data, $receiptPath);

                return $order;
            });
        } catch (\Throwable $e) {
            // لو العملية فشلت نشيل الإيصال اللي اترفع للتو
            $this->orderService->discardUploadedReceipt($receiptPath);

            throw $e;
        }

        $order->load('items.product', 'coupon', 'latestPayment');

        $this->notifyOrderCreated($order, $receiptPath !== null);

        try {
            if ($userId) {
                UserNotification::create([
                    'user_id' => $userId,
                    'title' => 'تم استلام طلبك بنجاح',
                    'message' => "تم إنشاء طلبك رقم {$order->id} بنجاح. سنقوم بمعالجته قريبًا.",
                    'type' => 'order_created',
                    'data' => ['order_id' => $order->id],
                ]);
            }
        } catch (\Throwable $e) {
            Log::error('فشل إنشاء إشعار داخلي: ' . $e->getMessage());
        }

        return response()->json([
            'message' => 'تم إنشاء الطلب بنجاح',
            'order' => $order,
        ], 201);
    }

    /**
     * رسائل الواتساب بعد إنشاء الطلب.
     */
    protected function notifyOrderCreated(Order $order, bool $hasReceipt): void
    {
        $productsSummary = $this->orderService->productsSummary($order);
        $currency = $this->orderService->currency($order->country);

        $paymentLabels = [
            'cash' => 'كاش عند الاستلام',
            'vodafone_cash' => 'فودافون كاش',
            'instapay' => 'انستاباي',
        ];

        $paymentLabel = $paymentLabels[$order->payment_type] ?? $order->payment_type;

        $userMessage = "تأكيد استلام طلبك - شركة الأهرام\n\n" .
            "عزيزي {$order->name}، نشكرك على تسوقك معنا. تم استلام طلبك رقم {$order->id} بنجاح.\n\n" .
            "تفاصيل المنتجات:\n" .
            $productsSummary . "\n" .
            "تفاصيل الطلب:\n" .
            "- المجموع الكلي: {$order->total_price} {$currency}\n" .
            "- طريقة الدفع: {$paymentLabel}\n" .
            "- حالة الطلب: قيد الانتظار\n" .
            "- العنوان: {$order->address}\n\n" .
            ($hasReceipt ? "تم استلام إيصال الدفع وجاري مراجعته.\n\n" : '') .
            "سنقوم بمعالجة طلبك في أقرب وقت ممكن. شكرا لك.";

        $this->sendWhatsAppMessage($order->whatsapp_number ?: $order->phone, $userMessage);

        $adminMessage = "تنبيه: تم إنشاء طلب جديد في النظام\n\n" .
            "رقم الطلب: {$order->id}\n" .
            "العميل: {$order->name}\n" .
            "الجوال: {$order->phone}\n" .
            "المدينة: {$order->city}\n\n" .
            "المنتجات المطلوبة:\n" .
            $productsSummary . "\n" .
            "الإجمالي: {$order->total_price} {$currency}\n" .
            "طريقة الدفع: {$paymentLabel}\n" .
            ($hasReceipt ? "يوجد إيصال دفع محتاج مراجعة.\n" : '') .
            "\nيرجى مراجعة لوحة التحكم للمتابعة.";

        foreach ($this->adminUsers() as $admin) {
            $this->sendWhatsAppMessage($admin->phone, $adminMessage);
        }
    }

    /**
     * تحديث طلب.
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'sometimes|string|max:255',
            'company' => 'nullable|string|max:255',
            'phone' => 'sometimes|string|max:30',
            'whatsapp_number' => 'nullable|string|max:30',
            'email' => 'nullable|email|max:255',

            'country' => 'sometimes|in:eg,sa',
            'state' => 'nullable|string|max:255',
            'governorate' => 'nullable|string|max:255',
            'city' => 'sometimes|string|max:255',
            'district' => 'nullable|string|max:255',
            'address' => 'sometimes|required|string',
            'latitude' => 'nullable|numeric|between:-90,90',
            'longitude' => 'nullable|numeric|between:-180,180',
            'notes' => 'nullable|string|max:2000',

            'products' => 'sometimes|array|min:1',
            'products.*.product_id' => 'required_with:products|exists:products,id',
            'products.*.quantity' => 'required_with:products|integer|min:1',
            'coupon_code' => 'nullable|string|max:100',

            'status' => 'sometimes|in:pending,shipping,completed,paid,canceled',
        ]);

        $order = Order::with('items')->findOrFail($id);
        $oldStatus = $order->status;

        $fields = [
            'name', 'company', 'phone', 'whatsapp_number', 'email',
            'country', 'state', 'governorate', 'city', 'district',
            'address', 'latitude', 'longitude', 'notes', 'status',
        ];

        foreach ($fields as $field) {
            if ($request->has($field)) {
                $order->{$field} = $request->input($field);
            }
        }

        // إعادة حساب الأسعار لما المنتجات أو الكوبون أو الدولة تتغير
        $needsRecalculation = $request->has('products')
            || $request->has('coupon_code')
            || $request->has('country');

        if ($needsRecalculation) {

            if (
                $oldStatus === 'completed'
                || $order->payments()->where('status', 'approved')->exists()
            ) {
                throw ValidationException::withMessages([
                    'products' => 'مينفعش تعدّل الأسعار أو المنتجات بعد اكتمال الطلب أو اعتماد الدفع.',
                ]);
            }

            $products = $request->has('products')
                ? $request->input('products')
                : $order->items->map(fn ($item) => [
                    'product_id' => $item->product_id,
                    'quantity' => $item->quantity,
                ])->all();

            $couponCode = $request->has('coupon_code')
                ? $request->input('coupon_code')
                : $order->coupon?->code;

            $calc = $this->orderService->calculate($products, $order->country, $couponCode);

            DB::transaction(function () use ($order, $calc) {

                OrderItem::where('order_id', $order->id)->delete();

                foreach ($calc['items'] as $item) {
                    OrderItem::create([
                        'order_id' => $order->id,
                        'product_id' => $item['product_id'],
                        'quantity' => $item['quantity'],
                        'price' => $item['price'],
                    ]);
                }

                $order->discount_coupon_id = $calc['coupon']?->id;
                $order->discount_amount = $calc['discount_amount'];
                $order->shipping_cost = $calc['shipping_cost'];
                $order->vat_percentage = $calc['vat_percentage'];
                $order->vat_amount = $calc['vat_amount'];
                $order->total_price = $calc['total'];

                $order->save();

                // تحديث مبلغ آخر دفعة معلقة عشان يطابق الإجمالي الجديد
                $order->payments()
                    ->where('status', 'pending')
                    ->update(['amount' => $calc['total']]);
            });
        } else {
            $order->save();
        }

        // المخزون (عمود quantity في جدول المنتجات)
        if ($order->status === 'completed' && $oldStatus !== 'completed') {
            $this->orderService->decrementStock($order);
        } elseif ($oldStatus === 'completed' && $order->status !== 'completed') {
            $this->orderService->incrementStock($order);
        }

        $order->load('items.product', 'coupon', 'latestPayment');

        $this->notifyOrderUpdated($order, $oldStatus);

        return response()->json([
            'message' => 'تم تحديث الطلب بنجاح',
            'order' => $order,
        ]);
    }

    /**
     * رسائل الواتساب بعد تحديث الطلب (بس لو الحالة اتغيرت).
     */
    protected function notifyOrderUpdated(Order $order, string $oldStatus): void
    {
        if ($order->status === $oldStatus) {
            return;
        }

        $productsSummary = $this->orderService->productsSummary($order);
        $currency = $this->orderService->currency($order->country);

        $userMessage = "تحديث طلب - شركة الأهرام\n\n" .
            "عزيزي {$order->name}، تم تحديث حالة طلبك رقم {$order->id}.\n\n" .
            "الحالة الجديدة: " . strtoupper($order->status) . "\n\n" .
            "المنتجات في الطلب:\n" .
            $productsSummary . "\n" .
            "المجموع النهائي: {$order->total_price} {$currency}\n\n" .
            "نشكركم لتسوقكم معنا.";

        $this->sendWhatsAppMessage($order->whatsapp_number ?: $order->phone, $userMessage);

        $adminMessage = "تنبيه: تم تحديث طلب\n\n" .
            "رقم الطلب: {$order->id}\n" .
            "العميل: {$order->name}\n" .
            "الحالة الجديدة: {$order->status}\n\n" .
            "المنتجات:\n" .
            $productsSummary . "\n" .
            "الإجمالي: {$order->total_price} {$currency}";

        foreach ($this->adminUsers() as $admin) {
            $this->sendWhatsAppMessage($admin->phone, $adminMessage);
        }
    }

    /**
     * طلبات المستخدم الحالي.
     */
    public function myOrders()
    {
        $user = Auth::user();

        $orders = $user->orders()
            ->with('items.product', 'user', 'coupon', 'latestPayment')
            ->latest()
            ->get();

        return response()->json(['orders' => $orders]);
    }

    /**
     * عرض طلب بالتفاصيل (مع كل محاولات الدفع).
     */
   public function show($id)
{
    $order = Order::with('user', 'items.product', 'coupon', 'payments')->findOrFail($id);

    $user = Auth::user();
    $isAdmin = $user->hasAnyRole(['admin', 'director', 'employee']);

    if (!$isAdmin && $order->user_id !== $user->id) {
        abort(403, 'غير مصرح لك بمشاهدة هذا الطلب');
    }

    return response()->json(['order' => $order]);
}

    /**
     * حذف طلب (Soft Delete) لصاحب الصلاحية فقط.
     */
    public function destroy(Request $request, $id)
    {
        if (!$request->user() || !$request->user()->can('delete-financial-records')) {
            abort(403, 'غير مصرح لك بحذف الطلبات');
        }

        $order = Order::findOrFail($id);

        $order->delete();

        return response()->json([
            'message' => 'تم حذف الطلب (يمكن استرجاعه)',
        ]);
    }
}