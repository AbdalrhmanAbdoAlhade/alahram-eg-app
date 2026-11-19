<?php

namespace App\Services;

use App\Models\DiscountCoupon;
use App\Models\Order;
use App\Models\OfferBanner;
use App\Models\Payment;
use App\Models\Product;
use App\Models\Setting;
use Carbon\Carbon;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class OrderService
{
    /**
     * حساب الأسعار والخصومات والشحن والـ VAT.
     *
     * $products = [['product_id' => 1, 'quantity' => 2], ...]
     * $country  = 'eg' | 'sa'
     */
    public function calculate(array $products, string $country, ?string $couponCode = null): array
    {
        $coupon = $this->resolveCoupon($couponCode);

        // دمج المنتجات المكررة في نفس السلة
        $merged = [];

        foreach ($products as $row) {
            $id = (int) $row['product_id'];
            $merged[$id] = ($merged[$id] ?? 0) + (int) $row['quantity'];
        }

        $productModels = Product::whereIn('id', array_keys($merged))
            ->get()
            ->keyBy('id');

        $items = [];
        $subtotal = 0;
        $discountAmount = 0;

        foreach ($merged as $productId => $quantity) {
            $product = $productModels->get($productId);

            if (!$product) {
                throw ValidationException::withMessages([
                    'products' => "المنتج رقم {$productId} غير موجود.",
                ]);
            }

            $basePrice = (float) ($country === 'eg' ? $product->price_eg : $product->price_ar);

            $highestDiscount = $this->highestDiscount($product, $coupon);

            $finalPrice = $basePrice - ($basePrice * $highestDiscount / 100);

            $subtotal += $basePrice * $quantity;
            $discountAmount += ($basePrice - $finalPrice) * $quantity;

            $items[] = [
                'product' => $product,
                'product_id' => $product->id,
                'quantity' => $quantity,
                'price' => round($finalPrice, 2),
            ];
        }

        // الشحن متوقف مؤقتًا بعد إلغاء مناطق التوصيل
        $shippingCost = 0;

        $totals = $this->buildTotals($subtotal, $discountAmount, $shippingCost);

        return array_merge($totals, [
            'items' => $items,
            'coupon' => $coupon,
        ]);
    }

    /**
     * حساب الإجماليات من مجموع الأسعار والخصم والشحن.
     * بتتستخدم في الإنشاء وفي التعديل لما المنتجات متتغيرش.
     */
    public function buildTotals(float $subtotal, float $discountAmount, float $shippingCost = 0): array
    {
        $totalAfterDiscount = $subtotal - $discountAmount;

        $vatPercentage = (float) (Setting::first()?->vat ?? 0);
        $vatAmount = ($totalAfterDiscount + $shippingCost) * ($vatPercentage / 100);

        $total = $totalAfterDiscount + $shippingCost + $vatAmount;

        return [
            'subtotal' => round($subtotal, 2),
            'discount_amount' => round($discountAmount, 2),
            'shipping_cost' => round($shippingCost, 2),
            'vat_percentage' => round($vatPercentage, 2),
            'vat_amount' => round($vatAmount, 2),
            'total' => round($total, 2),
        ];
    }

    /**
     * رفع الإيصال (jpg / png / pdf) وإرجاع المسار النسبي.
     */
    public function storeReceipt(UploadedFile $file): string
    {
        $destinationPath = public_path('receipts');

        if (!file_exists($destinationPath)) {
            mkdir($destinationPath, 0755, true);
        }

        $fileName = Str::uuid() . '.' . $file->getClientOriginalExtension();

        $file->move($destinationPath, $fileName);

        return 'receipts/' . $fileName;
    }

    /**
     * تنظيف إيصال اترفع وفشل الطلب بعده (مش بنستخدمها لحذف إيصالات حقيقية).
     */
    public function discardUploadedReceipt(?string $path): void
    {
        if ($path && file_exists(public_path($path)) && is_file(public_path($path))) {
            unlink(public_path($path));
        }
    }

    /**
     * إنشاء سجل دفع جديد للطلب (بحالة pending).
     */
    public function createPayment(Order $order, array $data, ?string $receiptPath = null): Payment
    {
        return $order->payments()->create([
            'method' => $data['payment_type'],
            'amount' => $order->total_price,
            'sender_phone' => $data['sender_phone'] ?? null,
            'reference_number' => $data['reference_number'] ?? null,
            'receipt_path' => $receiptPath,
            'status' => Payment::STATUS_PENDING,
        ]);
    }

    /**
     * خصم المخزون عند اكتمال الطلب (عمود quantity في جدول المنتجات).
     */
    public function decrementStock(Order $order): void
    {
        $order->loadMissing('items');

        foreach ($order->items as $item) {
            Product::where('id', $item->product_id)
                ->decrement('quantity', $item->quantity);
        }
    }

    /**
     * رجوع المخزون لو الطلب كان completed واتغيرت حالته.
     */
    public function incrementStock(Order $order): void
    {
        $order->loadMissing('items');

        foreach ($order->items as $item) {
            Product::where('id', $item->product_id)
                ->increment('quantity', $item->quantity);
        }
    }

    /**
     * رسالة تفاصيل المنتجات للواتساب.
     */
    public function productsSummary(Order $order): string
    {
        $order->loadMissing('items.product');

        $summary = '';

        foreach ($order->items as $item) {
            $summary .= '- ' . ($item->product->name ?? 'منتج محذوف')
                . ' (العدد: ' . $item->quantity . ")\n";
        }

        return $summary;
    }

    public function currency(string $country): string
    {
        return $country === 'eg' ? 'ج.م' : 'ر.س';
    }

    // ------------------------------------------------------------------

    protected function resolveCoupon(?string $code): ?DiscountCoupon
    {
        if (!$code) {
            return null;
        }

        $coupon = DiscountCoupon::where('code', $code)
            ->where('active', true)
            ->where('end_date', '>', now())
            ->first();

        if (!$coupon) {
            throw ValidationException::withMessages([
                'coupon_code' => 'كود الخصم غير صالح أو منتهي.',
            ]);
        }

        return $coupon;
    }

    /**
     * أعلى نسبة خصم من (خصم المنتج، العرض، الكوبون).
     */
    protected function highestDiscount(Product $product, ?DiscountCoupon $coupon): float
    {
        $discounts = [];

        if (
            $product->discount
            && (!$product->discount_end_date || Carbon::parse($product->discount_end_date)->gt(now()))
        ) {
            $discounts[] = (float) $product->discount;
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
            $discounts[] = (float) $offer->discount;
        }

        if ($coupon) {
            $discounts[] = (float) $coupon->discount;
        }

        return !empty($discounts) ? max($discounts) : 0;
    }
}