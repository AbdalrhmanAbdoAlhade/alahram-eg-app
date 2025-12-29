<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Brand;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Cache;

class BrandController extends Controller
{
protected function checkAdmin()
{
    $user = Auth::user();

    // لو المستخدم غير مسجل دخول
    if (!$user) {
        abort(403, 'غير مصرح لك: يجب تسجيل الدخول');
    }

    // الأدوار المسموح لها
    $allowedRoles = ['admin', 'director', 'employee'];

    if (!in_array($user->role, $allowedRoles)) {
        abort(403, 'غير مصرح لك: يجب أن تكون أدمن أو مدير أو موظف');
    }
}

public function index()
{
    // 🧠 تخزين جميع البراندات في الكاش لمدة 10 دقائق
    $brands = Cache::remember('brands_all', 600, function () {
        return Brand::all()->map(function ($brand) {
            $brand->img = $brand->img ? url($brand->img) : null;
            return $brand;
        });
    });

    return response()->json($brands);
}

public function show($id)
{
    // 🧠 كاش لكل براند على حدة
    $brand = Cache::remember("brand_{$id}", 600, function () use ($id) {
        $b = Brand::findOrFail($id);
        $b->img = $b->img ? url($b->img) : null;
        return $b;
    });

    return response()->json($brand);
}


    public function store(Request $request)
    {
        try {
            $this->checkAdmin();

            $validated = $request->validate([
                'name' => 'required|string|max:255',
                'img' => 'nullable|image|max:2048',
                'link' => 'nullable|string|max:2048',
            ]);

        if ($request->hasFile('img')) {
    $file = $request->file('img');
    $filename = uniqid() . '.' . $file->getClientOriginalExtension();
    $file->move(public_path('brands'), $filename);
    $validated['img'] = 'brands/' . $filename;
}


            $brand = Brand::create($validated);

     if ($brand->img) {
    $brand->img = url($brand->img);
}
    // 🧹 تنظيف الكاش بعد الإضافة
        Cache::forget('brands_all');


            return response()->json([
                'message' => 'Brand created successfully',
                'brand' => $brand,
            ], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'حدث خطأ أثناء إنشاء العلامة التجارية.', 'message' => $e->getMessage()], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $this->checkAdmin();

            $brand = Brand::findOrFail($id);

            $validated = $request->validate([
                'name' => 'sometimes|string|max:255',
                'img' => 'nullable|image|max:2048',
                 'link' => 'nullable|string|max:2048',
            ]);

    if ($request->hasFile('img')) {
    // حذف الصورة القديمة إذا موجودة
    if ($brand->img) {
        $oldPath = public_path(parse_url($brand->img, PHP_URL_PATH)); // فك رابط URL لل path فقط
        if (file_exists($oldPath)) {
            @unlink($oldPath);
        }
    }

    $file = $request->file('img');
    $filename = uniqid() . '.' . $file->getClientOriginalExtension();
    $file->move(public_path('brands'), $filename);
    $validated['img'] = 'brands/' . $filename;
}


            $brand->update($validated);

      if ($brand->img) {
    $brand->img = url($brand->img);
}
        // 🧹 تنظيف الكاش بعد التحديث
        Cache::forget('brands_all');
        Cache::forget("brand_{$brand->id}");

            return response()->json([
                'message' => 'Brand updated successfully',
                'brand' => $brand,
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'حدث خطأ أثناء تحديث العلامة التجارية.', 'message' => $e->getMessage()], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $this->checkAdmin();

            $brand = Brand::findOrFail($id);

            if ($brand->img) {
                Storage::disk('public')->delete($brand->img);
            }

            $brand->delete();
        // 🧹 تنظيف الكاش بعد التحديث
        Cache::forget('brands_all');
        Cache::forget("brand_{$brand->id}");
            return response()->json(['message' => 'Brand deleted successfully']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'حدث خطأ أثناء حذف العلامة التجارية.', 'message' => $e->getMessage()], 500);
        }
    }
}
