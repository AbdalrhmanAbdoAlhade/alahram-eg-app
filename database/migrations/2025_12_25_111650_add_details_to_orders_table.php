<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
public function up(): void
{
    Schema::table('orders', function (Blueprint $table) {
        if (!Schema::hasColumn('orders', 'name')) {
            $table->string('name')->after('user_id')->nullable();
        }
        if (!Schema::hasColumn('orders', 'phone')) {
            $table->string('phone')->after('name')->nullable();
        }
        if (!Schema::hasColumn('orders', 'email')) {
            $table->string('email')->after('phone')->nullable();
        }
        if (!Schema::hasColumn('orders', 'city')) {
            $table->string('city')->after('email')->nullable();
        }
        if (!Schema::hasColumn('orders', 'delivery_area_id')) {
            $table->foreignId('delivery_area_id')->after('city')->nullable()->constrained('delivery_areas')->onDelete('set null');
        }
        if (!Schema::hasColumn('orders', 'shipping_cost')) {
            $table->decimal('shipping_cost', 10, 2)->default(0)->after('delivery_area_id');
        }
        if (!Schema::hasColumn('orders', 'paymob_order_id')) {
            $table->string('paymob_order_id')->nullable()->after('shipping_cost');
        }
        if (!Schema::hasColumn('orders', 'payment_token')) {
            $table->string('payment_token')->nullable()->after('paymob_order_id');
        }
        if (!Schema::hasColumn('orders', 'payment_id')) {
            $table->string('payment_id')->nullable()->after('payment_token');
        }
        if (!Schema::hasColumn('orders', 'products')) {
            $table->text('products')->nullable()->after('payment_id');
        }
        if (!Schema::hasColumn('orders', 'coupon_code')) {
            $table->string('coupon_code')->nullable()->after('products');
        }
        if (!Schema::hasColumn('orders', 'vat_amount')) {
            $table->decimal('vat_amount', 10, 2)->default(0)->after('coupon_code');
        }
        if (!Schema::hasColumn('orders', 'vat_percentage')) {
            $table->decimal('vat_percentage', 5, 2)->default(0)->after('vat_amount');
        }
    });
}

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn([
                'name', 'phone', 'email', 'city', 'delivery_area_id', 
                'shipping_cost', 'paymob_order_id', 'payment_token', 
                'payment_id', 'products', 'coupon_code', 'vat_amount', 'vat_percentage'
            ]);
        });
    }
};