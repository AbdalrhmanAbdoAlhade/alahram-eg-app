<?php

namespace App\Http\Controllers;

use App\Models\DeliveryArea;
use Illuminate\Http\Request;

class DeliveryAreaController extends Controller
{
    // 🔹 دالة للتحقق إذا المستخدم أدمن
private function isAdmin()
{
    $user = auth('sanctum')->user();
    return $user && in_array($user->role, ['admin', 'director', 'employee']);
}


    /**
     * عرض جميع المناطق
     */
    public function index()
    {
        // يمكن للجميع مشاهدة المناطق
        $areas = DeliveryArea::all();

        return response()->json([
            'status' => true,
            'data' => $areas
        ]);
    }

    /**
     * إنشاء منطقة جديدة (للأدمن فقط)
     */
    public function store(Request $request)
    {
        if (!$this->isAdmin()) {
            return response()->json([
                'status' => false,
                'message' => 'غير مصرح لك بإضافة منطقة (للمشرفين فقط)',
            ], 403);
        }

        $request->validate([
            'name' => 'required|string|max:255',
            'name_en' => 'required|string|max:255',
            'shipping_cost' => 'required|numeric|min:0',
        ]);

        $area = DeliveryArea::create([
            'name' => $request->name,
             'name_en' => $request->name_en,
            'shipping_cost' => $request->shipping_cost,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'تم إنشاء المنطقة بنجاح',
            'data' => $area
        ], 201);
    }

    /**
     * عرض تفاصيل منطقة معينة (متاح للجميع)
     */
    public function show($id)
    {
        $area = DeliveryArea::find($id);

        if (!$area) {
            return response()->json([
                'status' => false,
                'message' => 'المنطقة غير موجودة'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'data' => $area
        ]);
    }

    /**
     * تعديل منطقة (للأدمن فقط)
     */
    public function update(Request $request, $id)
    {
        if (!$this->isAdmin()) {
            return response()->json([
                'status' => false,
                'message' => 'غير مصرح لك بتعديل المنطقة (للمشرفين فقط)',
            ], 403);
        }

        $area = DeliveryArea::find($id);

        if (!$area) {
            return response()->json([
                'status' => false,
                'message' => 'المنطقة غير موجودة'
            ], 404);
        }

        $request->validate([
            'name' => 'sometimes|string|max:255',
            'name_en' => 'sometimes|string|max:255',
            'shipping_cost' => 'sometimes|numeric|min:0',
        ]);

        $area->update($request->only(['name','name_en', 'shipping_cost']));

        return response()->json([
            'status' => true,
            'message' => 'تم تحديث المنطقة بنجاح',
            'data' => $area
        ]);
    }

    /**
     * حذف منطقة (للأدمن فقط)
     */
    public function destroy($id)
    {
        if (!$this->isAdmin()) {
            return response()->json([
                'status' => false,
                'message' => 'غير مصرح لك بحذف المنطقة (للمشرفين فقط)',
            ], 403);
        }

        $area = DeliveryArea::find($id);

        if (!$area) {
            return response()->json([
                'status' => false,
                'message' => 'المنطقة غير موجودة'
            ], 404);
        }

        $area->delete();

        return response()->json([
            'status' => true,
            'message' => 'تم حذف المنطقة بنجاح'
        ]);
    }
}
