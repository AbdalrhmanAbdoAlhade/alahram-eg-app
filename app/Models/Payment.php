<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Payment extends Model
{
    use SoftDeletes;

    public const METHOD_CASH = 'cash';
    public const METHOD_VODAFONE_CASH = 'vodafone_cash';
    public const METHOD_INSTAPAY = 'instapay';

    public const STATUS_PENDING = 'pending';
    public const STATUS_APPROVED = 'approved';
    public const STATUS_REJECTED = 'rejected';

    protected $fillable = [
        'order_id',
        'method',
        'amount',
        'sender_phone',
        'reference_number',
        'receipt_path',
        'status',
        'reviewed_by',
        'reviewed_at',
        'rejection_reason',
    ];

    protected $casts = [
        'amount' => 'decimal:2',
        'reviewed_at' => 'datetime',
    ];

    protected $appends = [
        'receipt_url',
    ];

    public function order()
    {
        return $this->belongsTo(Order::class);
    }

    public function reviewer()
    {
        return $this->belongsTo(User::class, 'reviewed_by');
    }

    /**
     * رابط الإيصال الكامل.
     */
    public function getReceiptUrlAttribute(): ?string
    {
        return $this->receipt_path ? url($this->receipt_path) : null;
    }
}