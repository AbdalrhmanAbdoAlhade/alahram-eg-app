<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class UserNotification extends Model
{
    use HasFactory;

    protected $table = 'user_notifications';

    protected $fillable = [
        'user_id',
        'title',
        'message',
        'type',
        'data',
        'read_at',
    ];

    protected $casts = [
        'data' => 'array',
        'read_at' => 'datetime',
    ];

    // علاقة باليوزر
    public function user()
    {
        return $this->belongsTo(\App\Models\User::class);
    }

    // مساعدة: هل مُقروءة؟
    public function isRead(): bool
    {
        return !is_null($this->read_at);
    }

    // تمييز كمقروء
    public function markAsRead(): bool
    {
        if (!$this->isRead()) {
            $this->read_at = now();
            return $this->save();
        }
        return true;
    }

    // تمييز كغير مقروء
    public function markAsUnread(): bool
    {
        if ($this->isRead()) {
            $this->read_at = null;
            return $this->save();
        }
        return true;
    }
}
