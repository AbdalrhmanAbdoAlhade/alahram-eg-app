<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AboutUs extends Model
{
    protected $fillable = [
        'title',
        'description',
                'title_en',
        'description_en',
        'image',
        'goal',
        'mission',
        'vision',
        'goal_en',
        'mission_en',
        'vision_en',
    ];
}
