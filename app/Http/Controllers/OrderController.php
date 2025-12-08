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


class OrderController extends Controller
{
    // إنشاء طلب جديد


// عرض جميع الطلبات (للمشرف أو لوحة التحكم مثلاً)
public function index()
{
    $orders = Order::with('user', 'items.product', 'coupon')->latest()->get();

    return response()->json([
        'orders' => $orders,
    ]);
}


public function store(Request $request)
{
    $request->validate([
        'address' => 'required|string',
        'payment_type' => 'required|in:cash,online',
        'products' => 'required|array|min:1',
        'products.*.product_id' => 'required|exists:products,id',
        'products.*.quantity' => 'required|integer|min:1',
        'coupon_code' => 'nullable|string',
    ]);

    $user = Auth::user();
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
        $basePrice = $product->price;

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

    $order = Order::create([
        'user_id' => $user->id,
        'total_price' => $totalAfterDiscount,
        'address' => $request->address,
        'payment_type' => $request->payment_type,
        'discount_coupon_id' => $coupon?->id,
        'discount_amount' => $totalDiscountAmount,
        'status' => 'pending',
    ]);

    foreach ($orderItems as $item) {
        OrderItem::create([
            'order_id' => $order->id,
            'product_id' => $item['product']->id,
            'quantity' => $item['quantity'],
            'price' => $item['final_price'],
        ]);
    }

    return response()->json([
        'message' => 'تم إنشاء الطلب بنجاح',
        'order' => $order->load('items.product', 'coupon'),
        'summary' => [
            'total_before_discount' => $totalBeforeDiscount,
            'discount_amount' => $totalDiscountAmount,
            'total_after_discount' => $totalAfterDiscount,
        ]
    ]);
}


public function update(Request $request, $id)
{
    $request->validate([
        'address' => 'sometimes|required|string',
        'products' => 'sometimes|array|min:1',
        'products.*.product_id' => 'required_with:products|exists:products,id',
        'products.*.quantity' => 'required_with:products|integer|min:1',
        'coupon_code' => 'nullable|string',
        'status' => 'sometimes|in:pending,shipping,completed,canceled',
    ]);

    $order = Order::with('items')->findOrFail($id);

    // تحديث العنوان إن وجد
    if ($request->has('address')) {
        $order->address = $request->address;
    }

    // تحديث الحالة إن وجدت
    if ($request->has('status')) {
        $order->status = $request->status;
    }

    // محاولة العثور على كود الخصم إن وُجد
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
        // حذف العناصر القديمة
        OrderItem::where('order_id', $order->id)->delete();

        foreach ($request->products as $item) {
            $product = Product::findOrFail($item['product_id']);
            $quantity = $item['quantity'];
            $basePrice = $product->price;

            // الخصومات
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

            OrderItem::create([
                'order_id' => $order->id,
                'product_id' => $product->id,
                'quantity' => $quantity,
                'price' => $finalPrice,
            ]);
        }

        $order->total_price = $totalBeforeDiscount - $totalDiscountAmount;
        $order->discount_amount = $totalDiscountAmount;
    }

    $order->save();

    return response()->json([
        'message' => 'تم تحديث الطلب بنجاح',
        'order' => $order->load('items.product', 'coupon'),
    ]);
}



    // عرض طلبات المستخدم الحالي
    public function myOrders()
    {
        $user = Auth::user();

        $orders = $user->orders()->with('items.product', 'user', 'coupon')->latest()->get();

        return response()->json([
            'orders' => $orders,
        ]);
    }

    // عرض طلب معين بالتفصيل
    public function show($id)
    {
        $order = Order::with('user', 'items.product', 'coupon')->findOrFail($id);

        return response()->json([
            'order' => $order,
        ]);
    }
}
