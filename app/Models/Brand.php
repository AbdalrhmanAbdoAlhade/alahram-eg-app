<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Brand extends Model
{
    protected $fillable = [
        'img',
        'name',
        'link',
    ];

    public function products()
    {
        return $this->hasMany(Product::class);
    }
}
