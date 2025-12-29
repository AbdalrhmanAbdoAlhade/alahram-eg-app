<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserNotificationsTable extends Migration
{
    public function up()
    {
        Schema::create('user_notifications', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade'); // صاحب الاشعار
            $table->string('title')->nullable();
            $table->text('message')->nullable();
            $table->string('type')->nullable(); // مثلا order, system, message ...
            $table->json('data')->nullable(); // بيانات اضافية قابلة للتخزين
            $table->timestamp('read_at')->nullable(); // متى قرأها المستخدم
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('user_notifications');
    }
}
