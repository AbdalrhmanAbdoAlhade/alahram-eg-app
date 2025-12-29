<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DeliveryArea extends Model
{
    protected $fillable = ['name', 'name_en', 'shipping_cost'];

    public function orders()
    {
        return $this->hasMany(Order::class);
    }
}
