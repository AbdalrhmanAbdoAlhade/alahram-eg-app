<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    /**
     * الحقول التي يمكن تعبئتها جماعياً.
     * @var array
     */
    protected $fillable = [
        'name',
        'description',
        'image_url',
        'is_active',
    ];

    /**
     * تحديد نوع البيانات للحقول.
     * @var array
     */
    protected $casts = [
        'is_active' => 'boolean', // يضمن أن يتم التعامل مع هذا الحقل كـ Boolean (صحيح/خطأ)
    ];
}
