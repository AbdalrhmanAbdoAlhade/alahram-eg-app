<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Banner extends Model
{
    protected $fillable = [
        'img',
        'media_type',
        'video',
        'title',
        'description',
        'title_en',
        'description_en',
        'category_id',
        'product_id',
    ];

    protected $appends = ['img_url', 'video_url'];

    public function getImgUrlAttribute()
    {
        return $this->img ? url($this->img) : null;
    }

    public function getVideoUrlAttribute()
    {
        return $this->video ? url($this->video) : null;
    }

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}