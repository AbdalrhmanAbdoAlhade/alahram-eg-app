<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductType;
use App\Traits\HandlesWebpImages;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Carbon\Carbon;

class ProductController extends Controller
{
    use HandlesWebpImages;

    /**
     * إعدادات ضغط الصور (تقدر تلعب فيها).
     */
    private const IMG_QUALITY   = 80;
    private const IMG_MAX_WIDTH = 1200;

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
     * قواعد التحقق المشتركة لخطوات الشرح.
     */
    protected function getStepsValidationRules(): array
    {
        return [
            'steps' => 'nullable|array',
            'steps.*.title' => 'required_with:steps|string|max:255',
            'steps.*.step_number' => 'required_with:steps|integer|min:1',
            'steps.*.description' => 'required_with:steps|string',
        ];
    }

    /**
     * حفظ خطوات شرح المنتج.
     */
    protected function saveProductSteps(Product $product, array $steps): void
    {
        foreach ($steps as $step) {
            $product->steps()->create([
                'title' => $step['title'],
                'step_number' => $step['step_number'],
                'description' => $step['description'],
            ]);
        }
    }

    /**
     * إنشاء أو جلب نوع المنتج.
     */
    protected function resolveProductType(?int $typeId, ?array $typeData): ?int
    {
        if ($typeId) {
            return $typeId;
        }

        if ($typeData && !empty($typeData['name'])) {
            $type = ProductType::firstOrCreate(
                ['name' => trim($typeData['name'])]
            );

            return $type->id;
        }

        return null;
    }

    /**
     * تنظيف كاش المنتجات.
     */
    protected function clearProductCache($productId = null): void
    {
        Cache::forget('products_all');

        if ($productId) {
            Cache::forget("product_{$productId}");
        }
    }

    /**
     * رفع صورة واحدة كـ WebP (helper مختصر).
     */
    protected function uploadImage(\Illuminate\Http\UploadedFile $file): string
    {
        return $this->storeAsWebp(
            $file,
            'products',
            self::IMG_QUALITY,
            self::IMG_MAX_WIDTH
        );
    }

    /**
     * توليد URL للصورة — يدعم المكان الجديد (Storage) والقديم (public_path).
     */
   
/**
 * Generate image URL for both Storage and legacy public images.
 */
protected function imageUrl(?string $path): ?string
{
    if (!$path) {
        return null;
    }

    $path = ltrim($path, '/');

    // Remove storage/ prefix if already present.
    if (str_starts_with($path, 'storage/')) {
        $path = substr($path, 8);
    }

    // New images stored in storage/app/public.
    if (Storage::disk('public')->exists($path)) {
        return asset('storage/' . $path);
    }

    // Legacy images stored directly in public/.
    if (file_exists(public_path($path))) {
        return asset($path);
    }

    return asset('storage/' . $path);
}

    /**
     * حذف صورة من المكانين (Storage + public_path) للتوافق مع البيانات القديمة.
     */
    protected function deleteProductImage(?string $path): void
    {
        if (!$path) {
            return;
        }

        // Storage
        $this->deleteImage($path);

        // public_path (للصور القديمة)
        $fullPath = public_path($path);
        if (is_file($fullPath)) {
            @unlink($fullPath);
        }
    }

    /**
     * جلب جميع المنتجات.
     */
    public function index()
    {
        $products = Cache::remember('products_all', 600, function () {
            $products = Product::with([
                'category',
                'brand',
                'productType',
                'reviews',
                'steps',
            ])->get();

            $now = Carbon::now();

            $products->transform(function ($product) use ($now) {

                if (
                    $product->discount_end_date &&
                    Carbon::parse($product->discount_end_date)->lt($now)
                ) {
                    $product->discount = 0;
                }

$product->rating_avg = $product->reviews->avg('rating') ?? 0;

// روابط الصور
$product->img_url = $this->imageUrl($product->img);

$product->images_urls = is_array($product->images)
    ? array_map(fn($img) => $this->imageUrl($img), $product->images)
    : [];

return $product;
            });

            return $products;
        });

        return response()->json([
            'products' => $products,
        ], 200);
    }

    /**
     * عرض منتج واحد بالتفاصيل.
     */
    public function show($id)
    {
        $product = Cache::remember("product_{$id}", 600, function () use ($id) {
            return Product::with([
                'category',
                'brand',
                'productType',
                'reviews',
                'steps',
            ])->findOrFail($id);
        });

      $product->img_url = $this->imageUrl($product->img);

$product->images_urls = is_array($product->images)
    ? array_map(fn($img) => $this->imageUrl($img), $product->images)
    : [];

return response()->json($product, 200);
    }

    /**
     * إنشاء منتج جديد.
     */
    public function store(Request $request)
    {
        $this->checkAdmin();

        $rules = [
            'name' => 'required|string',
            'code' => 'required|string|unique:products,code',
            'price_eg' => 'required|numeric',
            'price_ar' => 'required|numeric',
            'category_id' => 'required|exists:categories,id',
            'brand_id' => 'nullable|exists:brands,id',

            'type_id' => 'nullable|exists:product_types,id',
            'type' => 'nullable|array',
            'type.name' => 'required_with:type|string|max:255',

            'img' => 'nullable|image|max:20048',
            'images' => 'nullable|array',
            'images.*' => 'image|max:20048',

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

            'youtube_video_url' => [
                'nullable',
                'url',
                'max:2048',
                'regex:/^https?:\/\/(www\.)?(youtube\.com|youtu\.be)\//i',
            ],
        ];

        $validator = Validator::make(
            $request->all(),
            array_merge($rules, $this->getStepsValidationRules())
        );

        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors(),
            ], 422);
        }

        $data = $validator->validated();

        $imgPath = null;
        $imagePaths = [];

        // ============ رفع الصور وتحويلها لـ WebP ============
        try {
            if ($request->hasFile('img')) {
                $imgPath = $this->uploadImage($request->file('img'));
            }

            if ($request->hasFile('images')) {
                foreach ($request->file('images') as $image) {
                    $imagePaths[] = $this->uploadImage($image);
                }
            }
        } catch (\Throwable $e) {
            // فشل رفع الصور → نظّف أي ملف اترفع قبل الفشل
            $this->deleteProductImage($imgPath);
            foreach ($imagePaths as $p) {
                $this->deleteProductImage($p);
            }

            throw $e;
        }

        // معالجة specs
        $specsInput = $request->input('specs', []);
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

        try {
            $product = DB::transaction(function () use ($data, $imgPath, $imagePaths, $specs) {

                $typeId = $this->resolveProductType(
                    $data['type_id'] ?? null,
                    $data['type'] ?? null
                );

                $product = Product::create([
                    'name' => $data['name'],
                    'name_en' => $data['name_en'] ?? null,
                    'code' => $data['code'],

                    'price_eg' => $data['price_eg'],
                    'price_ar' => $data['price_ar'],

                    'category_id' => $data['category_id'],
                    'brand_id' => $data['brand_id'] ?? null,
                    'type_id' => $typeId,

                    'img' => $imgPath,
                    'images' => $imagePaths,

                    'description' => $data['description'] ?? null,
                    'description_en' => $data['description_en'] ?? null,

                    'discount' => $data['discount'] ?? 0,
                    'specs' => $specs,

                    'quantity' => $data['quantity'] ?? 0,
                    'isFeatured' => $data['isFeatured'] ?? 0,

                    'discount_end_date' => $data['discount_end_date'] ?? null,
                    'rating' => $data['rating'] ?? null,

                    'seo_keywords' => $data['seo_keywords'] ?? null,
                    'seo_description' => $data['seo_description'] ?? null,

                    'youtube_video_url' => $data['youtube_video_url'] ?? null,
                ]);

                if (!empty($data['steps'])) {
                    $this->saveProductSteps($product, $data['steps']);
                }

                return $product;
            });

            $this->clearProductCache($product->id);

            $product->load([
                'category',
                'brand',
                'productType',
                'reviews',
                'steps',
            ]);

            return response()->json([
                'message' => 'Product created successfully',
                'product' => $product,
                'img_url' => $this->imageUrl($imgPath),
                'images_urls' => array_map(
                    fn($img) => $this->imageUrl($img),
                    $imagePaths
                ),
            ], 201);

        } catch (\Throwable $e) {
            // DB فشل → احذف الصور المرفوعة
            $this->deleteProductImage($imgPath);
            foreach ($imagePaths as $p) {
                $this->deleteProductImage($p);
            }

            throw $e;
        }
    }

    /**
     * تحديث منتج.
     */
    public function update(Request $request, $id)
    {
        $this->checkAdmin();

        $product = Product::findOrFail($id);

        $rules = [
            'name' => 'sometimes|required|string',
            'code' => 'sometimes|required|string|unique:products,code,' . $product->id,

            'price_eg' => 'required|numeric',
            'price_ar' => 'required|numeric',

            'category_id' => 'nullable|exists:categories,id',
            'brand_id' => 'nullable|exists:brands,id',

            'type_id' => 'nullable|exists:product_types,id',
            'type' => 'nullable|array',
            'type.name' => 'required_with:type|string|max:255',

            'img' => 'nullable|image|max:20048',
            'images' => 'nullable|array',
            'images.*' => 'image|max:20048',

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

            'youtube_video_url' => [
                'nullable',
                'url',
                'max:2048',
                'regex:/^https?:\/\/(www\.)?(youtube\.com|youtu\.be)\//i',
            ],
        ];

        $validator = Validator::make(
            $request->all(),
            array_merge($rules, $this->getStepsValidationRules())
        );

        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors(),
            ], 422);
        }

        $data = $validator->validated();

        $oldImages = [];  // هنحذفها بعد نجاح الـ DB
        $newImages = [];  // هنحذفها لو الـ DB فشل

        try {
            // الصورة الرئيسية الجديدة
            if ($request->hasFile('img')) {
                $newPath = $this->uploadImage($request->file('img'));
                $newImages[] = $newPath;

                if ($product->img) {
                    $oldImages[] = $product->img;
                }

                $data['img'] = $newPath;
            }

            // الصور الإضافية الجديدة
            if ($request->hasFile('images')) {
                if (is_array($product->images)) {
                    foreach ($product->images as $oldImage) {
                        $oldImages[] = $oldImage;
                    }
                }

                $imagePaths = [];
                foreach ($request->file('images') as $image) {
                    $newPath = $this->uploadImage($image);
                    $newImages[] = $newPath;
                    $imagePaths[] = $newPath;
                }

                $data['images'] = $imagePaths;
            }

            // معالجة specs
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

            DB::transaction(function () use ($product, $data) {

                $stepsProvided = array_key_exists('steps', $data);
                $steps = $data['steps'] ?? [];

                unset($data['steps']);

                if (array_key_exists('type_id', $data) || array_key_exists('type', $data)) {
                    $data['type_id'] = $this->resolveProductType(
                        $data['type_id'] ?? null,
                        $data['type'] ?? null
                    );
                }

                unset($data['type']);

                $product->update(
                    array_filter($data, fn($v) => $v !== null)
                );

                if ($stepsProvided) {
                    $product->steps()->delete();
                    if (!empty($steps)) {
                        $this->saveProductSteps($product, $steps);
                    }
                }
            });

            // ✅ الـ DB نجح → امسح الصور القديمة من Storage + public_path
            foreach ($oldImages as $oldPath) {
                $this->deleteProductImage($oldPath);
            }

            $this->clearProductCache($product->id);

            $product->refresh()->load([
                'category',
                'brand',
                'productType',
                'reviews',
                'steps',
            ]);

            return response()->json([
                'message' => 'تم تحديث المنتج بنجاح',
                'product' => $product,
                'img_url' => $this->imageUrl($product->img),
                'images_urls' => is_array($product->images)
                    ? array_map(fn($img) => $this->imageUrl($img), $product->images)
                    : [],
            ], 200);

        } catch (\Throwable $e) {
            // ❌ الـ DB فشل → امسح الصور الجديدة اللي اترفعت
            foreach ($newImages as $path) {
                $this->deleteProductImage($path);
            }

            throw $e;
        }
    }

    /**
     * حذف منتج مع خطواته وصوره.
     */
    public function destroy($id)
    {
        $this->checkAdmin();

        $product = Product::findOrFail($id);

        $productId = $product->id;

        $imgPath = $product->img;
        $images = is_array($product->images) ? $product->images : [];

        DB::transaction(function () use ($product) {
            $product->steps()->delete();
            $product->delete();
        });

        // احذف الصور من Storage + public_path
        $this->deleteProductImage($imgPath);
        foreach ($images as $image) {
            $this->deleteProductImage($image);
        }

        $this->clearProductCache($productId);

        return response()->json([
            'message' => 'Product deleted successfully',
        ], 200);
    }
}