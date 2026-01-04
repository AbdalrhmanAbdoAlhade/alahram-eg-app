<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Jobs\SendWhatsAppMessageJob; 

class WhatsAppController extends Controller
{
    public function sendMessage(Request $request)
    {
        $request->validate([
            'to' => 'required|string',
            'message' => 'required|string',
        ]);

        SendWhatsAppMessageJob::dispatch($request->to, $request->message);

        return response()->json([
            'status' => true,
            'message' => 'تم إضافة الرسالة لطابور الإرسال بنجاح، ستصل خلال لحظات.',
        ]);
    }
  public function sendBulkMessage(Request $request)
{
    // نفترض أن الطلب يحتوي على مصفوفة أرقام ونص الرسالة
    $request->validate([
        'phones' => 'required|array', // مثال: ["010...", "012...", "015..."]
        'message' => 'required|string',
    ]);

    $phones = $request->input('phones');
    $message = $request->input('message');

    foreach ($phones as $phone) {
        // كل رقم يتم رميه في الطابور كـ Job منفصل
        \App\Jobs\SendWhatsAppMessageJob::dispatch($phone, $message);
    }

    return response()->json([
        'status' => true,
        'message' => 'تمت إضافة ' . count($phones) . ' رسالة إلى طابور الإرسال.',
    ]);
}
}