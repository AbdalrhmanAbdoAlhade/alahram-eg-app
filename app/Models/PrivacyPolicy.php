<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PrivacyPolicy extends Model
{
    protected $table = 'privacy_policy'; // ← أضف هذا السطر
    protected $fillable = ['description','description_en'];
}
