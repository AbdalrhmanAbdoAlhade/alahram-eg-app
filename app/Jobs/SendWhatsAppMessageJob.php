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

    public $tries = 3;

    public $backoff = [10, 60];

    public function __construct(
        protected $phone,
        protected $message,
        protected ?string $session = null
    ) {
    }

    public function handle(WhatsAppService $service)
    {
        $sent = $service->sendText($this->phone, $this->message, $this->session);

        if (!$sent) {
            throw new \Exception("Failed to send WhatsApp to {$this->phone}");
        }
    }
}