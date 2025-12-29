<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class WhatsAppController extends Controller
{
    public function sendMessage(Request $request)
    {
        $request->validate([
            'to' => 'required|string',
            'message' => 'required|string',
        ]);

        $response = Http::post(
            'http://w.alahrm.com/api/sessions/abdo/send-text',
            [
                'to' => $request->to,
                'message' => $request->message,
            ]
        );

        if ($response->successful()) {
            return response()->json([
                'status' => true,
                'message' => 'تم إرسال رسالة الواتساب بنجاح',
                'data' => $response->json(),
            ]);
        }

        return response()->json([
            'status' => false,
            'message' => 'فشل في إرسال رسالة الواتساب',
            'error' => $response->body(),
        ], 500);
    }
}
