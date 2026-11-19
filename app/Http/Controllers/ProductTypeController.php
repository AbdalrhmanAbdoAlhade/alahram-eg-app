<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Product;
use App\Models\ProductType;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Cache;

class ProductTypeController extends Controller
{
    /**
     * السماح فقط للمسؤولين والموظفين.
     */
    protected function checkAdmin()
    {
        $user = Auth::user();

        if (!$user || !$user->hasAnyRole(['admin', 'director', 'employee'])) {
            abort(403, 'Unauthorized: Admins, Directors or Employees only');
        }
    }

    /**
     * جلب كل الأنواع (id + name فقط).
     */
    public function index()
    {
        $types = ProductType::select('id', 'name')
            ->orderBy('id')
            ->get();

        return response()->json([
            'types' => $types,
        ], 200);
    }

    /**
     * جلب الأنواع الموجودة في منتجات كاتيجوري معينة.
     * ?include_children=1 عشان يشمل الأبناء كمان.
     */
    public function byCategory(Request $request, $categoryId)
    {
        $category = Category::find($categoryId);

        if (!$category) {
            return response()->json([
                'message' => 'Category not found',
            ], 404);
        }

        $categoryIds = [$category->id];

        if ($request->boolean('include_children', false)) {
            $categoryIds = array_merge(
                $categoryIds,
                $category->children()->pluck('id')->all()
            );
        }

        $types = ProductType::select('id', 'name')
            ->whereHas('products', function ($q) use ($categoryIds) {
                $q->whereIn('category_id', $categoryIds);
            })
            ->orderBy('name')
            ->get();

        return response()->json([
            'category_id' => (int) $categoryId,
            'types'       => $types,
        ], 200);
    }

    /**
     * جلب المنتجات الخاصة بنوع معين.
     */
    public function products($id)
    {
        $type = ProductType::select('id', 'name')->findOrFail($id);

        $products = Product::where('type_id', $type->id)
            ->with(['category', 'brand'])
            ->withAvg('reviews', 'rating')
            ->get();

        $now = Carbon::now();

        $products->transform(function ($product) use ($now) {

            if (
                $product->discount_end_date &&
                Carbon::parse($product->discount_end_date)->lt($now)
            ) {
                $product->discount = 0;
            }

            $product->rating_avg = $product->reviews_avg_rating ?? 0;

            return $product;
        });

        return response()->json([
            'type' => $type,
            'products' => $products,
        ], 200);
    }

    /**
     * إنشاء نوع منتج جديد.
     */
    public function store(Request $request)
    {
        $this->checkAdmin();

        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255|unique:product_types,name',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors(),
            ], 422);
        }

        $type = ProductType::create([
            'name' => $validator->validated()['name'],
        ]);

        Cache::forget('product_types_all');

        return response()->json([
            'message' => 'Product type created successfully',
            'type' => $type,
        ], 201);
    }

    /**
     * تحديث نوع منتج.
     */
    public function update(Request $request, $id)
    {
        $this->checkAdmin();

        $type = ProductType::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255|unique:product_types,name,' . $type->id,
        ]);

        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors(),
            ], 422);
        }

        $type->update([
            'name' => $validator->validated()['name'],
        ]);

        Cache::forget('product_types_all');

        return response()->json([
            'message' => 'تم تحديث نوع المنتج بنجاح',
            'type' => $type,
        ], 200);
    }

    /**
     * حذف نوع منتج.
     */
    public function destroy($id)
    {
        $this->checkAdmin();

        $type = ProductType::findOrFail($id);

        if ($type->products()->exists()) {
            return response()->json([
                'message' => 'لا يمكن حذف النوع لأنه مرتبط بمنتجات',
            ], 422);
        }

        $type->delete();

        Cache::forget('product_types_all');

        return response()->json([
            'message' => 'Product type deleted successfully',
        ], 200);
    }
}