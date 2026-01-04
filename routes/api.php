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
use App\Http\Controllers\DeliveryAreaController;
use App\Http\Controllers\SettingController;
use Illuminate\Support\Facades\Mail;
use App\Http\Controllers\MailController;
use App\Http\Controllers\UserNotificationController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\WhatsAppController;


Route::post('sendBulkMessage', [WhatsAppController::class, 'sendBulkMessage']);
    Route::post('sendMessage', [WhatsAppController::class, 'sendMessage']);
// خارج الميدل وير (للزوار)
Route::get('services', [ServiceController::class, 'index']);
Route::get('services/{id}', [ServiceController::class, 'show']);

// داخل الميدل وير (للمشرفين)
Route::middleware('auth:sanctum')->group(function () {
    // استخدم {id} بدلاً من {service} لتطابق الكنترولر
    Route::post('services/{id}', [ServiceController::class, 'update']); 
    Route::post('services', [ServiceController::class, 'store']);
    Route::delete('services/{id}', [ServiceController::class, 'destroy']);
});
// Public route
Route::get('delivery-areas', [DeliveryAreaController::class, 'index']);

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('delivery-areas', DeliveryAreaController::class)->except(['index']);
    
    Route::post('settings/update', [SettingController::class, 'update']);
});

Route::post('verify-otp', [AuthController::class, 'verifyOtp']);
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/update-profile', [AuthController::class, 'updateProfile']);
    Route::put('/change-password', [AuthController::class, 'changePassword']);
      Route::post('admin/create-user', [AuthController::class, 'createUserByAdmin']);
        Route::post('admin/update-user/{id}', [AuthController::class, 'updateUserByAdmin']);
        Route::delete('admin/delete-user/{id}', [AuthController::class, 'deleteUserByAdmin']);
        Route::get('admin/users', [AuthController::class, 'getAllUsers']);
});

// Auth routes
Route::post('login', [AuthController::class, 'login']);
Route::post('register', [AuthController::class, 'register']);
Route::middleware('auth:sanctum')->post('logout', [AuthController::class, 'logout']);

// Public (index, show only)
Route::apiResource('discount-coupons', DiscountCouponController::class)->only(['index', 'show']);
Route::apiResource('about-us', AboutUsController::class)->only(['index', 'show']);
Route::apiResource('returns-policy', ReturnsPolicyController::class)->only(['index', 'show']);
Route::apiResource('privacy-policy', PrivacyPolicyController::class)->only(['index', 'show']);
Route::apiResource('shipping-info', ShippingInfoController::class)->only(['index', 'show']);
Route::apiResource('store-info', StoreInfoController::class)->only(['index', 'show']);
Route::apiResource('contact-us', ContactUsController::class)->only(['index', 'store','show']);
Route::apiResource('banners', BannerController::class)->only(['index', 'show']);
Route::apiResource('offer-banners', OfferBannerController::class)->only(['index', 'show']);
Route::apiResource('categories', CategoryController::class)->only(['index', 'show']);
Route::apiResource('brands', BrandController::class)->only(['index', 'show']);
Route::apiResource('testimonials', TestimonialController::class)->only(['index', 'show']);
Route::apiResource('products', ProductController::class)->only(['index', 'show']);
Route::apiResource('product-reviews', ProductReviewController::class)->only(['index', 'show', 'store']);

// Protected routes (only auth, no admin)
Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('discount-coupons', DiscountCouponController::class)->except(['index', 'show']);
    Route::apiResource('about-us', AboutUsController::class)->except(['index', 'show']);
    Route::post('about-us/{id}', [AboutUsController::class, 'update']);
    Route::apiResource('returns-policy', ReturnsPolicyController::class)->except(['index', 'show']);
    Route::apiResource('privacy-policy', PrivacyPolicyController::class)->except(['index', 'show']);
    Route::apiResource('shipping-info', ShippingInfoController::class)->except(['index', 'show']);
    Route::apiResource('store-info', StoreInfoController::class)->except(['index', 'show']);
    Route::apiResource('contact-us', ContactUsController::class)->except(['index','store', 'show']);
    Route::apiResource('banners', BannerController::class)->except(['index', 'show']);
    Route::apiResource('offer-banners', OfferBannerController::class)->except(['index', 'show']);
    Route::apiResource('categories', CategoryController::class)->except(['index', 'show']);
    Route::apiResource('brands', BrandController::class)->except(['index', 'show']);
    Route::apiResource('testimonials', TestimonialController::class)->except(['index', 'show']);
    Route::apiResource('products', ProductController::class)->except(['index', 'show']);
Route::delete('product-reviews/{id}', [ProductReviewController::class, 'destroy']);
    Route::post('store-info/{id}', [StoreInfoController::class, 'update']);
     Route::post('banners/{id}', [BannerController::class, 'update']);
   Route::post('brands/{id}', [BrandController::class, 'update']);
   Route::post('/iframes', [IframeController::class, 'update']);
 Route::post('/products/update/{id}', [ProductController::class, 'update']);
  Route::post('/offer-banners/update/{id}', [OfferBannerController::class, 'update']);
    Route::post('/categories/update/{id}', [CategoryController::class, 'update']);

});

Route::post('/pay', [PaymentController::class, 'pay']);

     
    Route::get('/orders/{id}', [OrderController::class, 'show']);
      Route::post('/orders', [OrderController::class, 'store']);
Route::middleware('auth:sanctum')->group(function () {
 Route::get('/orders', [OrderController::class, 'index']);

    Route::delete('categories/{id}/banner', [CategoryController::class, 'deleteBanner']);
    Route::put('/orders/{id}', [OrderController::class, 'update']);
});
  Route::get('/ordersall', [OrderController::class, 'index']); // all orders

Route::middleware(['auth:sanctum'])->group(function () {
       Route::post('/offer-banners/create-for-all', [OfferBannerController::class, 'createOfferForAllProducts']);
  
});

Route::get('/offer-banners/all-products', [OfferBannerController::class, 'getOffersForAllProducts']);
Route::middleware('auth:sanctum')->post('/offer-banners/delete-for-all', [OfferBannerController::class, 'deleteOffersForAllProducts']);


Route::get('/iframes', [IframeController::class, 'index']);


Route::post('/payments/{id}', [PaymentController::class, 'updateStatus']);
Route::get('/payments', [PaymentController::class, 'index']);




Route::middleware('auth:sanctum')->group(function () {
    Route::get('notifications/unread-count', [UserNotificationController::class, 'unreadCount']);
    Route::post('notifications/mark-all-read', [UserNotificationController::class, 'markAllRead']);
    Route::post('notifications/{id}/mark-read', [UserNotificationController::class, 'markRead']);
    Route::apiResource('notifications', UserNotificationController::class)->except(['create', 'edit']);
    Route::get('admin/notifications', [UserNotificationController::class, 'adminIndex']);

});



Route::middleware('auth:sanctum')->post('/send-mail', [MailController::class, 'sendMail']);