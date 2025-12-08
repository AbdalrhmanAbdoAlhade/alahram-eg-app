<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OfferBanner extends Model
{
    protected $fillable = [
        'img',
        'img_status',
        'title',
        'description',
        'title_en',
        'description_en',
        'category_id',
        'product_id',
        'end_date',
        'discount',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}
