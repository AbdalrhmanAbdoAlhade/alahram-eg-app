<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Cache;

class CategoryController extends Controller
{
protected function checkAdmin()
{
    $user = Auth::user();

    if (!$user || !in_array($user->role, ['admin', 'director', 'employee'])) {
        abort(403, 'Unauthorized: Admins, Directors or Employees only');
    }
}

   public function index()
{
    // 🧠 كاش لجميع التصنيفات لمدة 10 دقائق (600 ثانية)
    $categories = Cache::remember('categories_all', 600, function () {
        $data = Category::with('children')->get();

        $data->transform(function ($category) {
            $category->img_url = $category->img ? url($category->img) : null;
            $category->banner_url = ($category->banner && $category->banner_status) ? url($category->banner) : null;
            return $category;
        });

        return $data;
    });

    return response()->json($categories);
}

public function show($id)
{
    // 🧠 كاش لتصنيف واحد فقط
    $category = Cache::remember("category_{$id}", 600, function () use ($id) {
        $cat = Category::with('children')->findOrFail($id);
        $cat->img_url = $cat->img ? url($cat->img) : null;
        $cat->banner_url = ($cat->banner && $cat->banner_status) ? url($cat->banner) : null;
        return $cat;
    });

    return response()->json($category);
}

    // إنشاء تصنيف جديد
    public function store(Request $request)
    {
        $this->checkAdmin();

        $validator = Validator::make($request->all(), [
            'img' => 'nullable|image|max:20048',
            'banner' => 'nullable|image|max:20048',
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'banner_status' => 'nullable|boolean',
            'button_title' => 'nullable|string',
            'name_en' => 'nullable|string|max:255',
            'description_en' => 'nullable|string',
            'parent_id' => 'nullable|exists:categories,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'حدثت أخطاء في التحقق.',
                'errors' => $validator->errors(),
            ], 422);
        }

        $validated = $validator->validated();

        if ($request->hasFile('img')) {
            $file = $request->file('img');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('categories'), $filename);
            $validated['img'] = 'categories/' . $filename;
        }

        if ($request->hasFile('banner')) {
            $file = $request->file('banner');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('categories'), $filename);
            $validated['banner'] = 'categories/' . $filename;
        }

        $category = Category::create($validated);
        
Cache::forget('categories_all');
Cache::forget("category_{$category->id}");


        return response()->json([
            'message' => 'تم إنشاء الصنف بنجاح.',
            'category' => $category,
        ], 201);
    }

    // تعديل فئة
    public function update(Request $request, $id)
    {
        $this->checkAdmin();

        $category = Category::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'img' => 'nullable|image|max:20048',
            'banner' => 'nullable|image|max:20048',
            'name' => 'sometimes|string|max:255',
            'description' => 'nullable|string',
            'banner_status' => 'nullable|boolean',
            'button_title' => 'nullable|string',
            'name_en' => 'nullable|string|max:255',
            'description_en' => 'nullable|string',
            'parent_id' => 'nullable|exists:categories,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'فشل التحقق من البيانات.',
                'errors' => $validator->errors(),
            ], 422);
        }

        $validated = $validator->validated();

        if ($request->hasFile('img')) {
            if ($category->img && file_exists(public_path($category->img))) {
                unlink(public_path($category->img));
            }
            $file = $request->file('img');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('categories'), $filename);
            $validated['img'] = 'categories/' . $filename;
        }

        if ($request->hasFile('banner')) {
            if ($category->banner && file_exists(public_path($category->banner))) {
                unlink(public_path($category->banner));
            }
            $file = $request->file('banner');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('categories'), $filename);
            $validated['banner'] = 'categories/' . $filename;
        }

        $category->update($validated);
Cache::forget('categories_all');
Cache::forget("category_{$category->id}");

        return response()->json([
            'message' => 'تم تعديل الصنف بنجاح.',
            'category' => $category,
        ]);
    }

    // حذف البانر فقط
    public function deleteBanner($id)
    {
        $this->checkAdmin();

        $category = Category::findOrFail($id);

        if ($category->banner && file_exists(public_path($category->banner))) {
            unlink(public_path($category->banner));
            $category->banner = null;
            $category->save();
        }

        return response()->json([
            'message' => 'تم حذف البانر بنجاح.',
            'category' => $category,
        ]);
    }

    // حذف تصنيف
    public function destroy($id)
    {
        $this->checkAdmin();

        $category = Category::findOrFail($id);

        if ($category->img && file_exists(public_path($category->img))) {
            unlink(public_path($category->img));
        }

        if ($category->banner && file_exists(public_path($category->banner))) {
            unlink(public_path($category->banner));
        }

        $category->delete();
Cache::forget('categories_all');
Cache::forget("category_{$category->id}");

        return response()->json(['message' => 'تم حذف التصنيف بنجاح.']);
    }
}
