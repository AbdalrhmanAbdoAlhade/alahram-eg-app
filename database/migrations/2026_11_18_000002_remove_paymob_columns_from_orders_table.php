<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * أعمدة Paymob اللي بتتشال من جدول الطلبات.
     */
    private array $columns = [
        'paymob_order_id',
        'payment_token',
        'products',
        'coupon_code',
        'payment_id',
    ];

    public function up(): void
    {
        // فك أي Foreign Key على payment_id قبل الحذف
        if (Schema::hasColumn('orders', 'payment_id')) {
            try {
                Schema::table('orders', function (Blueprint $table) {
                    $table->dropForeign(['payment_id']);
                });
            } catch (\Throwable $e) {
                // مفيش foreign key، نكمل عادي
            }
        }

        Schema::table('orders', function (Blueprint $table) {
            foreach ($this->columns as $column) {
                if (Schema::hasColumn('orders', $column)) {
                    $table->dropColumn($column);
                }
            }
        });
    }

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            if (!Schema::hasColumn('orders', 'paymob_order_id')) {
                $table->string('paymob_order_id')->nullable();
            }

            if (!Schema::hasColumn('orders', 'payment_token')) {
                $table->text('payment_token')->nullable();
            }

            if (!Schema::hasColumn('orders', 'products')) {
                $table->json('products')->nullable();
            }

            if (!Schema::hasColumn('orders', 'coupon_code')) {
                $table->string('coupon_code')->nullable();
            }

            if (!Schema::hasColumn('orders', 'payment_id')) {
                $table->unsignedBigInteger('payment_id')->nullable();
            }
        });
    }
};