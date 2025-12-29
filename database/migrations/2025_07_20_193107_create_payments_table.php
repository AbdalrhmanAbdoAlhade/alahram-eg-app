<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePaymentsTable extends Migration
{
    public function up()
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();

            // user info
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->string('name');
            $table->string('phone');
            $table->string('email');
            $table->string('address');
            $table->string('city');

            // payment info
            $table->string('payment_type'); // 'cash' or 'online'
            $table->decimal('amount', 10, 2);
            $table->string('status')->default('pending'); // 'pending', 'paid', 'failed'
            $table->string('paymob_order_id')->nullable();
            $table->longText('payment_token')->nullable();

            // products + coupon
            $table->json('products');
            $table->string('coupon_code')->nullable();

            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('payments');
    }
}
