<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use App\Models\Payment; // Assuming you have a Payment model
use App\Models\Order;   // Assuming you have an Order model
use App\Models\Product; 
class PaymentController extends Controller
{

    /**
     * ✅ Update payment status by ID
     */
    public function updateStatus(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'status' => 'required|in:pending,paid,failed,canceled',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'حالة غير صالحة'], 422);
        }

        $payment = Payment::find($id);

        if (!$payment) {
            return response()->json(['error' => 'لم يتم العثور على الدفع'], 404);
        }

        $payment->status = $request->status;
        $payment->save();

        Log::info('Payment status updated', ['payment_id' => $id, 'new_status' => $request->status]);

        return response()->json([
            'message' => 'تم تحديث الحالة بنجاح',
            'payment' => $payment
        ]);
    }

    /**
     * ✅ Get payment details by ID
     */
public function index()
{
    $payments = Payment::latest()->get(); // تجيب كل المدفوعات حسب الأحدث

    return response()->json([
        'status' => true,
        'payments' => $payments
    ]);
}



    public function pay(Request $request)
    {
        // Step 1: Validate input
        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string|max:20',
            'email' => 'required|email|max:255',
            'address' => 'required|string',
            'city' => 'required|string|max:255',
            'payment_type' => 'required|in:cash,online',
            'products' => 'required|array|min:1',
            'products.*.product_id' => 'required|exists:products,id',
            'products.*.quantity' => 'required|integer|min:1',
            'coupon_code' => 'nullable|string',
            'user_id' => 'nullable|exists:users,id',
            'amount' => 'required|numeric',
        ]);

        Log::info('Starting payment process', $request->all());

        // Step 2: Get Auth Token from Paymob
        $authResponse = Http::post('https://oman.paymob.com/api/auth/tokens', [
            'api_key' => env('PAYMOB_API_KEY'),
        ]);

        if (!isset($authResponse['token'])) {
            Log::error('Failed to get auth token from Paymob', $authResponse->json());
            return response()->json([
                'error' => 'فشل في الحصول على التوكن من Paymob',
                'response' => $authResponse->json()
            ], 500);
        }

        $authToken = $authResponse['token'];
        Log::info('Received auth token from Paymob', ['token' => $authToken]);

        // Step 3: Create Paymob Order
        $orderData = [
            "auth_token" => $authToken,
            "delivery_needed" => false,
            "amount_cents" => $request->amount * 100,
            "items" => [] // You might want to populate this with actual product details
        ];

        $orderResponse = Http::post('https://oman.paymob.com/api/ecommerce/orders', $orderData);

        if (!isset($orderResponse['id'])) {
            Log::error('Failed to create order on Paymob', $orderResponse->json());
            return response()->json([
                'error' => 'فشل في إنشاء الطلب على Paymob',
                'response' => $orderResponse->json()
            ], 500);
        }

        $paymobOrderId = $orderResponse['id'];
        Log::info('Paymob order created successfully', ['order_id' => $paymobOrderId]);

        // Step 4: Generate Payment Key
        $billingData = [
            "apartment" => "NA", // Consider making these dynamic if applicable
            "email" => $request->email,
            "floor" => "NA",     // Consider making these dynamic if applicable
            "first_name" => $request->name,
            "street" => $request->address,
            "building" => "NA",  // Consider making these dynamic if applicable
            "phone_number" => $request->phone,
            "shipping_method" => "NA", // Consider making these dynamic if applicable
            "postal_code" => "NA",     // Consider making these dynamic if applicable
            "city" => $request->city,
            "country" => "OM", // Ensure this is correct for Oman
            "last_name" => "NA", // If you collect full name, split it
            "state" => "NA"      // Consider making these dynamic if applicable
        ];

        $paymentKeyData = [
            "auth_token" => $authToken,
            "amount_cents" => $request->amount * 100,
            "expiration" => 3600, // 1 hour expiration
            "order_id" => $paymobOrderId,
            "billing_data" => $billingData,
            "currency" => "OMR", // Ensure this is correct for Oman Rial
            "integration_id" => env('PAYMOB_INTEGRATION_ID'),
        ];

        $paymentKeyResponse = Http::post('https://oman.paymob.com/api/acceptance/payment_keys', $paymentKeyData);

        if (!isset($paymentKeyResponse['token'])) {
            Log::error('Failed to generate payment key', $paymentKeyResponse->json());
            return response()->json([
                'error' => 'فشل في إنشاء Payment Key',
                'response' => $paymentKeyResponse->json()
            ], 500);
        }

        $paymentToken = $paymentKeyResponse['token'];
        Log::info('Payment key generated successfully', ['payment_token' => $paymentToken]);

        // Step 5: Save payment and order in database
        $payment = Payment::create([
            'user_id' => $request->user_id,
            'name' => $request->name,
            'phone' => $request->phone,
            'email' => $request->email,
            'address' => $request->address,
            'city' => $request->city,
            'payment_type' => $request->payment_type,
            'amount' => $request->amount,
            'status' => 'pending',
            'paymob_order_id' => $paymobOrderId,
            'payment_token' => $paymentToken,
            'products' => json_encode($request->products),
            'coupon_code' => $request->coupon_code,
        ]);
        Log::info('Payment saved to database', ['payment_id' => $payment->id]);

        $order = Order::create([
            'user_id' => $request->user_id,
            'name' => $request->name,
            'phone' => $request->phone,
            'email' => $request->email,
            'address' => $request->address,
            'city' => $request->city,
            'payment_type' => $request->payment_type,
            'total_price' => $request->amount,
            'status' => 'pending',
            'paymob_order_id' => $paymobOrderId,
            'payment_token' => $paymentToken, // <-- **Added this line**
            'products' => json_encode($request->products),
            'coupon_code' => $request->coupon_code,
            'payment_id' => $payment->id,
        ]);
        Log::info('Order saved to database', ['order_id' => $order->id]);


        // Step 6: Return iframe URL
        $iframeUrl = "https://oman.paymob.com/api/acceptance/iframes/" . env('PAYMOB_IFRAME_ID') . "?payment_token=" . $paymentToken;
        Log::info('Returning iframe URL', ['iframe_url' => $iframeUrl]);

        return response()->json([
            'iframe_url' => $iframeUrl,
            'payment_id' => $payment->id,
            'order_id' => $order->id, // Also return order_id for reference
        ]);
    }
}
