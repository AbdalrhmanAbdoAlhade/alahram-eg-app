<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class CategoryController extends Controller
{
    protected function checkAdmin()
    {
        $user = Auth::user();

        if (!$user || $user->role !== 'admin') {
            abort(403, 'Unauthorized: Admins only');
        }
    }

    // جلب جميع التصنيفات مع السب كاتيجوري
    public function index()
    {
        $categories = Category::with('children')->get();

        $categories->transform(function ($category) {
            $category->img_url = $category->img ? url($category->img) : null;
            $category->banner_url = ($category->banner && $category->banner_status) ? url($category->banner) : null;
            return $category;
        });

        return response()->json($categories);
    }

    // عرض تصنيف واحد مع السب كاتيجوري
    public function show($id)
    {
        $category = Category::with('children')->findOrFail($id);

        $category->img_url = $category->img ? url($category->img) : null;
        $category->banner_url = ($category->banner && $category->banner_status) ? url($category->banner) : null;

        return response()->json($category);
    }

    // إنشاء تصنيف جديد
    public function store(Request $request)
    {
        $this->checkAdmin();

        $validator = Validator::make($request->all(), [
            'img' => 'nullable|image|max:2048',
            'banner' => 'nullable|image|max:2048',
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
            'img' => 'nullable|image|max:2048',
            'banner' => 'nullable|image|max:2048',
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

        return response()->json(['message' => 'تم حذف التصنيف بنجاح.']);
    }
}
