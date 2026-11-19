<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // الجدول القديم (Paymob) بيتحفظ كأرشيف ومبيتمسحش
        if (Schema::hasTable('payments') && !Schema::hasTable('payments_legacy')) {
            Schema::rename('payments', 'payments_legacy');
        }

        Schema::create('payments', function (Blueprint $table) {
            $table->id();

            $table->foreignId('order_id')
                ->constrained('orders')
                ->restrictOnDelete();

            // cash | vodafone_cash | instapay
            $table->string('method', 30);

            $table->decimal('amount', 12, 2);

            // رقم المحفظة/الحساب اللي اتحول منه
            $table->string('sender_phone', 30)->nullable();

            // رقم العملية (انستاباي)
            $table->string('reference_number')->nullable();

            // مسار الإيصال (jpg / png / pdf)
            $table->string('receipt_path')->nullable();

            // pending | approved | rejected
            $table->string('status', 20)->default('pending')->index();

            $table->foreignId('reviewed_by')
                ->nullable()
                ->constrained('users')
                ->nullOnDelete();

            $table->timestamp('reviewed_at')->nullable();
            $table->text('rejection_reason')->nullable();

            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payments');

        if (Schema::hasTable('payments_legacy')) {
            Schema::rename('payments_legacy', 'payments');
        }
    }
};