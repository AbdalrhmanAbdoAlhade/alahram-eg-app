<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
   public function up()
{
    Schema::create('delivery_areas', function (Blueprint $table) {
        $table->id();
        $table->string('name'); // اسم المنطقة
        $table->string('name_en');
        $table->decimal('shipping_cost', 10, 2)->default(0); // سعر الشحن
        $table->timestamps();
    });
}


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('delivery_areas');
    }
};
