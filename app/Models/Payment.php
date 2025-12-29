<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    protected $fillable = [
        'user_id',
        'name',
        'phone',
        'email',
        'address',
        'city',
        'payment_type',
        'amount',
        'status',
        'paymob_order_id',
        'payment_token',
        'products',
        'coupon_code',
    ];

    // لو حابب تفك الـ products تلقائيًا من JSON
    protected $casts = [
        'products' => 'array',
    ];
}
