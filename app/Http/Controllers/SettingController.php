<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    // ✅ عرض القيم الحالية
    public function index()
    {
        $setting = Setting::first();

        return response()->json([
            'status' => true,
            'data'   => $setting,
        ]);
    }

    // 🔹 التحقق من أن المستخدم أدمن
    private function isAdmin()
    {
        $user = auth('sanctum')->user();

        return $user && in_array($user->role, ['admin', 'director', 'employee']);
    }

    // ✅ تحديث أو إنشاء الإعدادات
   public function update(Request $request)
{
    $validated = $request->validate([
        'free_shipping_limit'  => 'nullable|numeric|min:0',
        'vat'                  => 'nullable|numeric|min:0|max:100',
        'instapay_id'          => 'nullable|string|max:255',
        'vodafone_cash_number' => 'nullable|string|max:20',
    ]);

    $data = collect($validated)
        ->filter(fn ($value, $key) => $request->has($key))
        ->all();

    $setting = Setting::first();

    if ($setting) {
        $setting->update($data);
    } else {
        $setting = Setting::create($data);
    }

    return response()->json([
        'status'  => true,
        'message' => 'تم تحديث الإعدادات بنجاح',
        'data'    => $setting->fresh(),
    ]);
}
}