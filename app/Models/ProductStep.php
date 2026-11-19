<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductStep extends Model
{
    protected $fillable = [
        'product_id',
        'step_number',
        'title',
        'description',
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}
