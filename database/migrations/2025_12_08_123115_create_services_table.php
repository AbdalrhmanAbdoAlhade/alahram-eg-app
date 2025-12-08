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
        Schema::create('services', function (Blueprint $table) {
            $table->id();
            // حقل اسم الخدمة (String)
            $table->string('name', 255);
            // حقل الوصف (Text للنصوص الطويلة)
            $table->text('description')->nullable();
            // حقل مسار الصورة (URL)
            $table->string('image_url', 500)->nullable();
            // حقل لحالة الخدمة (افتراضياً True)
            $table->boolean('is_active')->default(true);
            // حقول created_at و updated_at
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('services');
    }
};
