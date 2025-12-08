<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\Order;
use Illuminate\Support\Facades\Log;

class PaymentController extends Controller
{
    public function pay(Request $request)
    {
        // validate input
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'amount' => 'required|numeric',
            'name' => 'required|string',
            'phone' => 'required|string',
        ]);

        // Step 1: Get Auth Token
        $authResponse = Http::post('https://oman.paymob.com/api/auth/tokens', [
            'api_key' => env('PAYMOB_API_KEY'),
        ]);

        if (!isset($authResponse['token'])) {
            return response()->json(['error' => 'فشل في الحصول على التوكن من Paymob', 'response' => $authResponse->json()], 500);
        }

        $authToken = $authResponse['token'];

        // Step 2: Create Order on Paymob
        $orderData = [
            "auth_token" => $authToken,
            "delivery_needed" => false,
            "amount_cents" => $request->amount * 100, // Paymob uses cents
            "items" => []
        ];

        $orderResponse = Http::post('https://oman.paymob.com/api/ecommerce/orders', $orderData);
        if (!isset($orderResponse['id'])) {
            return response()->json(['error' => 'فشل في إنشاء الطلب على Paymob', 'response' => $orderResponse->json()], 500);
        }

        $paymobOrderId = $orderResponse['id'];

        // Step 3: Generate Payment Key
        $billingData = [
            "apartment" => "NA",
            "email" => "test@example.com",
            "floor" => "NA",
            "first_name" => $request->name,
            "street" => "NA",
            "building" => "NA",
            "phone_number" => $request->phone,
            "shipping_method" => "NA",
            "postal_code" => "NA",
            "city" => "NA",
            "country" => "NA",
            "last_name" => "User",
            "state" => "NA"
        ];

        $paymentKeyData = [
            "auth_token" => $authToken,
            "amount_cents" => $request->amount * 100,
            "expiration" => 3600,
            "order_id" => $paymobOrderId,
            "billing_data" => $billingData,
            "currency" => "OMR",
            "integration_id" => env('PAYMOB_INTEGRATION_ID'),
        ];

        $paymentKeyResponse = Http::post('https://oman.paymob.com/api/acceptance/payment_keys', $paymentKeyData);
        if (!isset($paymentKeyResponse['token'])) {
            return response()->json(['error' => 'فشل في إنشاء Payment Key', 'response' => $paymentKeyResponse->json()], 500);
        }

        $paymentToken = $paymentKeyResponse['token'];

        // Step 4: Save order in database
        $order = Order::create([
            'user_id' => $request->user_id,
            'total_price' => $request->amount,
            'status' => 'pending',
        ]);

        return response()->json([
            'iframe_url' => "https://oman.paymob.com/api/acceptance/iframes/" . env('PAYMOB_IFRAME_ID') . "?payment_token=" . $paymentToken,
            'order_id' => $order->id,
        ]);
    }
}
