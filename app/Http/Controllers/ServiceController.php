<?php

namespace App\Http\Controllers;

use App\Models\Service;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Cache;

class ServiceController extends Controller
{
    // حماية الوصول فقط للمسؤولين
protected function checkAdmin()
{
    $user = Auth::user();

    // إذا لم يجد مستخدم، سنعيد رسالة واضحة مع JSON
    if (!$user) {
        response()->json([
            'message' => 'Token is invalid or not received',
            'debug_header' => request()->header('Authorization')
        ], 401)->send();
        exit;
    }

    if (!in_array($user->role, ['admin', 'director', 'employee'])) {
        response()->json([
            'message' => 'Role mismatch',
            'your_role' => $user->role
        ], 403)->send();
        exit;
    }
}


    /**
     * عرض قائمة بجميع الخدمات مع الكاش.
     */
    public function index()
    {
        $services = Cache::remember('services_all', 600, function () {
            return Service::orderBy('created_at', 'desc')->get();
        });

        return response()->json([
            'status' => true,
            'message' => 'Services fetched successfully',
            'data' => $services
        ], 200);
    }

    /**
     * إنشاء خدمة جديدة مع رفع الصور في public_path.
     */
    public function store(Request $request)
    {
        $this->checkAdmin();

        $validator = Validator::make($request->all(), [
            'name'        => 'required|string|max:255',
            'description' => 'nullable|string',
            'image'       => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:20048',
            'is_active'   => 'nullable|boolean',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $imgPath = null;

        // رفع الصورة باستخدام الطريقة اليدوية (مثل البرودكت)
        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $fileNameOriginal = $file->getClientOriginalName();
            $fileNameClean = preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $fileNameOriginal);
            $fileName = time() . '_' . $fileNameClean;

            $destinationPath = public_path('services');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0755, true);
            }

            $file->move($destinationPath, $fileName);
            $imgPath = 'services/' . $fileName;
        }

        $service = Service::create([
            'name'        => $request->name,
            'description' => $request->description,
            'image_url'   => $imgPath, // حفظ المسار النسبي
            'is_active'   => $request->boolean('is_active', true),
        ]);

        // تنظيف الكاش
        Cache::forget('services_all');

        return response()->json([
            'status'  => true,
            'message' => 'Service created successfully',
            'data'    => $service,
            'img_url' => $imgPath ? url($imgPath) : null,
        ], 201);
    }

    /**
     * عرض تفاصيل خدمة مع الكاش.
     */
    public function show($id)
    {
        $service = Cache::remember("service_{$id}", 600, function () use ($id) {
            return Service::findOrFail($id);
        });

        return response()->json($service);
    }

    /**
     * تحديث خدمة مع حذف الصورة القديمة من المجلد.
     */
    public function update(Request $request, $id)
    {
        $this->checkAdmin();
        $service = Service::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'name'        => 'nullable|string|max:255',
            'description' => 'nullable|string',
            'image'       => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:20048',
            'is_active'   => 'nullable|boolean',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $data = $request->only(['name', 'description', 'is_active']);

        if ($request->hasFile('image')) {
            // حذف الصورة القديمة يدويًا
            if (!empty($service->image_url)) {
                $oldImagePath = public_path($service->image_url);
                if (file_exists($oldImagePath) && is_file($oldImagePath)) {
                    unlink($oldImagePath);
                }
            }

            $file = $request->file('image');
            $fileName = time() . '_' . preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $file->getClientOriginalName());
            
            $destinationPath = public_path('services');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0755, true);
            }

            $file->move($destinationPath, $fileName);
            $data['image_url'] = 'services/' . $fileName;
        }

        $service->update($data);

        // تنظيف الكاش
        Cache::forget('services_all');
        Cache::forget("service_{$id}");

        return response()->json([
            'status'  => true,
            'message' => 'Service updated successfully',
            'data'    => $service,
            'img_url' => $service->image_url ? url($service->image_url) : null,
        ], 200);
    }

    /**
     * حذف خدمة مع حذف الصورة من السيرفر.
     */
    public function destroy($id)
    {
        $this->checkAdmin();
        $service = Service::findOrFail($id);

        if ($service->image_url && file_exists(public_path($service->image_url))) {
            unlink(public_path($service->image_url));
        }

        $service->delete();

        // تنظيف الكاش
        Cache::forget('services_all');
        Cache::forget("service_{$id}");

        return response()->json([
            'status'  => true,
            'message' => 'Service deleted successfully'
        ], 200);
    }
}