<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use App\Models\DiscountCoupon;
use Illuminate\Support\Facades\Auth;
use App\Models\OfferBanner;
use App\Models\UserNotification;
use App\Models\User;
use App\Models\Setting;
use App\Models\DeliveryArea;
use Illuminate\Support\Facades\Log;
// استيراد الـ Job الجديد
use App\Jobs\SendWhatsAppMessageJob; 

class OrderController extends Controller
{
    /**
     * دالة مساعدة معدلة لإرسال رسائل الواتساب عبر نظام الطوابير
     */
    private function sendWhatsAppMessage($phone, $message)
    {
        // بدلاً من انتظار الـ API، نرسل المهمة للخلفية فوراً
        SendWhatsAppMessageJob::dispatch($phone, $message);
    }

    public function index()
    {
        $orders = Order::with('items.product', 'coupon')->latest()->get();

        return response()->json([
            'orders' => $orders,
        ]);
    }

    public function store(Request $request)
    {
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
            'area_id' => 'required|exists:delivery_areas,id',
            'country' => 'required|in:eg,sa', 
        ]);

        $userId = $request->user_id;
        $totalBeforeDiscount = 0;
        $totalDiscountAmount = 0;
        $coupon = null;

        if ($request->filled('coupon_code')) {
            $coupon = DiscountCoupon::where('code', $request->coupon_code)
                ->where('active', true)
                ->where('end_date', '>', now())
                ->first();
        }

        $orderItems = [];

        foreach ($request->products as $item) {
            $product = Product::findOrFail($item['product_id']);
            $quantity = $item['quantity'];
            
            $basePrice = $request->country === 'eg' ? $product->price_eg : $product->price_ar;

            $discounts = [];

            if ($product->discount && (!$product->discount_end_date || $product->discount_end_date > now())) {
                $discounts[] = $product->discount;
            }

            $offer = OfferBanner::where(function ($q) use ($product) {
                    $q->where('product_id', $product->id)
                      ->orWhere('category_id', $product->category_id);
                })
                ->where(function ($q) {
                    $q->whereNull('end_date')->orWhere('end_date', '>', now());
                })
                ->orderByDesc('discount')
                ->first();

            if ($offer && $offer->discount) {
                $discounts[] = $offer->discount;
            }

            if ($coupon) {
                $discounts[] = $coupon->discount;
            }

            $highestDiscount = !empty($discounts) ? max($discounts) : 0;
            $finalPrice = $basePrice - ($basePrice * $highestDiscount / 100);
            $totalBeforeDiscount += $basePrice * $quantity;
            $totalDiscountAmount += ($basePrice - $finalPrice) * $quantity;

            $orderItems[] = [
                'product' => $product,
                'quantity' => $quantity,
                'final_price' => $finalPrice,
            ];
        }

        $totalAfterDiscount = $totalBeforeDiscount - $totalDiscountAmount;

        $area = DeliveryArea::find($request->area_id);
        $shippingCost = $area->shipping_cost ?? 0;

        $freeShippingLimit = Setting::first()?->free_shipping_limit;

        if ($freeShippingLimit && $totalAfterDiscount >= $freeShippingLimit) {
            $shippingCost = 0;
        }

        $vatPercentage = Setting::first()?->vat ?? 0;
        $vatAmount = ($totalAfterDiscount + $shippingCost) * ($vatPercentage / 100);
        $finalTotal = $totalAfterDiscount + $shippingCost + $vatAmount;

        $order = Order::create([
            'user_id' => $userId,
            'name' => $request->name,
            'phone' => $request->phone,
            'email' => $request->email,
            'city' => $request->city,
            'address' => $request->address,
            'payment_type' => $request->payment_type,
            'discount_coupon_id' => $coupon?->id,
            'discount_amount' => $totalDiscountAmount,
            'total_price' => $finalTotal,
            'status' => 'pending',
            'area' => $area->name,
            'shipping_cost' => $shippingCost,
            'vat_percentage' => $vatPercentage,
            'vat_amount' => $vatAmount,
            'country' => $request->country,   
        ]);

        foreach ($orderItems as $item) {
            OrderItem::create([
                'order_id' => $order->id,
                'product_id' => $item['product']->id,
                'quantity' => $item['quantity'],
                'price' => $item['final_price'],
            ]);
        }

        // تحضير نص تفاصيل المنتجات للرسالة
        $productsSummary = "";
        foreach ($orderItems as $item) {
            $productsSummary .= "- " . $item['product']->name . " (العدد: " . $item['quantity'] . ")\n";
        }

        $currency = ($order->country == 'eg' ? 'ج.م' : 'ر.س');

        // 1. رسالة للمستخدم (عبر الطابور)
        $userWhatsappMessage = "تأكيد استلام طلبك - شركة الأهرام\n\n" .
            "عزيزي {$order->name}، نشكرك على تسوقك معنا. تم استلام طلبك رقم {$order->id} بنجاح.\n\n" .
            "تفاصيل المنتجات:\n" .
            $productsSummary . "\n" .
            "تفاصيل الطلب:\n" .
            "- المجموع الكلي: {$order->total_price} {$currency}\n" .
            "- حالة الطلب: قيد الانتظار\n" .
            "- العنوان: {$order->address}\n\n" .
            "سنقوم بمعالجة طلبك في أقرب وقت ممكن. شكرا لك.";
        
        $this->sendWhatsAppMessage($order->phone, $userWhatsappMessage);

        // 2. رسالة للأدمن (عبر الطابور)
        $admins = User::where('role', 'admin')->get();
        foreach ($admins as $admin) {
            if ($admin->phone) {
                $adminWhatsappMessage = "تنبيه: تم إنشاء طلب جديد في النظام\n\n" .
                    "رقم الطلب: {$order->id}\n" .
                    "العميل: {$order->name}\n" .
                    "الجوال: {$order->phone}\n" .
                    "المدينة: {$order->city}\n\n" .
                    "المنتجات المطلوبة:\n" .
                    $productsSummary . "\n" .
                    "الإجمالي: {$order->total_price} {$currency}\n" .
                    "طريقة الدفع: {$order->payment_type}\n\n" .
                    "يرجى مراجعة لوحة التحكم للمتابعة.";
                
                $this->sendWhatsAppMessage($admin->phone, $adminWhatsappMessage);
            }
        }

        // --- إنشاء الإشعارات الداخلية ---
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
        } catch (\Exception $e) {
            Log::error('فشل إنشاء إشعار داخلي: ' . $e->getMessage());
        }

        return response()->json([
            'message' => 'تم إنشاء الطلب بنجاح وجارٍ إرسال الإشعارات عبر واتساب في الخلفية',
            'order' => $order->load('items.product', 'coupon'),
        ]);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'sometimes|string|max:255',
            'phone' => 'sometimes|string|max:20',
            'email' => 'sometimes|email|max:255',
            'city' => 'sometimes|string|max:255',
            'address' => 'sometimes|required|string',
            'products' => 'sometimes|array|min:1',
            'products.*.product_id' => 'required_with:products|exists:products,id',
            'products.*.quantity' => 'required_with:products|integer|min:1',
            'coupon_code' => 'nullable|string',
            'status' => 'sometimes|in:pending,shipping,completed,paid,canceled',
            'area_id' => 'sometimes|exists:delivery_areas,id',
            'country' => 'sometimes|in:eg,sa',
        ]);

        $order = Order::with('items.product')->findOrFail($id);
        $oldStatus = $order->status;

        if ($request->has('name')) $order->name = $request->name;
        if ($request->has('phone')) $order->phone = $request->phone;
        if ($request->has('email')) $order->email = $request->email;
        if ($request->has('city')) $order->city = $request->city;
        if ($request->has('address')) $order->address = $request->address;
        if ($request->has('status')) $order->status = $request->status;
        if ($request->has('country')) $order->country = $request->country;

        $coupon = null;
        if ($request->filled('coupon_code')) {
            $coupon = DiscountCoupon::where('code', $request->coupon_code)
                ->where('active', true)
                ->where('end_date', '>', now())
                ->first();
            $order->discount_coupon_id = $coupon?->id;
        }

        $totalBeforeDiscount = 0;
        $totalDiscountAmount = 0;

        if ($request->has('products')) {
            OrderItem::where('order_id', $order->id)->delete();

            foreach ($request->products as $item) {
                $product = Product::findOrFail($item['product_id']);
                $quantity = $item['quantity'];
                
                $country = $request->has('country') ? $request->country : $order->country;
                $basePrice = $country === 'eg' ? $product->price_eg : $product->price_ar;

                $discounts = [];
                if ($product->discount && (!$product->discount_end_date || $product->discount_end_date > now())) {
                    $discounts[] = $product->discount;
                }

                $offer = OfferBanner::where(function ($q) use ($product) {
                        $q->where('product_id', $product->id)->orWhere('category_id', $product->category_id);
                    })
                    ->where(function ($q) {
                        $q->whereNull('end_date')->orWhere('end_date', '>', now());
                    })
                    ->orderByDesc('discount')->first();

                if ($offer) $discounts[] = $offer->discount;
                if ($coupon) $discounts[] = $coupon->discount;

                $highestDiscount = !empty($discounts) ? max($discounts) : 0;
                $finalPrice = $basePrice - ($basePrice * $highestDiscount / 100);

                $totalBeforeDiscount += $basePrice * $quantity;
                $totalDiscountAmount += ($basePrice - $finalPrice) * $quantity;

                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'quantity' => $quantity,
                    'price' => $finalPrice,
                ]);
            }
        } else {
            foreach ($order->items as $item) {
                $totalBeforeDiscount += $item->price * $item->quantity;
            }
        }

        if ($request->has('area_id')) {
            $area = DeliveryArea::find($request->area_id);
            $order->area = $area->name;
            $shippingCost = $area->shipping_cost ?? 0;
        } else {
            $shippingCost = $order->shipping_cost ?? 0;
        }

        $totalAfterDiscount = $totalBeforeDiscount - $totalDiscountAmount;
        $freeShippingLimit = Setting::first()?->free_shipping_limit;
        if ($freeShippingLimit && $totalAfterDiscount >= $freeShippingLimit) {
            $shippingCost = 0;
        }

        $vatPercentage = Setting::first()?->vat ?? 0;
        $vatAmount = ($totalAfterDiscount + $shippingCost) * ($vatPercentage / 100);

        $order->vat_percentage = $vatPercentage;
        $order->vat_amount = $vatAmount;
        $order->total_price = $totalAfterDiscount + $shippingCost + $vatAmount;
        $order->discount_amount = $totalDiscountAmount;
        $order->shipping_cost = $shippingCost;

        $order->save();

        if ($order->status === 'completed' && $oldStatus !== 'completed') {
            foreach ($order->items as $item) {
                $item->product->decrement('stock', $item->quantity);
            }
        }

        // --- إرسال رسائل الواتساب المحدثة (عبر الطابور) ---
        $productsSummary = "";
        foreach ($order->load('items.product')->items as $item) {
            $productsSummary .= "- " . $item->product->name . " (العدد: " . $item->quantity . ")\n";
        }

        $currency = ($order->country == 'eg' ? 'ج.م' : 'ر.س');

        // 1. رسالة المستخدم
        $userWhatsappMessage = "تحديث طلب - شركة الأهرام\n\n" .
            "عزيزي {$order->name}، تم تحديث حالة طلبك رقم {$order->id} بنجاح.\n\n" .
            "الحالة الجديدة: " . strtoupper($order->status) . "\n\n" .
            "المنتجات في الطلب:\n" .
            $productsSummary . "\n" .
            "المجموع النهائي: {$order->total_price} {$currency}\n\n" .
            "نشكركم لتسوقكم معنا.";

        $this->sendWhatsAppMessage($order->phone, $userWhatsappMessage);

        // 2. رسالة الأدمن
        $admins = User::where('role', 'admin')->get();
        $adminWhatsappMessage = " تنبيه: تم تحديث طلب\n\n" .
            "رقم الطلب: {$order->id}\n" .
            "العميل: {$order->name}\n" .
            "الحالة الجديدة: {$order->status}\n\n" .
            "المنتجات:\n" .
            $productsSummary . "\n" .
            "الإجمالي الجديد: {$order->total_price} {$currency}";

        foreach ($admins as $admin) {
            if ($admin->phone) {
                $this->sendWhatsAppMessage($admin->phone, $adminWhatsappMessage);
            }
        }

        return response()->json([
            'message' => 'تم تحديث الطلب والمخزن بنجاح، الإشعارات قيد الإرسال',
            'order' => $order->load('items.product')
        ]);
    }

    public function myOrders()
    {
        $user = Auth::user();
        $orders = $user->orders()->with('items.product', 'user', 'coupon')->latest()->get();
        return response()->json(['orders' => $orders]);
    }

    public function show($id)
    {
        $order = Order::with('user', 'items.product', 'coupon')->findOrFail($id);
        return response()->json(['order' => $order]);
    }
}