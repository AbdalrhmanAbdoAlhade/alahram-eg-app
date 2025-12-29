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
    Schema::table('settings', function (Blueprint $table) {
        $table->decimal('vat', 5, 2)->default(0); // ✅ نسبة ضريبة القيمة المضافة
    });
}

public function down()
{
    Schema::table('settings', function (Blueprint $table) {
        $table->dropColumn('vat');
    });
}

};
