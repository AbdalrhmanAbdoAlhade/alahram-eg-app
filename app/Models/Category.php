<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $fillable = [
        'img',
        'banner',
        'name',
        'banner_status',
        'description',
        'description_en',
        'name_en',
        'button_title',
         'parent_id',
    ];

    public function products()
    {
        return $this->hasMany(Product::class);
    }

    public function banners()
    {
        return $this->hasMany(Banner::class);
    }
    public function parent()
{
    return $this->belongsTo(Category::class, 'parent_id');
}

public function children()
{
    return $this->hasMany(Category::class, 'parent_id');
}

}
