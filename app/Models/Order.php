<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
protected $fillable = [
    'user_id',
    'total_price',
    'status',
    'payment_type',
    'address',
    'discount_coupon_id',
    'discount_amount',
    'name',
    'phone',
    'email',
    'city',
    'delivery_area_id',
    'shipping_cost',    
    'paymob_order_id',
    'payment_token',
    'products',
    'coupon_code',
    'payment_id',
    'vat_amount',
    'vat_percentage',
   'country',
];


    public function items()
    {
        return $this->hasMany(OrderItem::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

public function deliveryArea()
{
    return $this->belongsTo(DeliveryArea::class);
}


public function coupon()
{
    return $this->belongsTo(DiscountCoupon::class, 'discount_coupon_id');
}
}
