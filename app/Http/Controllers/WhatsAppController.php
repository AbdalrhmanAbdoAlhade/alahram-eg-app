<?php

namespace App\Http\Controllers;

use App\Services\WhatsAppService;
use Illuminate\Http\Request;

class WhatsAppController extends Controller
{
    public function __construct(protected WhatsAppService $whatsapp)
    {
    }

    /**
     * رسالة لرقم واحد (مباشرة).
     */
    public function sendMessage(Request $request)
    {
        $data = $request->validate([
            'to' => 'required|string|max:30',
            'message' => 'required|string|max:4096',
        ]);

        if (!$this->whatsapp->normalizePhone($data['to'])) {
            return response()->json([
                'status' => false,
                'message' => 'رقم الهاتف غير صالح',
            ], 422);
        }

        $sent = $this->whatsapp->sendText($data['to'], $this->whatsapp->spin($data['message']));

        return response()->json([
            'status' => $sent,
            'message' => $sent ? 'تم إرسال الرسالة بنجاح' : 'فشل إرسال الرسالة',
        ], $sent ? 200 : 502);
    }

    /**
     * رسائل جماعية مباشرة، بفاصل عشوائي بين كل رسالة وحماية من الحظر.
     */
    public function sendBulkMessage(Request $request)
    {
        $data = $request->validate([
            'phones' => 'required|array|min:1|max:10',
            'phones.*' => 'required|string|max:30',
            'message' => 'required|string|max:4096',
        ]);

        if ($this->whatsapp->isQuietHours()) {
            return response()->json([
                'status' => false,
                'message' => 'الإرسال الجماعي ممنوع في ساعات الهدوء (11 م - 9 ص).',
            ], 422);
        }

        if ($this->whatsapp->isPaused()) {
            return response()->json([
                'status' => false,
                'message' => 'الإرسال الجماعي متوقف مؤقتًا بسبب فشل متكرر. راجع جلسة الواتساب وجرب بعد 30 دقيقة.',
            ], 503);
        }

        // توحيد الأرقام وإزالة التكرار
        $phones = [];
        $invalid = [];

        foreach ($data['phones'] as $phone) {
            $normalized = $this->whatsapp->normalizePhone($phone);

            if (!$normalized) {
                $invalid[] = $phone;
                continue;
            }

            $phones[$normalized] = $phone;
        }

        // السكريبت بيستنى بين الرسائل، فلازم ميتقطعش
        set_time_limit(0);
        ignore_user_abort(true);

        $sent = [];
        $failed = [];
        $duplicates = [];
        $overLimit = [];
        $consecutiveFails = 0;
        $first = true;

        foreach ($phones as $normalized => $phone) {

            if ($this->whatsapp->dailyRemaining() <= 0) {
                $overLimit[] = $phone;
                continue;
            }

            if (!$this->whatsapp->claimUnique($normalized, $data['message'])) {
                $duplicates[] = $phone;
                continue;
            }

            if (!$first) {
                sleep($this->whatsapp->randomGap());
            }

            $first = false;

            $ok = $this->whatsapp->sendText($phone, $this->whatsapp->spin($data['message']));

            if ($ok) {
                $this->whatsapp->countSent();
                $sent[] = $phone;
                $consecutiveFails = 0;
                continue;
            }

            // فشل: نسمح بإعادة المحاولة لنفس الرقم بعدين
            $this->whatsapp->releaseUnique($normalized, $data['message']);
            $failed[] = $phone;
            $consecutiveFails++;

            if ($consecutiveFails >= 3) {
                $this->whatsapp->pause(30);
                break;
            }
        }

        return response()->json([
            'status' => count($sent) > 0,
            'sent_count' => count($sent),
            'sent' => $sent,
            'failed' => $failed,
            'skipped_invalid' => $invalid,
            'skipped_duplicate' => $duplicates,
            'skipped_over_limit' => $overLimit,
            'paused' => $this->whatsapp->isPaused(),
        ]);
    }
}