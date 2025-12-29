<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
Schema::create('store_info', function (Blueprint $table) {
    $table->id();
    $table->string('name');
    $table->text('description');
    $table->string('logo');
    $table->text('footer_text');
    $table->string('phone_ar');
    $table->string('phone_eg');
    $table->string('Shipping_number');
    $table->string('email');
    $table->string('address');
    $table->string('facebook')->nullable();
    $table->string('twitter')->nullable();
    $table->string('instagram')->nullable();
    $table->string('youtube')->nullable();
    $table->string('whatsapp')->nullable();
    $table->text('seo_description')->nullable();
    $table->text('seo_keywords')->nullable();
    $table->timestamps();
});

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('store_infos');
    }
};
