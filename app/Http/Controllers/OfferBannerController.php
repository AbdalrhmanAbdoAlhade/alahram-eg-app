<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\OfferBanner;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Schema;
use Carbon\Carbon;
use Illuminate\Support\Facades\Cache;

class OfferBannerController extends Controller
{
    // حماية الوصول فقط للمسؤولين
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
    // 🧠 كاش لمدة 10 دقائق
    $banners = Cache::remember('offer_banners_all', 600, function () {
        // حذف العروض المنتهية
        OfferBanner::whereNotNull('end_date')
            ->where('end_date', '<', Carbon::now())
            ->each(function ($banner) {
                if ($banner->img) {
                    Storage::disk('public')->delete($banner->img);
                }
                $banner->delete();
            });

        // جلب البيانات مع العلاقات
        $data = OfferBanner::with(['category', 'product'])->get();

        // تعديل رابط الصورة بناءً على الحالة
        $data->transform(function ($banner) {
            $banner->img_url = ($banner->img && $banner->img_status)
                ? url('storage/' . $banner->img)
                : null;
            return $banner;
        });

        return $data;
    });

    return response()->json($banners);
}

public function show($id)
{
    // 🧠 كاش لكل بانر على حدة
    $banner = Cache::remember("offer_banner_{$id}", 600, function () use ($id) {
        return OfferBanner::with(['category', 'product'])->findOrFail($id);
    });

    return response()->json($banner);
}



    public function store(Request $request)
    {
        $this->checkAdmin();

        $validated = $request->validate([
            'title' => 'nullable|string|max:255',
            'description' => 'nullable|string',
                        'title_en' => 'nullable|string|max:255',
            'description_en' => 'nullable|string',
            'category_id' => 'nullable|exists:categories,id',
            'product_id' => 'nullable|exists:products,id',
            'end_date' => 'nullable|date',
            'img_status' => 'nullable|boolean',
            'discount' => 'nullable|numeric|min:0',
            'img' => 'required|image|max:20048',
            
        ]);

    if ($request->hasFile('img')) {
        $file = $request->file('img');
        $filename = uniqid() . '.' . $file->getClientOriginalExtension();
        $file->move(public_path('offer_banners'), $filename);
        $validated['img'] = 'offer_banners/' . $filename;
    }
        $banner = OfferBanner::create($validated);

        return response()->json([
            'message' => 'Offer banner created successfully',
            
            'offer_banner' => $banner,
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $this->checkAdmin();

        $banner = OfferBanner::findOrFail($id);

        $validated = $request->validate([
            'title' => 'nullable|string|max:255',
            'description' => 'nullable|string',
                        'title_en' => 'nullable|string|max:255',
            'description_en' => 'nullable|string',
            'category_id' => 'nullable|exists:categories,id',
            'product_id' => 'nullable|exists:products,id',
            'end_date' => 'nullable|date',
            'img_status' => 'nullable|boolean',
            'discount' => 'nullable|numeric|min:0',
            'img' => 'nullable|image|max:20048',
            
        ]);

     if ($request->hasFile('img')) {
        // حذف الصورة القديمة من public/offer_banners لو موجودة
        if ($banner->img && file_exists(public_path($banner->img))) {
            unlink(public_path($banner->img));
        }
        $file = $request->file('img');
        $filename = uniqid() . '.' . $file->getClientOriginalExtension();
        $file->move(public_path('offer_banners'), $filename);
        $validated['img'] = 'offer_banners/' . $filename;
    }

        $banner->update($validated);

Cache::forget('offer_banners_all');
Cache::forget("offer_banner_{$banner->id}");


        return response()->json([
            'message' => 'Offer banner updated successfully',
            'offer_banner' => $banner,
        ]);
    }

    public function destroy($id)
    {
        $this->checkAdmin();

        $banner = OfferBanner::findOrFail($id);

        if ($banner->img) {
            Storage::disk('public')->delete($banner->img);
        }

        $banner->delete();

        return response()->json(['message' => 'Offer banner deleted successfully']);
    }
    
public function createOfferForAllProducts(Request $request)
{
    $this->checkAdmin();

    $validated = $request->validate([
        'title' => 'nullable|string|max:255',
        'description' => 'nullable|string',
        'title_en' => 'nullable|string|max:255',
        'description_en' => 'nullable|string',
        'category_id' => 'nullable|exists:categories,id',
        'end_date' => 'nullable|date',
        'img_status' => 'nullable|boolean',
        'discount' => 'required|numeric|min:0',
        'img' => 'required|image|max:2048',
    ]);

    // رفع الصورة مرة واحدة لجميع العروض
     if ($request->hasFile('img')) {
        $file = $request->file('img');
        $filename = uniqid() . '.' . $file->getClientOriginalExtension();
        $file->move(public_path('offer_banners'), $filename);
        $validated['img'] = 'offer_banners/' . $filename;
    }

    $products = \App\Models\Product::all();

    foreach ($products as $product) {
        // تحديث الخصم في جدول المنتجات
        $product->discount = $validated['discount'];
        if (!empty($validated['end_date'])) {
            $product->discount_end_date = $validated['end_date'];
        }
        $product->save();

        // إنشاء بانر للمنتج
        OfferBanner::create([
            'title' => $validated['title'] ?? null,
            'description' => $validated['description'] ?? null,
            'title_en' => $validated['title_en'] ?? null,
            'description_en' => $validated['description_en'] ?? null,
            'category_id' => $validated['category_id'] ?? null,
            'product_id' => $product->id,
            'end_date' => $validated['end_date'] ?? null,
            'img_status' => $validated['img_status'] ?? true,
            'discount' => $validated['discount'],
            'img' => $validated['img'],
        ]);
    }
// 🧹 تنظيف الكاش بعد الإضافة
Cache::forget('offer_banners_all');
Cache::forget("offer_banner_{$banner->id}");

    return response()->json(['message' => '✅ تم إنشاء عروض لجميع المنتجات وتحديث الخصم بنجاح']);
}

public function getOffersForAllProducts()
{
   

    $banners = OfferBanner::with(['category', 'product'])
        ->whereNotNull('product_id')
        ->get();

    // تعديل img_url بناءً على img_status
    $banners->transform(function ($banner) {
        $banner->img_url = ($banner->img && $banner->img_status) ? url('storage/' . $banner->img) : null;
        return $banner;
    });

    return response()->json($banners);
}



public function deleteOffersForAllProducts()
{
    $this->checkAdmin();

    $banners = OfferBanner::whereNotNull('product_id')->get();

    foreach ($banners as $banner) {
        // إعادة الخصم إلى 0 في المنتج المرتبط
        if ($banner->product_id) {
            $product = \App\Models\Product::find($banner->product_id);
            if ($product) {
                $product->discount = 0;

                // لو عندك حقل تاريخ نهاية الخصم
                if (Schema::hasColumn('products', 'discount_end_date')) {
                    $product->discount_end_date = null;
                }

                $product->save();
            }
        }

        // حذف صورة البانر إن وجدت
        if ($banner->img && file_exists(public_path($banner->img))) {
            unlink(public_path($banner->img));
        }

        $banner->delete();
    }
// 🧹 تنظيف الكاش بعد الإضافة
Cache::forget('offer_banners_all');
Cache::forget("offer_banner_{$banner->id}");

    return response()->json(['message' => '✅ تم حذف جميع العروض وتصفير الخصم من المنتجات.']);
}


}
