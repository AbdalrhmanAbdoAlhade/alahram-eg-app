<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Brand;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class BrandController extends Controller
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
        $brands = Brand::all();

        // تعديل لإظهار رابط الصورة كامل
$brands->transform(function ($brand) {
if ($brand->img) {
    $brand->img = url($brand->img);
}

    return $brand;
});


        return response()->json($brands);
    }

    public function show($id)
    {
        $brand = Brand::findOrFail($id);

        if ($brand->img) {
            $brand->img = url('storage/' . $brand->img);
        }

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

            return response()->json(['message' => 'Brand deleted successfully']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'حدث خطأ أثناء حذف العلامة التجارية.', 'message' => $e->getMessage()], 500);
        }
    }
}
