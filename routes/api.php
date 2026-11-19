<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DiscountCouponController;
use App\Http\Controllers\AboutUsController;
use App\Http\Controllers\ReturnsPolicyController;
use App\Http\Controllers\PrivacyPolicyController;
use App\Http\Controllers\ShippingInfoController;
use App\Http\Controllers\StoreInfoController;
use App\Http\Controllers\ContactUsController;
use App\Http\Controllers\BannerController;
use App\Http\Controllers\OfferBannerController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\BrandController;
use App\Http\Controllers\TestimonialController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ProductReviewController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\IframeController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\MailController;
use App\Http\Controllers\UserNotificationController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\WhatsAppController;
use App\Http\Controllers\ProductTypeController;
use App\Http\Controllers\DeliveryAreaController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\RoleController;

// =====================================================
// 1) Public Routes (بدون تسجيل دخول)
// =====================================================

Route::get('product-types/by-category/{categoryId}', [ProductTypeController::class, 'byCategory']);
Route::get('delivery-areas', [DeliveryAreaController::class, 'index']);
Route::get('delivery-areas/{id}', [DeliveryAreaController::class, 'show']);

Route::get('services', [ServiceController::class, 'index']);
Route::get('services/{id}', [ServiceController::class, 'show']);

Route::get('settings', [SettingController::class, 'index']);

Route::get('/product-types', [ProductTypeController::class, 'index']);
Route::get('/product-types/{id}/products', [ProductTypeController::class, 'products']);

Route::get('/iframes', [IframeController::class, 'index']);

Route::get('/offer-banners/all-products', [OfferBannerController::class, 'getOffersForAllProducts']);

// =====================================================
// 2) Authentication (عام)
// =====================================================

Route::post('register', [AuthController::class, 'register'])->middleware('throttle:10,1');
Route::post('login', [AuthController::class, 'login'])->middleware('throttle:10,1');
Route::post('verify-otp', [AuthController::class, 'verifyOtp'])->middleware('throttle:5,1');

// =====================================================
// 3) الطلبات والدفع - عام
// =====================================================

Route::get('/payment-methods', [PaymentController::class, 'methods']);

Route::post('/orders', [OrderController::class, 'store'])->middleware('throttle:20,1');

Route::post('/orders/{id}/payment', [PaymentController::class, 'uploadReceipt'])
    ->middleware('throttle:20,1');

// =====================================================
// 4) Public Resources (قراءة فقط - بدون تسجيل دخول)
// =====================================================

Route::apiResource('discount-coupons', DiscountCouponController::class)->only(['index', 'show']);
Route::apiResource('about-us', AboutUsController::class)->only(['index', 'show']);
Route::apiResource('returns-policy', ReturnsPolicyController::class)->only(['index', 'show']);
Route::apiResource('privacy-policy', PrivacyPolicyController::class)->only(['index', 'show']);
Route::apiResource('shipping-info', ShippingInfoController::class)->only(['index', 'show']);
Route::apiResource('store-info', StoreInfoController::class)->only(['index', 'show']);
Route::apiResource('banners', BannerController::class)->only(['index', 'show']);
Route::apiResource('offer-banners', OfferBannerController::class)->only(['index', 'show']);
Route::apiResource('categories', CategoryController::class)->only(['index', 'show']);
Route::apiResource('brands', BrandController::class)->only(['index', 'show']);
Route::apiResource('testimonials', TestimonialController::class)->only(['index', 'show']);
Route::apiResource('products', ProductController::class)->only(['index', 'show']);
Route::apiResource('product-reviews', ProductReviewController::class)->only(['index', 'show', 'store']);

// تواصل معنا: الإرسال فقط مفتوح للجميع (باقي العمليات في القسم 22)
Route::post('contact-us', [ContactUsController::class, 'store'])
    ->middleware('throttle:10,1');

// =====================================================
// 5) العميل المسجل (auth:sanctum فقط - بدون صلاحيات إدارية)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {

    // الحساب
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/update-profile', [AuthController::class, 'updateProfile']);
    Route::put('/change-password', [AuthController::class, 'changePassword']);

    // الطلبات الخاصة بالعميل
    Route::get('/my-orders', [OrderController::class, 'myOrders']);
    // ⚠️ ملاحظة أمنية: لازم تضيف فحص ملكية في OrderController::show() لأن أي مستخدم مسجل يقدر يشوف أي طلب بالـ id
    Route::get('/orders/{id}', [OrderController::class, 'show']);

    // الإشعارات (خاصة بالمستخدم)
    Route::get('notifications/unread-count', [UserNotificationController::class, 'unreadCount']);
    Route::post('notifications/mark-all-read', [UserNotificationController::class, 'markAllRead']);
    Route::post('notifications/{id}/mark-read', [UserNotificationController::class, 'markRead']);
    Route::apiResource('notifications', UserNotificationController::class)
        ->except(['create', 'edit']);

    // الإيميل
    Route::post('/send-mail', [MailController::class, 'sendMail']);
});

// =====================================================
// 6) Product Types - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/product-types', [ProductTypeController::class, 'store'])
        ->middleware('permission:product-types.create');
    Route::put('/product-types/{id}', [ProductTypeController::class, 'update'])
        ->middleware('permission:product-types.update');
    Route::delete('/product-types/{id}', [ProductTypeController::class, 'destroy'])
        ->middleware('permission:product-types.delete');
});

// =====================================================
// 7) Delivery Areas - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('delivery-areas', [DeliveryAreaController::class, 'store'])
        ->middleware('permission:delivery-areas.create');
    Route::put('delivery-areas/{id}', [DeliveryAreaController::class, 'update'])
        ->middleware('permission:delivery-areas.update');
    Route::delete('delivery-areas/{id}', [DeliveryAreaController::class, 'destroy'])
        ->middleware('permission:delivery-areas.delete');
});

// =====================================================
// 8) Admin - إدارة المستخدمين (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->prefix('admin')->group(function () {

    // ========== Roles ==========
    Route::get('roles', [RoleController::class, 'index'])
        ->middleware('permission:roles.view');

    Route::get('roles/{id}', [RoleController::class, 'show'])
        ->middleware('permission:roles.view');

    // ========== Permissions ==========
    Route::get('permissions', [PermissionController::class, 'index'])
        ->middleware('permission:roles.view');  // أو اعمل permission جديد اسمه permissions.view

    Route::get('roles/{id}/permissions', [PermissionController::class, 'byRole'])
        ->middleware('permission:roles.view');

    Route::put('roles/{id}/permissions', [PermissionController::class, 'syncRolePermissions'])
        ->middleware('permission:roles.manage');

    // رسائل واتساب إدارية
    Route::post('sendMessage', [WhatsAppController::class, 'sendMessage'])
        ->middleware('permission:whatsapp.send');
    Route::post('sendBulkMessage', [WhatsAppController::class, 'sendBulkMessage'])
        ->middleware('permission:whatsapp.send');

    // إدارة المستخدمين
    Route::get('users', [AuthController::class, 'getAllUsers'])
        ->middleware('permission:users.view');

    Route::post('create-user', [AuthController::class, 'createUserByAdmin'])
        ->middleware([
            'permission:users.create',
            'permission:users.assign_roles',
        ]);

    Route::post('update-user/{id}', [AuthController::class, 'updateUserByAdmin'])
        ->middleware('permission:users.update');

    Route::delete('delete-user/{id}', [AuthController::class, 'deleteUserByAdmin'])
        ->middleware('permission:users.delete');

    // إشعارات الأدمن
    Route::get('notifications', [UserNotificationController::class, 'adminIndex'])
        ->middleware('permission:notifications.view');
});

// =====================================================
// 9) Orders - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/orders', [OrderController::class, 'index'])
        ->middleware('permission:orders.view');
    Route::put('/orders/{id}', [OrderController::class, 'update'])
        ->middleware('permission:orders.update');
});

// =====================================================
// 10) Payments - مراجعة (Permissions)
// =====================================================

Route::middleware(['auth:sanctum', 'permission:review-payments'])
    ->prefix('admin/payments')
    ->group(function () {
        Route::get('/', [PaymentController::class, 'index']);
        Route::post('/{id}/approve', [PaymentController::class, 'approve']);
        Route::post('/{id}/reject', [PaymentController::class, 'reject']);
    });

// =====================================================
// 11) الحذف المالي (Soft Delete - permission خاصة)
// =====================================================

Route::middleware(['auth:sanctum', 'permission:delete-financial-records'])->group(function () {
    Route::delete('/orders/{id}', [OrderController::class, 'destroy']);
    Route::delete('/admin/payments/{id}', [PaymentController::class, 'destroy']);
});

// =====================================================
// 12) Settings & WhatsApp (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('settings/update', [SettingController::class, 'update'])
        ->middleware('permission:settings.update');

    Route::post('sendBulkMessage', [WhatsAppController::class, 'sendBulkMessage'])
        ->middleware('permission:whatsapp.send');
    Route::post('sendMessage', [WhatsAppController::class, 'sendMessage'])
        ->middleware('permission:whatsapp.send');
});

// =====================================================
// 13) Services - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('services', [ServiceController::class, 'store'])
        ->middleware('permission:services.create');
    Route::post('services/{id}', [ServiceController::class, 'update'])
        ->middleware('permission:services.update');
    Route::delete('services/{id}', [ServiceController::class, 'destroy'])
        ->middleware('permission:services.delete');
});

// =====================================================
// 14) Products - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('products', [ProductController::class, 'store'])
        ->middleware('permission:products.create');

    // دعم PUT عادي + POST (للـ multipart form-data)
    Route::put('products/{id}', [ProductController::class, 'update'])
        ->middleware('permission:products.update');
    Route::post('/products/update/{id}', [ProductController::class, 'update'])
        ->middleware('permission:products.update');

    Route::delete('products/{id}', [ProductController::class, 'destroy'])
        ->middleware('permission:products.delete');
});

// =====================================================
// 15) Categories - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('categories', [CategoryController::class, 'store'])
        ->middleware('permission:categories.create');

    Route::put('categories/{id}', [CategoryController::class, 'update'])
        ->middleware('permission:categories.update');
    Route::post('/categories/update/{id}', [CategoryController::class, 'update'])
        ->middleware('permission:categories.update');

    Route::delete('categories/{id}', [CategoryController::class, 'destroy'])
        ->middleware('permission:categories.delete');

    Route::delete('categories/{id}/banner', [CategoryController::class, 'deleteBanner'])
        ->middleware('permission:categories.update');
});

// =====================================================
// 16) Brands - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('brands', [BrandController::class, 'store'])
        ->middleware('permission:brands.create');

    Route::put('brands/{id}', [BrandController::class, 'update'])
        ->middleware('permission:brands.update');
    Route::post('brands/{id}', [BrandController::class, 'update'])
        ->middleware('permission:brands.update');

    Route::delete('brands/{id}', [BrandController::class, 'destroy'])
        ->middleware('permission:brands.delete');
});

// =====================================================
// 17) Banners - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('banners', [BannerController::class, 'store'])
        ->middleware('permission:banners.create');

    Route::put('banners/{id}', [BannerController::class, 'update'])
        ->middleware('permission:banners.update');
    Route::post('banners/{id}', [BannerController::class, 'update'])
        ->middleware('permission:banners.update');

    Route::delete('banners/{id}', [BannerController::class, 'destroy'])
        ->middleware('permission:banners.delete');
});

// =====================================================
// 18) Offer Banners - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('offer-banners', [OfferBannerController::class, 'store'])
        ->middleware('permission:offer-banners.create');

    Route::put('offer-banners/{id}', [OfferBannerController::class, 'update'])
        ->middleware('permission:offer-banners.update');
    Route::post('/offer-banners/update/{id}', [OfferBannerController::class, 'update'])
        ->middleware('permission:offer-banners.update');

    Route::post('/offer-banners/create-for-all', [OfferBannerController::class, 'createOfferForAllProducts'])
        ->middleware('permission:offer-banners.create');

    Route::post('/offer-banners/delete-for-all', [OfferBannerController::class, 'deleteOffersForAllProducts'])
        ->middleware('permission:offer-banners.delete');

    Route::delete('offer-banners/{id}', [OfferBannerController::class, 'destroy'])
        ->middleware('permission:offer-banners.delete');
});

// =====================================================
// 19) Testimonials - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('testimonials', [TestimonialController::class, 'store'])
        ->middleware('permission:testimonials.create');

    Route::put('testimonials/{id}', [TestimonialController::class, 'update'])
        ->middleware('permission:testimonials.update');
    Route::post('testimonials/{id}', [TestimonialController::class, 'update'])
        ->middleware('permission:testimonials.update');

    Route::delete('testimonials/{id}', [TestimonialController::class, 'destroy'])
        ->middleware('permission:testimonials.delete');
});

// =====================================================
// 20) Discount Coupons - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->group(function () {
    Route::post('discount-coupons', [DiscountCouponController::class, 'store'])
        ->middleware('permission:discount-coupons.create');

    Route::put('discount-coupons/{id}', [DiscountCouponController::class, 'update'])
        ->middleware('permission:discount-coupons.update');
    Route::post('discount-coupons/{id}', [DiscountCouponController::class, 'update'])
        ->middleware('permission:discount-coupons.update');

    Route::delete('discount-coupons/{id}', [DiscountCouponController::class, 'destroy'])
        ->middleware('permission:discount-coupons.delete');
});

// =====================================================
// 21) Content Management (About/Returns/Privacy/Shipping/Store)
// =====================================================

Route::middleware(['auth:sanctum', 'permission:content.update'])->group(function () {

    Route::apiResource('about-us', AboutUsController::class)->except(['index', 'show']);
    Route::post('about-us/{id}', [AboutUsController::class, 'update']);

    Route::apiResource('returns-policy', ReturnsPolicyController::class)->except(['index', 'show']);
    Route::apiResource('privacy-policy', PrivacyPolicyController::class)->except(['index', 'show']);
    Route::apiResource('shipping-info', ShippingInfoController::class)->except(['index', 'show']);

    Route::apiResource('store-info', StoreInfoController::class)->except(['index', 'show']);
    Route::post('store-info/{id}', [StoreInfoController::class, 'update']);

    // فتح/قفل المتجر (كان public على GET، دلوقتي محمي وبـ POST)
    Route::post('store/toggle-status', [StoreInfoController::class, 'toggleStatus']);
});

// =====================================================
// 22) Contact Us - إدارة (Permissions)
// =====================================================

Route::middleware('auth:sanctum')->prefix('contact-us')->group(function () {

    Route::get('/', [ContactUsController::class, 'index'])
        ->middleware('permission:contact-us.view');

    // لازم قبل {id} عشان ما يتعاملش معاه كـ id
    Route::patch('read-all', [ContactUsController::class, 'markAllAsRead'])
        ->middleware('permission:contact-us.update');

    Route::get('{id}', [ContactUsController::class, 'show'])
        ->middleware('permission:contact-us.view');

    Route::put('{id}', [ContactUsController::class, 'update'])
        ->middleware('permission:contact-us.update');

    Route::patch('{id}/read', [ContactUsController::class, 'markAsRead'])
        ->middleware('permission:contact-us.update');

    Route::patch('{id}/unread', [ContactUsController::class, 'markAsUnread'])
        ->middleware('permission:contact-us.update');

    Route::delete('{id}', [ContactUsController::class, 'destroy'])
        ->middleware('permission:contact-us.delete');
});

// =====================================================
// 23) Product Reviews - حذف (Permission)
// =====================================================

Route::middleware(['auth:sanctum', 'permission:product-reviews.delete'])->group(function () {
    Route::delete('product-reviews/{id}', [ProductReviewController::class, 'destroy']);
});

// =====================================================
// 24) Iframes - تحديث (Permission)
// =====================================================

Route::middleware(['auth:sanctum', 'permission:iframes.update'])->group(function () {
    Route::post('/iframes', [IframeController::class, 'update']);
});