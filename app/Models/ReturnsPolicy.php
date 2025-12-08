<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ReturnsPolicy extends Model
{
    protected $table = 'returns_policy'; // ← هذا هو التعديل المطلوب
    protected $fillable = ['description','description_en'];
}
