<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('settings', function (Blueprint $table) {
            if (!Schema::hasColumn('settings', 'instapay_id')) {
                $table->string('instapay_id')->nullable();
            }

            if (!Schema::hasColumn('settings', 'vodafone_cash_number')) {
                $table->string('vodafone_cash_number', 30)->nullable();
            }
        });
    }

    public function down(): void
    {
        Schema::table('settings', function (Blueprint $table) {
            if (Schema::hasColumn('settings', 'instapay_id')) {
                $table->dropColumn('instapay_id');
            }

            if (Schema::hasColumn('settings', 'vodafone_cash_number')) {
                $table->dropColumn('vodafone_cash_number');
            }
        });
    }
};