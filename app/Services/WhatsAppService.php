<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class WhatsAppService
{
    public function sendText($phone, $message)
    {
        try {
            // تنظيف الرقم
            $phone = str_replace(['+', ' '], '', $phone);
            
            // استخدام الإعدادات من ملف .env
            $baseUrl = env('WHATSAPP_BASE_URL');
            $session = env('WHATSAPP_SESSION_NAME');

            $response = Http::post("{$baseUrl}/{$session}/send-text", [
                'to' => $phone,
                'message' => $message,
            ]);

            return $response->successful();
        } catch (\Exception $e) {
            Log::error("WhatsApp API Error: " . $e->getMessage());
            return false;
        }
    }
}