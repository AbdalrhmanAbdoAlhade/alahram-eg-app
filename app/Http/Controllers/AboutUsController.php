<?php

namespace App\Http\Controllers;

use App\Models\AboutUs;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class AboutUsController extends Controller
{
    // دالة خاصة للتحقق من صلاحية المستخدم (مدير فقط)
    protected function checkAdmin()
    {
        $user = Auth::user();

        if (!$user || $user->role !== 'admin') {
            abort(403, 'Unauthorized: Admins only');
        }
    }

    // عرض كل البيانات
    public function index()
    {
        $abouts = AboutUs::all();
        return response()->json($abouts);
    }

    // عرض بيانات معينة بناءً على ID
    public function show($id)
    {
        $about = AboutUs::findOrFail($id);
        return response()->json($about);
    }

    // إنشاء سجل جديد
public function store(Request $request)
{
    try {
        $this->checkAdmin();

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'title_en' => 'nullable|string|max:255',
            'description_en' => 'nullable|string',
            'image' => 'nullable|image|max:2048',
            'goal' => 'nullable|string',
            'mission' => 'nullable|string',
            'vision' => 'nullable|string',
            'goal_en' => 'nullable|string',
            'mission_en' => 'nullable|string',
            'vision_en' => 'nullable|string',
        ]);

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('about_us'), $filename);
            $validated['image'] = url('about_us/' . $filename);
        } else {
            $validated['image'] = null;
        }

        $about = AboutUs::create($validated);

        return response()->json([
            'message' => 'About Us entry created successfully',
            'about' => $about,
        ], 201);
    } catch (\Illuminate\Validation\ValidationException $e) {
        return response()->json([
            'errors' => $e->errors(),
        ], 422);
    } catch (\Exception $e) {
        return response()->json([
            'error' => 'حدث خطأ أثناء إنشاء السجل.',
            'message' => $e->getMessage(),
        ], 500);
    }
}



    // تحديث سجل موجود
public function update(Request $request, $id)
{
    try {
        $this->checkAdmin();

        $about = AboutUs::findOrFail($id);

        $validated = $request->validate([
            'title' => 'sometimes|string|max:255',
            'description' => 'sometimes|string',
            'title_en' => 'nullable|string|max:255',
            'description_en' => 'nullable|string',
            'image' => 'nullable|image|max:2048',
            'goal' => 'nullable|string',
            'mission' => 'nullable|string',
            'vision' => 'nullable|string',
             'goal_en' => 'nullable|string',
            'mission_en' => 'nullable|string',
            'vision_en' => 'nullable|string',
        ]);

        if ($request->hasFile('image')) {
            // حذف الصورة القديمة من مجلد public/about_us
            if ($about->image) {
                $oldPath = public_path(parse_url($about->image, PHP_URL_PATH));
                if (file_exists($oldPath)) {
                    @unlink($oldPath);
                }
            }

            // رفع الصورة الجديدة
            $file = $request->file('image');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('about_us'), $filename);
            $validated['image'] = url('about_us/' . $filename);
        }

        $about->update($validated);

        return response()->json([
            'message' => 'About Us entry updated successfully',
            'about' => $about,
        ]);
    } catch (\Illuminate\Validation\ValidationException $e) {
        return response()->json([
            'errors' => $e->errors(),
        ], 422);
    } catch (\Exception $e) {
        return response()->json([
            'error' => 'حدث خطأ أثناء تحديث السجل.',
            'message' => $e->getMessage(),
        ], 500);
    }
}



    // حذف سجل
    public function destroy($id)
    {
        try {
            $this->checkAdmin();

            $about = AboutUs::findOrFail($id);

            if ($about->image) {
                Storage::disk('public')->delete($about->image);
            }

            $about->delete();

            return response()->json(['message' => 'About Us entry deleted successfully']);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'حدث خطأ أثناء حذف السجل.',
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
