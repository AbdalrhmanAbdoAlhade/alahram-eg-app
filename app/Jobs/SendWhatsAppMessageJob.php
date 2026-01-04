<?php

namespace App\Jobs;

use App\Services\WhatsAppService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class SendWhatsAppMessageJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $phone;
    protected $message;

    // إعادة المحاولة 3 مرات في حال فشل السيرفر
    public $tries = 3;

    public function __construct($phone, $message)
    {
        $this->phone = $phone;
        $this->message = $message;
    }

    public function handle(WhatsAppService $service)
    {
        $sent = $service->sendText($this->phone, $this->message);

        if (!$sent) {
            // إذا فشل، نلقي استثناء ليعيد الطابور المحاولة
            throw new \Exception("Failed to send WhatsApp to {$this->phone}");
        }
    }
}