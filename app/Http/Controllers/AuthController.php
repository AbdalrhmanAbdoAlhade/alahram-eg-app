<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Mail;
use App\Mail\UserNotificationMail;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Hash;
use App\Jobs\SendWhatsAppMessageJob; // استدعاء الـ Job الجديد

class AuthController extends Controller
{
    /**
     * دالة مساعدة داخلية لتمرير الرسائل للطابور
     */
    private function dispatchWhatsApp($phone, $message)
    {
        SendWhatsAppMessageJob::dispatch($phone, $message);
    }

    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'name_en' => 'nullable|string',
            'phone' => 'required|string|unique:users,phone',
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $path = null;
        if ($request->hasFile('profile_picture')) {
            $file = $request->file('profile_picture');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('profile_pictures'), $filename);
            $path = 'profile_pictures/' . $filename;
        }

        $user = User::create([
            'name' => $request->name,
            'name_en' => $request->name_en,
            'phone' => $request->phone,
            'profile_picture' => $path,
            'password' => bcrypt('123456'), // كلمة سر افتراضية
        ]);

        // إنشاء OTP
        $otp = rand(100000, 999999);
        $user->update([
            'otp' => $otp,
            'otp_expires_at' => now()->addMinutes(5),
        ]);

        // إرسال OTP واتساب عبر الطابور (تحديث طريقة الإرسال)
        $msg = " *رمز تسجيل الدخول - شركة الأهرام*\n\nرمز التحقق:\n*{$otp}*\n\n صالح لمدة 5 دقائق\n لا تشارك الرمز";
        
        $this->dispatchWhatsApp($user->phone, $msg);

        $user->profile_picture_url = $user->profile_picture ? url($user->profile_picture) : null;

        return response()->json([
            'message' => 'تم إنشاء الحساب بنجاح، تحقق من هاتفك للحصول على OTP',
            'user' => $user,
        ], 201);
    }

    public function updateProfile(Request $request)
    {
        $request->validate([
            'name' => 'nullable|string',
            'name_en' => 'nullable|string',
            'email' => 'nullable|email|unique:users,email,' . $request->user()->id,
            'phone' => 'nullable|string',
            'address' => 'nullable|string',
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $user = $request->user();

        $data = [
            'name' => $request->name ?? $user->name,
            'name_en' => $request->name_en ?? $user->name_en,
            'email' => $request->email ?? $user->email,
            'phone' => $request->phone ?? $user->phone,
            'address' => $request->address ?? $user->address,
        ];

        if ($request->hasFile('profile_picture')) {
            if ($user->profile_picture && file_exists(public_path($user->profile_picture))) {
                unlink(public_path($user->profile_picture));
            }

            $file = $request->file('profile_picture');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('profile_pictures'), $filename);
            $data['profile_picture'] = 'profile_pictures/' . $filename;
        }

        $user->update($data);

        $user->profile_picture_url = $user->profile_picture ? url($user->profile_picture) : null;

        return response()->json(['message' => 'Profile updated successfully', 'user' => $user]);
    }

    public function changePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required|string',
            'new_password' => 'required|string|min:6|confirmed',
        ]);

        $user = $request->user();

        if (! Hash::check($request->current_password, $user->password)) {
            return response()->json(['message' => 'Current password is incorrect'], 400);
        }

        $user->update([
            'password' => bcrypt($request->new_password),
        ]);

        return response()->json(['message' => 'Password changed successfully']);
    }

    public function createUserByAdmin(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:6',
            'role' => 'required|in:director,employee',
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $admin = $request->user();
        if (!in_array($admin->role, ['admin', 'director'])) {
            return response()->json(['message' => 'غير مسموح لك'], 403);
        }

        $path = null;
        if ($request->hasFile('profile_picture')) {
            $file = $request->file('profile_picture');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('profile_pictures'), $filename);
            $path = 'profile_pictures/' . $filename;
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'role' => $request->role,
            'profile_picture' => $path,
        ]);

        $user->profile_picture_url = $user->profile_picture ? url($user->profile_picture) : null;

        return response()->json([
            'message' => 'تم إنشاء المستخدم بنجاح',
            'user' => $user,
        ], 201);
    }

    public function login(Request $request)
    {
        // Email + Password
        if ($request->filled('email')) {
            $request->validate([
                'email' => 'required|email',
                'password' => 'required|string',
            ]);

            $user = User::where('email', $request->email)->first();

            if (! $user || ! Hash::check($request->password, $user->password)) {
                return response()->json(['message' => 'بيانات غير صحيحة'], 401);
            }

            $token = $user->createToken('api-token')->plainTextToken;

            return response()->json([
                'message' => 'تم تسجيل الدخول بنجاح',
                'token' => $token,
                'user' => $user
            ]);
        }

        // Phone + OTP
        if ($request->filled('phone')) {
            $request->validate([
                'phone' => 'required|string|exists:users,phone',
            ]);

            $user = User::where('phone', $request->phone)->first();
            $otp = rand(100000, 999999);

            $user->update([
                'otp' => $otp,
                'otp_expires_at' => now()->addMinutes(5),
            ]);

            // إرسال OTP واتساب عبر الطابور (تحديث طريقة الإرسال)
            $msg = " *رمز تسجيل الدخول - شركة الأهرام*\n\nرمز التحقق:\n *{$otp}*\n\n صالح لمدة 5 دقائق\n لا تشارك الرمز";

            $this->dispatchWhatsApp($user->phone, $msg);

            return response()->json([
                'message' => 'تم إرسال كود التحقق'
            ]);
        }

        return response()->json(['message' => 'البيانات غير مكتملة'], 422);
    }

    public function verifyOtp(Request $request)
    {
        $request->validate([
            'phone' => 'required|string|exists:users,phone',
            'otp' => 'required|string',
        ]);

        $user = User::where('phone', $request->phone)->first();

        if ($user->otp !== $request->otp || now()->gt($user->otp_expires_at)) {
            return response()->json(['message' => 'كود التحقق غير صحيح أو منتهي'], 401);
        }

        $user->update([
            'otp' => null,
            'otp_expires_at' => null,
        ]);

        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json([
            'message' => 'تم تسجيل الدخول بنجاح',
            'token' => $token,
            'user' => $user
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Logged out successfully']);
    }

    public function updateUserByAdmin(Request $request, $id)
    {
        $admin = $request->user();
        if (!in_array($admin->role, ['admin', 'director'])) {
            return response()->json(['message' => 'غير مسموح لك'], 403);
        }

        $user = User::find($id);
        if (! $user) {
            return response()->json(['message' => 'المستخدم غير موجود'], 404);
        }

        $request->validate([
            'name' => 'nullable|string',
            'email' => 'nullable|email|unique:users,email,' . $user->id,
            'role' => 'nullable|in:admin,director,employee,user',
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'accepts_emails' => 'nullable|boolean',
        ]);

        $data = $request->only(['name', 'email', 'role', 'accepts_emails']);

        if ($request->hasFile('profile_picture')) {
            if ($user->profile_picture && file_exists(public_path($user->profile_picture))) {
                unlink(public_path($user->profile_picture));
            }

            $file = $request->file('profile_picture');
            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('profile_pictures'), $filename);
            $data['profile_picture'] = 'profile_pictures/' . $filename;
        }

        $user->update($data);
        $user->profile_picture_url = $user->profile_picture ? url($user->profile_picture) : null;

        return response()->json(['message' => 'تم تحديث بيانات المستخدم بنجاح', 'user' => $user]);
    }

    public function deleteUserByAdmin(Request $request, $id)
    {
        $admin = $request->user();
        if (!in_array($admin->role, ['admin', 'director'])) {
            return response()->json(['message' => 'غير مسموح لك'], 403);
        }

        $user = User::find($id);
        if (! $user) {
            return response()->json(['message' => 'المستخدم غير موجود'], 404);
        }

        if ($user->profile_picture && file_exists(public_path($user->profile_picture))) {
            unlink(public_path($user->profile_picture));
        }

        $user->delete();
        return response()->json(['message' => 'تم حذف المستخدم بنجاح']);
    }

    public function getAllUsers(Request $request)
    {
        $admin = $request->user();
        if (!in_array($admin->role, ['admin', 'director'])) {
            return response()->json(['message' => 'غير مسموح لك'], 403);
        }

        $users = User::orderByDesc('id')->get()->map(function ($user) {
            $user->profile_picture_url = $user->profile_picture ? url($user->profile_picture) : null;
            return $user;
        });

        return response()->json(['users' => $users]);
    }
}