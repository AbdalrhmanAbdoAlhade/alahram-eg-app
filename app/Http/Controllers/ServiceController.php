<?php

namespace App\Http\Controllers;

use App\Models\Service;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage; // لإدارة الملفات (الصورة)

class ServiceController extends Controller
{
    /**
     * عرض قائمة بجميع الخدمات.
     */
    public function index()
    {
        // جلب جميع الخدمات وعرضها بترتيب تنازلي حسب تاريخ الإنشاء
        $services = Service::orderBy('created_at', 'desc')->paginate(10);

        // هنا يجب أن تعيد عرض (View) يحتوي على البيانات
        return view('services.index', compact('services'));
    }

    /**
     * عرض نموذج إنشاء خدمة جديدة.
     */
    public function create()
    {
        return view('services.create');
    }

    /**
     * تخزين خدمة جديدة في قاعدة البيانات.
     */
    public function store(Request $request)
    {
        // 1. التحقق من صحة البيانات المدخلة
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            // يجب تحديد نوع الملف (صورة) والحد الأقصى لحجمه
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $imagePath = null;

        // 2. معالجة رفع الصورة وتخزينها
        if ($request->hasFile('image')) {
            // تخزين الملف في مجلد 'public/images/services' (يجب أن يكون لديك Symlink)
            $imagePath = $request->file('image')->store('images/services', 'public');
        }

        // 3. إنشاء سجل الخدمة في قاعدة البيانات
        Service::create([
            'name' => $request->name,
            'description' => $request->description,
            // حفظ المسار في حقل image_url
            'image_url' => $imagePath,
            'is_active' => $request->boolean('is_active', true),
        ]);

        return redirect()->route('services.index')
                         ->with('success', 'تم إضافة الخدمة بنجاح!');
    }

    /**
     * عرض تفاصيل خدمة معينة.
     */
    public function show(Service $service)
    {
        return view('services.show', compact('service'));
    }

    /**
     * عرض نموذج تعديل خدمة موجودة.
     */
    public function edit(Service $service)
    {
        return view('services.edit', compact('service'));
    }

    /**
     * تحديث خدمة موجودة في قاعدة البيانات.
     * (منطقها مشابه لـ store لكن يتضمن حذف الصورة القديمة إذا تم تحميل صورة جديدة)
     */
    public function update(Request $request, Service $service)
    {
        // ... منطق التحديث ...

        return redirect()->route('services.index')
                         ->with('success', 'تم تحديث الخدمة بنجاح!');
    }

    /**
     * حذف خدمة معينة.
     */
    public function destroy(Service $service)
    {
        // 1. حذف الصورة المرتبطة بالخدمة من نظام التخزين
        if ($service->image_url) {
            Storage::disk('public')->delete($service->image_url);
        }

        // 2. حذف السجل من قاعدة البيانات
        $service->delete();

        return redirect()->route('services.index')
                         ->with('success', 'تم حذف الخدمة بنجاح!');
    }
}
