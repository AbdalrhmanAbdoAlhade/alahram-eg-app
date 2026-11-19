<?php

namespace App\Services;

use Carbon\Carbon;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class WhatsAppService
{
    /**
     * إرسال مباشر لرسالة نصية. بيرجّع true/false ومبيرميش استثناء.
     */
    public function sendText($phone, $message): bool
    {
        $to = $this->normalizePhone($phone);

        if (!$to) {
            Log::warning('WhatsApp: invalid phone number', ['phone' => $phone]);
            return false;
        }

        try {
            $response = Http::timeout(15)->acceptJson()->post(
                config('services.whatsapp.send_url'),
                [
                    'to' => $to,
                    'message' => $message,
                ]
            );

            if (!$response->successful()) {
                Log::error('WhatsApp API non-success', [
                    'status' => $response->status(),
                    'body' => $response->body(),
                ]);

                return false;
            }

            // السيرفر بيرجّع {"success":true,"sentCount":1}
            return $response->json('success') === true
                && (int) $response->json('sentCount', 0) > 0;
        } catch (\Throwable $e) {
            Log::error('WhatsApp API Error: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * 01012345678 -> 201012345678 | 0501234567 -> 966501234567
     * بيرجّع null لو الرقم مش منطقي.
     */
    public function normalizePhone($phone): ?string
    {
        $digits = preg_replace('/\D+/', '', (string) $phone);

        if ($digits === '') {
            return null;
        }

        if (str_starts_with($digits, '00')) {
            $digits = substr($digits, 2);
        }

        if (preg_match('/^01\d{9}$/', $digits)) {
            $digits = '20' . substr($digits, 1);
        } elseif (preg_match('/^05\d{8}$/', $digits)) {
            $digits = '966' . substr($digits, 1);
        }

        return preg_match('/^\d{10,15}$/', $digits) ? $digits : null;
    }

    /**
     * تنويع النص: "{مرحبا|أهلا} بك" -> نسخة عشوائية.
     */
    public function spin(string $text): string
    {
        return preg_replace_callback('/\{([^{}]+)\}/u', function ($m) {
            $options = array_map('trim', explode('|', $m[1]));

            return count($options) > 1
                ? $options[array_rand($options)]
                : $m[0];
        }, $text);
    }

    // ------------------------------------------------------------------
    // حماية الإرسال الجماعي
    // ------------------------------------------------------------------

    public function isQuietHours(): bool
    {
        $start = (int) config('services.whatsapp.quiet_start');
        $end = (int) config('services.whatsapp.quiet_end');
        $hour = Carbon::now('Africa/Cairo')->hour;

        return $start > $end
            ? ($hour >= $start || $hour < $end)
            : ($hour >= $start && $hour < $end);
    }

    public function isPaused(): bool
    {
        return Cache::has('wa:paused');
    }

    public function dailyRemaining(): int
    {
        $used = (int) Cache::get($this->dayKey(), 0);

        return max(0, (int) config('services.whatsapp.bulk_daily_limit') - $used);
    }

    public function countSent(): void
    {
        $key = $this->dayKey();

        Cache::add($key, 0, now()->addDays(2));
        Cache::increment($key);
    }

    /**
     * منع تكرار نفس الرسالة لنفس الرقم خلال 24 ساعة.
     */
    public function claimUnique(string $normalizedPhone, string $message): bool
    {
        return Cache::add('wa:dup:' . md5($normalizedPhone . '|' . $message), 1, now()->addDay());
    }

    public function releaseUnique(string $normalizedPhone, string $message): void
    {
        Cache::forget('wa:dup:' . md5($normalizedPhone . '|' . $message));
    }

    public function pause(int $minutes = 30): void
    {
        Cache::put('wa:paused', 1, now()->addMinutes($minutes));

        Log::critical("WhatsApp bulk paused for {$minutes} minutes after consecutive failures");
    }

    public function randomGap(): int
    {
        return random_int(
            (int) config('services.whatsapp.bulk_min_gap'),
            (int) config('services.whatsapp.bulk_max_gap')
        );
    }

    protected function dayKey(): string
    {
        return 'wa:bulk-count:' . Carbon::now('Africa/Cairo')->toDateString();
    }
}