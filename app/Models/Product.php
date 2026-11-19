<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
        'category_id',
        'brand_id',
        'productType',
        'img',
        'images',
        'name',
        'name_en',
        'code',
        'price_eg',
        'price_ar',
        'description',
        'description_en',
        'discount',
        'specs',
        'quantity',
        'isFeatured',
        'discount_end_date',
        'rating',
        'seo_keywords',
        'seo_description',
        'youtube_video_url',
    ];

    protected $casts = [
        'images' => 'array',
        'specs'  => 'array',
    ];

    // نخفي الـ relation الأصلي و type_id
    protected $hidden = [
        'type_id',
        'productType', // الـ relation الأصلي
    ];

    // نضيف attribute اسمه type
    protected $appends = [
        'type',
    ];

    /**
     * العلاقة الأصلية (مخفية)
     */
    public function productType()
    {
        return $this->belongsTo(ProductType::class, 'type_id');
    }

    /**
     * يرجع اسم النوع فقط
     */
    public function getTypeAttribute()
    {
        // لو العلاقة متحمّلة استخدمها
        if ($this->relationLoaded('productType')) {
            return $this->productType?->name;
        }

        // لو مش متحمّلة نرجع null أو نعملها load
        return $this->productType?->name;
    }

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function brand()
    {
        return $this->belongsTo(Brand::class);
    }

    public function reviews()
    {
        return $this->hasMany(ProductReview::class);
    }

    public function steps()
    {
        return $this->hasMany(ProductStep::class)
            ->orderBy('step_number');
    }

    public function orderItems()
    {
        return $this->hasMany(OrderItem::class);
    }
}