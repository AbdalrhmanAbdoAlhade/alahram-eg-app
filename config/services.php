<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */
'whatsapp' => [
    'send_url' => env('WHATSAPP_SEND_URL'),
    'bulk_daily_limit' => (int) env('WHATSAPP_BULK_DAILY_LIMIT', 200),
    'bulk_min_gap' => (int) env('WHATSAPP_BULK_MIN_GAP', 5),
    'bulk_max_gap' => (int) env('WHATSAPP_BULK_MAX_GAP', 10),
    'quiet_start' => (int) env('WHATSAPP_QUIET_START', 23),
    'quiet_end' => (int) env('WHATSAPP_QUIET_END', 9),
],
    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

    'resend' => [
        'key' => env('RESEND_KEY'),
    ],

    'slack' => [
        'notifications' => [
            'bot_user_oauth_token' => env('SLACK_BOT_USER_OAUTH_TOKEN'),
            'channel' => env('SLACK_BOT_USER_DEFAULT_CHANNEL'),
        ],
    ],

];
