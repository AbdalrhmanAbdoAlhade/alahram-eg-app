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
        'phone',
         'Shipping_number',
        'email',
        'address',
        'facebook',
        'twitter',
        'instagram',
        'youtube',
        'whatsapp',
        'seo_description',
        'seo_keywords',
    ];
}
