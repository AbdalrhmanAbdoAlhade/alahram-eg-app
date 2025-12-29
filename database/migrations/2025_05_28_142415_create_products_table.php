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
Schema::create('products', function (Blueprint $table) {
    $table->id();
    $table->unsignedBigInteger('category_id');
    $table->json('images')->nullable();
    $table->string('img');
    $table->string('name');
    $table->string('name_en');
    $table->string('code')->unique();
    $table->decimal('price_ar', 10, 2);
    $table->decimal('price_eg', 10, 2);
    $table->text('description')->nullable();
    $table->text('description_en')->nullable();
    $table->integer('discount')->nullable();
    $table->json('specs')->nullable();
    $table->unsignedBigInteger('brand_id')->nullable();
    $table->integer('quantity');
    $table->boolean('isFeatured')->default(false);
    $table->date('discount_end_date')->nullable();
    $table->decimal('rating', 3, 2)->nullable();
    $table->text('seo_keywords')->nullable();
    $table->text('seo_description')->nullable();
    $table->timestamps();
});

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
