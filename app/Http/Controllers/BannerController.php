<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Banner;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;

class BannerController extends Controller
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
        $banners = Banner::with(['category', 'product'])->get()->map(function($banner) {
            $banner->img_url = $banner->img ? url($banner->img) : null;
            return $banner;
        });

        return response()->json($banners);
    }

    public function show($id)
    {
        $banner = Banner::with(['category', 'product'])->findOrFail($id);
        $banner->img_url = $banner->img ? url($banner->img) : null;

        return response()->json($banner);
    }

public function store(Request $request)
{
    try {
        $this->checkAdmin();

        $validated = $request->validate([
            'title' => 'nullable|string|max:255',
            'description' => 'nullable|string',
             'title_en' => 'nullable|string|max:255',
            'description_en' => 'nullable|string',
            'category_id' => 'nullable|integer|exists:categories,id',
            'product_id' => 'nullable|integer|exists:products,id',
            'img' => 'required|image|max:2048',
        ]);

        if ($request->hasFile('img')) {
            $file = $request->file('img');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('banners'), $filename);
            $validated['img'] = 'banners/' . $filename;
        }

        $banner = Banner::create($validated);
        $banner->img_url = url($validated['img']);

        return response()->json([
            'message' => 'Banner created successfully',
            'banner' => $banner,
        ], 201);
    } catch (\Illuminate\Validation\ValidationException $e) {
        return response()->json(['errors' => $e->errors()], 422);
    } catch (\Exception $e) {
        return response()->json([
            'error' => 'حدث خطأ أثناء إنشاء البانر.',
            'message' => $e->getMessage(),
        ], 500);
    }
}


public function update(Request $request, $id)
{
    try {
        $this->checkAdmin();

        $banner = Banner::findOrFail($id);

        $validated = $request->validate([
            'title' => 'nullable|string|max:255',
            'description' => 'nullable|string',
             'title_en' => 'nullable|string|max:255',
            'description_en' => 'nullable|string',
            'category_id' => 'nullable|integer|exists:categories,id',
            'product_id' => 'nullable|integer|exists:products,id',
            'img' => 'nullable|image|max:2048',
        ]);

        if ($request->hasFile('img')) {
            // حذف الصورة القديمة إن وجدت
            if ($banner->img) {
                $oldPath = public_path($banner->img);
                if (file_exists($oldPath)) {
                    @unlink($oldPath);
                }
            }

            // رفع الصورة الجديدة
            $file = $request->file('img');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('banners'), $filename);
            $validated['img'] = 'banners/' . $filename;
        }

        $banner->update($validated);
        $banner->img_url = $banner->img ? url($banner->img) : null;

        return response()->json([
            'message' => 'Banner updated successfully',
            'banner' => $banner,
        ]);
    } catch (\Illuminate\Validation\ValidationException $e) {
        return response()->json(['errors' => $e->errors()], 422);
    } catch (\Exception $e) {
        return response()->json([
            'error' => 'حدث خطأ أثناء تحديث البانر.',
            'message' => $e->getMessage(),
        ], 500);
    }
}


    public function destroy($id)
    {
        $banner = Banner::findOrFail($id);

        if ($banner->img) {
            Storage::disk('public')->delete($banner->img);
        }

        $banner->delete();

        return response()->json(['message' => 'Banner deleted successfully']);
    }
}
