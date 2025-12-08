<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ShippingInfo extends Model
{
    protected $table = 'shipping_info'; // ← لتحديد اسم الجدول صراحة
    protected $fillable = ['description','description_en'];
}
