<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Banner;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;

class BannerController extends Controller
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
        // 🧠 استخدم الكاش لمدة 10 دقائق (600 ثانية)
        $banners = Cache::remember('banners_all', 600, function () {
            return Banner::with(['category', 'product'])->get()->map(function($banner) {
                $banner->img_url = $banner->img ? url($banner->img) : null;
                return $banner;
            });
        });

        return response()->json($banners);
    }

    public function show($id)
    {
        // 🧠 كاش لكل بانر على حدة
        $banner = Cache::remember("banner_{$id}", 600, function () use ($id) {
            $b = Banner::with(['category', 'product'])->findOrFail($id);
            $b->img_url = $b->img ? url($b->img) : null;
            return $b;
        });

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
            'img' => 'required|image|max:20048',
        ]);

        if ($request->hasFile('img')) {
            $file = $request->file('img');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('banners'), $filename);
            $validated['img'] = 'banners/' . $filename;
        }

        $banner = Banner::create($validated);
        $banner->img_url = url($validated['img']);
        
Cache::forget('banners_all');


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
            'img' => 'nullable|image|max:20048',
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

        // ✅ امسح الكاش قبل الإرجاع
        Cache::forget('banners_all');
        Cache::forget("banner_{$id}");

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
Cache::forget('banners_all');
Cache::forget("banner_{$id}");

        return response()->json(['message' => 'Banner deleted successfully']);
    }
}
