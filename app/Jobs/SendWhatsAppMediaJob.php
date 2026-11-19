<?php

namespace App\Jobs;

use App\Services\WhatsAppService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class SendWhatsAppMediaJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $tries = 3;

    public $backoff = [10, 60];

    /**
     * $media = ['url' => '...'] أو ['base64' => '...', 'mimetype' => '...']
     */
    public function __construct(
        protected $phone,
        protected array $media,
        protected ?string $caption = null,
        protected ?string $session = null
    ) {
    }

    public function handle(WhatsAppService $service)
    {
        $sent = $service->sendMedia(
            $this->phone,
            $this->media,
            $this->caption,
            $this->session
        );

        if (!$sent) {
            throw new \Exception("Failed to send WhatsApp media to {$this->phone}");
        }
    }
}