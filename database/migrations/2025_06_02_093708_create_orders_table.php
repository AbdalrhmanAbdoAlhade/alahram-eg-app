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
    Schema::create('orders', function (Blueprint $table) {
        $table->id();
$table->foreignId('user_id')->nullable()->constrained()->onDelete('cascade');
        $table->decimal('total_price', 10, 2);
        $table->string('status')->default('pending'); // pending, completed, canceled ,shipping
           $table->text('address')->nullable();
      $table->text('country')->nullable();
           $table->string('payment_type')->nullable();
    $table->foreignId('discount_coupon_id')->nullable()->constrained()->onDelete('set null');
    $table->decimal('discount_amount', 10, 2)->default(0);
        $table->timestamps();
    });
}


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
