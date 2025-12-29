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
            'data' => $setting
        ]);
    }

    // 🔹 التحقق من أن المستخدم أدمن
    private function isAdmin()
    {
        $user = auth('sanctum')->user();
        return $user && in_array($user->role, ['admin', 'director', 'employee']);
    }

    // ✅ تحديث أو إنشاء الإعدادات (الحد الأدنى للشحن المجاني + نسبة الضريبة)
    public function update(Request $request)
    {
        if (!$this->isAdmin()) {
            return response()->json([
                'status' => false,
                'message' => 'غير مصرح لك بتعديل الإعدادات (للمشرفين فقط)',
            ], 403);
        }

        $request->validate([
            'free_shipping_limit' => 'nullable|numeric|min:0',
            'vat' => 'nullable|numeric|min:0|max:100', // ✅ التحقق من الضريبة بين 0 و 100
        ]);

        $setting = Setting::first();

        if ($setting) {
            $setting->update([
                'free_shipping_limit' => $request->free_shipping_limit,
                'vat' => $request->vat, // ✅ إضافة الضريبة
            ]);
        } else {
            $setting = Setting::create([
                'free_shipping_limit' => $request->free_shipping_limit,
                'vat' => $request->vat, // ✅ إنشاء الضريبة
            ]);
        }

        return response()->json([
            'status' => true,
            'message' => 'تم تحديث الإعدادات بنجاح',
            'data' => $setting
        ]);
    }
}
