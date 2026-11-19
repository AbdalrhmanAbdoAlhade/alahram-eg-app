<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            if (!Schema::hasColumn('orders', 'company')) {
                $table->string('company')->nullable()->after('name');
            }

            if (!Schema::hasColumn('orders', 'country')) {
                $table->string('country', 2)->nullable()->after('company');
            }

            if (!Schema::hasColumn('orders', 'state')) {
                $table->string('state')->nullable();
            }

            if (!Schema::hasColumn('orders', 'governorate')) {
                $table->string('governorate')->nullable();
            }

            if (!Schema::hasColumn('orders', 'district')) {
                $table->string('district')->nullable();
            }

            if (!Schema::hasColumn('orders', 'whatsapp_number')) {
                $table->string('whatsapp_number', 30)->nullable();
            }

            if (!Schema::hasColumn('orders', 'latitude')) {
                $table->decimal('latitude', 10, 7)->nullable();
            }

            if (!Schema::hasColumn('orders', 'longitude')) {
                $table->decimal('longitude', 10, 7)->nullable();
            }

            if (!Schema::hasColumn('orders', 'notes')) {
                $table->text('notes')->nullable();
            }

            if (!Schema::hasColumn('orders', 'terms_accepted_at')) {
                $table->timestamp('terms_accepted_at')->nullable();
            }

            if (!Schema::hasColumn('orders', 'deleted_at')) {
                $table->softDeletes();
            }
        });

        // الإيميل بقى اختياري + طريقة الدفع نص عادي (cash | vodafone_cash | instapay)
        Schema::table('orders', function (Blueprint $table) {
            $table->string('email')->nullable()->change();
            $table->string('payment_type', 30)->default('cash')->change();
        });
    }

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $columns = [
                'company',
                'state',
                'governorate',
                'district',
                'whatsapp_number',
                'latitude',
                'longitude',
                'notes',
                'terms_accepted_at',
            ];

            foreach ($columns as $column) {
                if (Schema::hasColumn('orders', $column)) {
                    $table->dropColumn($column);
                }
            }

            if (Schema::hasColumn('orders', 'deleted_at')) {
                $table->dropSoftDeletes();
            }
        });
    }
};