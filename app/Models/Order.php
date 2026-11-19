<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Order extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'user_id',

        // بيانات العميل
        'name',
        'company',
        'phone',
        'whatsapp_number',
        'email',

        // العنوان
        'country',
        'state',
        'governorate',
        'city',
        'district',
        'address',
        'latitude',
        'longitude',
        'notes',

        // الطلب والدفع
        'payment_type',
        'status',
        'total_price',
        'discount_coupon_id',
        'discount_amount',
        'shipping_cost',
        'vat_percentage',
        'vat_amount',

        'terms_accepted_at',
    ];

    protected $casts = [
        'total_price' => 'decimal:2',
        'discount_amount' => 'decimal:2',
        'shipping_cost' => 'decimal:2',
        'vat_amount' => 'decimal:2',
        'vat_percentage' => 'decimal:2',
        'latitude' => 'decimal:7',
        'longitude' => 'decimal:7',
        'terms_accepted_at' => 'datetime',
    ];

    public function items()
    {
        return $this->hasMany(OrderItem::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function coupon()
    {
        return $this->belongsTo(DiscountCoupon::class, 'discount_coupon_id');
    }

    /**
     * كل محاولات الدفع للطلب (القديم المرفوض بيفضل في السجل).
     */
    public function payments()
    {
        return $this->hasMany(Payment::class);
    }

    /**
     * آخر محاولة دفع.
     */
    public function latestPayment()
    {
        return $this->hasOne(Payment::class)->latestOfMany();
    }
}