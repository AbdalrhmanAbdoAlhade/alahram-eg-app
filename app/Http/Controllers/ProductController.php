<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;

class ProductController extends Controller
{
    // حماية الوصول فقط للمسؤولين
    protected function checkAdmin()
    {
        $user = Auth::user();

        if (!$user || $user->role !== 'admin') {
            abort(403, 'Unauthorized: Admins only');
        }
    }

    // عرض كل المنتجات مع العلاقات
    public function index()
    {
        $products = Product::with(['category', 'brand', 'reviews'])->get();

        $now = Carbon::now();

        $products->transform(function ($product) use ($now) {
            // إلغاء الخصم إذا انتهى تاريخه
            if ($product->discount_end_date && $product->discount_end_date < $now) {
                $product->discount = 0;
            }

            // حساب متوسط التقييم
            $product->rating_avg = $product->reviews->avg('rating') ?? 0;

            return $product;
        });

        return response()->json([
            'products' => $products
        ], 200);
    }

    // عرض منتج واحد
    public function show($id)
    {
        $product = Product::with(['category', 'brand', 'reviews'])->findOrFail($id);
        return response()->json($product);
    }

    // إنشاء منتج جديد
    public function store(Request $request)
    {
        $this->checkAdmin();

        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
            'code' => 'required|string|unique:products',
            'price' => 'required|numeric',
            'category_id' => 'required|exists:categories,id',
            'brand_id' => 'nullable|exists:brands,id',
            'img' => 'nullable|image|max:2048',
            'images' => 'nullable|array',
            'images.*' => 'image|max:2048',
            'description' => 'nullable|string',
            'name_en' => 'nullable|string|max:255',
            'description_en' => 'nullable|string',
            'discount' => 'nullable|numeric',
            'specs' => 'nullable|array',
            'quantity' => 'nullable|integer',
            'isFeatured' => 'nullable|boolean',
            'discount_end_date' => 'nullable|date',
            'rating' => 'nullable|numeric',
            'seo_keywords' => 'nullable|string',
            'seo_description' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $imgPath = null;

        // رفع الصورة الرئيسية
    if ($request->hasFile('img')) {
        $file = $request->file('img');
        $fileNameOriginal = $file->getClientOriginalName();
        $fileNameClean = preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $fileNameOriginal);
        $fileName = time() . '_' . $fileNameClean;

        $destinationPath = public_path('products');
        if (!file_exists($destinationPath)) {
            mkdir($destinationPath, 0755, true);
        }

        $file->move($destinationPath, $fileName);
        $imgPath = 'products/' . $fileName;
    }

    // رفع صور متعددة
    $imagePaths = [];
    if ($request->hasFile('images')) {
        foreach ($request->file('images') as $image) {
            $fileNameOriginal = $image->getClientOriginalName();
            $fileNameClean = preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $fileNameOriginal);
            $fileName = time() . '_' . $fileNameClean;

            $image->move($destinationPath, $fileName);
            $imagePaths[] = 'products/' . $fileName;
        }
    }

        // معالجة specs بشكل صحيح
        $specsInput = $request->input('specs');
        $specs = [];

        if (is_array($specsInput)) {
            foreach ($specsInput as $item) {
                if (is_string($item)) {
                    $decoded = json_decode($item, true);
                    if (json_last_error() === JSON_ERROR_NONE) {
                        $specs[] = $decoded;
                    }
                } elseif (is_array($item)) {
                    $specs[] = $item;
                }
            }
        }

        $product = Product::create([
            'name' => $request->name,
            'name_en' => $request->name_en,
            'code' => $request->code,
            'price' => $request->price,
            'category_id' => $request->category_id,
            'brand_id' => $request->brand_id,
            'img' => $imgPath,
            'images' => $imagePaths,
            'description' => $request->description,
            'description_en' => $request->description_en,
            'discount' => $request->discount,
            'specs' => $specs,
            'quantity' => $request->filled('quantity') ? $request->quantity : 0,
            'isFeatured' => $request->isFeatured,
            'discount_end_date' => $request->discount_end_date,
            'rating' => $request->rating,
            'seo_keywords' => $request->seo_keywords,
            'seo_description' => $request->seo_description,
        ]);

        return response()->json([
            'product' => $product,
            'img_url' => $imgPath ? url($imgPath) : null,
            'images_urls' => array_map(fn($img) => url($img), $imagePaths),
        ], 201);
    }

    // تحديث منتج
public function update(Request $request, $id)
{
    $this->checkAdmin();

    $product = Product::findOrFail($id);
    \Log::info("🔧 بدء تحديث المنتج ID: {$product->id}");

    $validator = Validator::make($request->all(), [
        'name' => 'sometimes|string',
        'code' => 'sometimes|string|unique:products,code,' . $product->id,
        'price' => 'sometimes|numeric',
        'category_id' => 'nullable|exists:categories,id',
        'brand_id' => 'nullable|exists:brands,id',
        'img' => 'nullable|image|max:2048',
        'images' => 'nullable|array',
        'images.*' => 'image|max:2048',
        'description' => 'nullable|string',
        'discount' => 'nullable|numeric',
        'specs' => 'nullable|array',
        'quantity' => 'nullable|integer',
        'isFeatured' => 'nullable|boolean',
        'discount_end_date' => 'nullable|date',
        'rating' => 'nullable|numeric',
        'seo_keywords' => 'nullable|string',
        'seo_description' => 'nullable|string',
        'name_en' => 'nullable|string|max:255',
        'description_en' => 'nullable|string',
    ]);

    if ($validator->fails()) {
        \Log::warning("⚠️ فشل التحقق من صحة البيانات عند تحديث المنتج ID: {$product->id}", $validator->errors()->toArray());
        return response()->json($validator->errors(), 422);
    }

    $data = $validator->validated();
    $destinationPath = public_path('products');

    // إنشاء المجلد إذا لم يكن موجودًا
    if (!file_exists($destinationPath)) {
        mkdir($destinationPath, 0755, true);
    }

    // 1. معالجة الصورة الرئيسية (img)
    if ($request->hasFile('img')) {
        // حذف الصورة القديمة إن وجدت وكانت ملفًا
        if (!empty($product->img)) {
            $oldImagePath = public_path($product->img);
            if (file_exists($oldImagePath) && is_file($oldImagePath)) {
                unlink($oldImagePath);
            }
        }

        $file = $request->file('img');
        $fileName = time() . '_' . preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $file->getClientOriginalName());
        $file->move($destinationPath, $fileName);
        $data['img'] = 'products/' . $fileName;
    }

    // 2. معالجة الصور المتعددة (images)
    if ($request->has('images')) {
        // حذف الصور القديمة إن وجدت وكانت ملفات
        if (!empty($product->images) && is_array($product->images)) {
            foreach ($product->images as $oldImage) {
                $oldImagePath = public_path($oldImage);
                if (file_exists($oldImagePath) && is_file($oldImagePath)) {
                    unlink($oldImagePath);
                }
            }
        }

        $imagePaths = [];
        if ($request->hasFile('images')) {
            foreach ($request->file('images') as $image) {
                $fileName = time() . '_' . preg_replace('/[^A-Za-z0-9\-_\.]/', '_', $image->getClientOriginalName());
                $image->move($destinationPath, $fileName);
                $imagePaths[] = 'products/' . $fileName;
            }
        }
        $data['images'] = $imagePaths;
    }

    // 3. معالجة المواصفات (specs)
    if (isset($data['specs'])) {
        $specs = [];
        foreach ($data['specs'] as $item) {
            if (is_array($item)) {
                $specs[] = $item;
            } elseif (is_string($item)) {
                $decoded = json_decode($item, true);
                if (json_last_error() === JSON_ERROR_NONE) {
                    $specs[] = $decoded;
                }
            }
        }
        $data['specs'] = $specs;
    }

    // تحديث البيانات مع تجاهل الحقول الفارغة
    $product->update(array_filter($data, fn($value) => $value !== null));

    \Log::info("✅ تم تحديث المنتج بنجاح ID: {$product->id}");

    return response()->json([
        'message' => 'تم تحديث المنتج بنجاح',
        'product' => $product,
        'img_url' => $product->img ? url($product->img) : null,
        'images_urls' => $product->images ? array_map(fn($img) => url($img), $product->images) : [],
    ]);
}



    // حذف منتج مع حذف الصور من المجلد العام
    public function destroy($id)
    {
        $this->checkAdmin();

        $product = Product::findOrFail($id);

        if ($product->img && file_exists(public_path($product->img))) {
            unlink(public_path($product->img));
        }

        if ($product->images && is_array($product->images)) {
            foreach ($product->images as $image) {
                if (file_exists(public_path($image))) {
                    unlink(public_path($image));
                }
            }
        }

        $product->delete();

        return response()->json(['message' => 'Product deleted successfully']);
    }
}
