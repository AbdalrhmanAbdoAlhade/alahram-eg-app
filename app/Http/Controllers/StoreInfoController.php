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

        if (!$user || $user->role !== 'admin') {
            abort(403, 'Unauthorized: Admins only');
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

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'logo' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'footer_text' => 'nullable|string',
            'phone' => 'nullable|string|max:20',
            'email' => 'nullable|email',
            'address' => 'nullable|string',
            'facebook' => 'nullable|url',
            'twitter' => 'nullable|url',
            'instagram' => 'nullable|url',
            'youtube' => 'nullable|url',
            'whatsapp' => 'nullable|string|max:50',
            'seo_description' => 'nullable|string',
            'seo_keywords' => 'nullable|string',
             'Shipping_number' => 'nullable|string|max:20',
        ]);

        if ($request->hasFile('logo')) {
            $file = $request->file('logo');
            $originalName = $file->getClientOriginalName();
            $cleanName = preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $originalName);
            $fileName = time() . '_' . $cleanName;

            $destinationPath = public_path('store_logos');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0755, true);
            }

            $file->move($destinationPath, $fileName);

            $validated['logo'] = 'store_logos/' . $fileName;
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

    \Log::info('Request data:', $request->all());

    $validated = $request->validate([
        'name' => 'sometimes|string|max:255',
        'description' => 'nullable|string',
        'logo' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        'footer_text' => 'nullable|string',
        'phone' => 'nullable|string|max:20',
        'email' => 'nullable|email',
        'address' => 'nullable|string',
        'facebook' => 'nullable|url',
        'twitter' => 'nullable|url',
        'instagram' => 'nullable|url',
        'youtube' => 'nullable|url',
        'whatsapp' => 'nullable|string|max:50',
        'seo_description' => 'nullable|string',
        'seo_keywords' => 'nullable|string',
         'Shipping_number' => 'nullable|string|max:20',
    ]);

    // إذا تم رفع صورة جديدة
    if ($request->hasFile('logo')) {
        if ($info->logo && file_exists(public_path($info->logo))) {
            unlink(public_path($info->logo));
        }

        $file = $request->file('logo');
        $originalName = $file->getClientOriginalName();
        $cleanName = preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $originalName);
        $fileName = time() . '_' . $cleanName;

        $destinationPath = public_path('store_logos');
        if (!file_exists($destinationPath)) {
            mkdir($destinationPath, 0755, true);
        }

        $file->move($destinationPath, $fileName);

        $validated['logo'] = 'store_logos/' . $fileName;
    }

    // تسجيل البيانات التي سيتم تحديثها
    \Log::info('Validated data:', $validated);

    $info->update($validated);
    $info->refresh(); // إعادة تحميل البيانات من قاعدة البيانات

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
