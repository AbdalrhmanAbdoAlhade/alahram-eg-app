<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StoreInfo extends Model
{
    protected $table = 'store_info';

    protected $fillable = [
        'name',
        'description',
        'logo',
        'footer_text',
        'phone_ar',
        'phone_eg',
        'Shipping_number',
        'email',
        'address',
        'social_media',
        'seo_description',
        'seo_keywords',
          'instapay_id',
    'vodafone_cash_number',
    ];

    protected $casts = [
        'social_media' => 'array',
        'stats' => 'boolean',
    ];
}