<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('store_info', function (Blueprint $table) {
            // نحذف الأعمدة القديمة
            $table->dropColumn(['facebook', 'twitter', 'instagram', 'youtube', 'whatsapp']);
            
            // نضيف عمود JSON جديد للسوشيال ميديا
            $table->json('social_media')->nullable();
        });
    }

    public function down(): void
    {
        Schema::table('store_info', function (Blueprint $table) {
            $table->string('facebook')->nullable();
            $table->string('twitter')->nullable();
            $table->string('instagram')->nullable();
            $table->string('youtube')->nullable();
            $table->string('whatsapp')->nullable();
            $table->dropColumn('social_media');
        });
    }
};
