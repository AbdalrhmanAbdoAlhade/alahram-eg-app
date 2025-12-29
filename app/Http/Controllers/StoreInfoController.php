<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\StoreInfo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class StoreInfoController extends Controller
{
  protected function checkAdmin()
{
    $user = Auth::user();

    if (!$user || !in_array($user->role, ['admin', 'director'])) {
        abort(403, 'Unauthorized: Admins, Directors, or Employees only');
    }
}


    public function index()
    {
        $infos = StoreInfo::all();

        // أضف رابط الصورة لكل عنصر
        $infos->transform(function ($item) {
            $item->logo_url = $item->logo ? url($item->logo) : null;
            return $item;
        });

        return response()->json($infos);
    }

    public function show($id)
    {
        $info = StoreInfo::findOrFail($id);
        $info->logo_url = $info->logo ? url($info->logo) : null;

        return response()->json($info);
    }

public function store(Request $request)
{
    $this->checkAdmin();

    // ✅ فك JSON من form-data لو جاي كنص
    if ($request->has('social_media') && is_string($request->social_media)) {
        $decoded = json_decode($request->social_media, true);
        if (json_last_error() === JSON_ERROR_NONE) {
            $request->merge(['social_media' => $decoded]);
        }
    }

    $validated = $request->validate([
        'name' => 'required|string|max:255',
        'description' => 'nullable|string',
        'logo' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        'footer_text' => 'nullable|string',
        'phone_eg' => 'nullable|string|max:20',
        'phone_ar' => 'nullable|string|max:20',
        'email' => 'nullable|email',
        'address' => 'nullable|string',
        'social_media' => 'nullable|array',
        'social_media.*.name' => 'required_with:social_media|string|max:100',
        'social_media.*.icon' => 'nullable',
        'social_media.*.link' => 'nullable|url',
        'social_media.*.status' => 'nullable|boolean',
        'seo_description' => 'nullable|string',
        'seo_keywords' => 'nullable|string',
        'Shipping_number' => 'nullable|string|max:20',
    ]);

    // ✅ رفع شعار المتجر
    if ($request->hasFile('logo')) {
        $file = $request->file('logo');
        $fileName = time() . '_' . preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $file->getClientOriginalName());
        $file->move(public_path('store_logos'), $fileName);
        $validated['logo'] = 'store_logos/' . $fileName;
    }

    // ✅ رفع أيقونات السوشيال ميديا
    if (isset($validated['social_media'])) {
        foreach ($validated['social_media'] as $key => $item) {
            if (isset($item['icon']) && $request->hasFile("social_media.$key.icon")) {
                $iconFile = $request->file("social_media.$key.icon");
                $iconName = time() . '_' . preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $iconFile->getClientOriginalName());
                $iconFile->move(public_path('social_icons'), $iconName);
                $validated['social_media'][$key]['icon'] = 'social_icons/' . $iconName;
            }
        }
    }

    $info = StoreInfo::create($validated);
    $info->logo_url = $info->logo ? url($info->logo) : null;

    return response()->json([
        'message' => 'Store info created successfully',
        'store_info' => $info,
    ], 201);
}



public function update(Request $request, $id)
{
    $this->checkAdmin();

    $info = StoreInfo::findOrFail($id);

    // ✅ فك JSON لو جاي كنص
    if ($request->has('social_media') && is_string($request->social_media)) {
        $decoded = json_decode($request->social_media, true);
        if (json_last_error() === JSON_ERROR_NONE) {
            $request->merge(['social_media' => $decoded]);
        }
    }

    $validated = $request->validate([
        'name' => 'sometimes|string|max:255',
        'description' => 'nullable|string',
        'logo' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        'footer_text' => 'nullable|string',
           'phone_ar' => 'nullable|string|max:20',
        'phone_eg' => 'nullable|string|max:20',
        'email' => 'nullable|email',
        'address' => 'nullable|string',
        'social_media' => 'nullable|array',
        'social_media.*.name' => 'required_with:social_media|string|max:100',
        'social_media.*.icon' => 'nullable',
        'social_media.*.link' => 'nullable|url',
        'social_media.*.status' => 'nullable|boolean',
        'seo_description' => 'nullable|string',
        'seo_keywords' => 'nullable|string',
        'Shipping_number' => 'nullable|string|max:20',
    ]);

    // ✅ تحديث صورة الشعار
    if ($request->hasFile('logo')) {
        if ($info->logo && file_exists(public_path($info->logo))) {
            unlink(public_path($info->logo));
        }

        $file = $request->file('logo');
        $fileName = time() . '_' . preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $file->getClientOriginalName());
        $file->move(public_path('store_logos'), $fileName);
        $validated['logo'] = 'store_logos/' . $fileName;
    }

    // ✅ رفع أو تحديث أيقونات السوشيال ميديا
    if (isset($validated['social_media'])) {
        foreach ($validated['social_media'] as $key => $item) {
            if ($request->hasFile("social_media.$key.icon")) {
                $iconFile = $request->file("social_media.$key.icon");
                $iconName = time() . '_' . preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $iconFile->getClientOriginalName());
                $iconFile->move(public_path('social_icons'), $iconName);
                $validated['social_media'][$key]['icon'] = 'social_icons/' . $iconName;
            }
        }
    }

    $info->update($validated);
    $info->refresh();

    $info->logo_url = $info->logo ? url($info->logo) : null;

    return response()->json([
        'message' => 'تم تحديث معلومات المتجر بنجاح',
        'store_info' => $info,
    ]);
}


    public function destroy($id)
    {
        $this->checkAdmin();

        $info = StoreInfo::findOrFail($id);

        // حذف الصورة من مجلد public/store_logos لو موجودة
        if ($info->logo && file_exists(public_path($info->logo))) {
            unlink(public_path($info->logo));
        }

        $info->delete();

        return response()->json(['message' => 'Store info deleted successfully']);
    }
}
