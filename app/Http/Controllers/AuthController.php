<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;
use Spatie\Permission\Models\Role;
use App\Jobs\SendWhatsAppMessageJob;


class AuthController extends Controller
{
    /**
     * إرسال رسائل واتساب من خلال Queue.
     */
    private function dispatchWhatsApp($phone, $message): void
    {
        app(\App\Services\WhatsAppService::class)->sendText($phone, $message);
    }

    /**
     * التأكد من امتلاك المستخدم للصلاحية المطلوبة.
     */
    private function ensurePermission(Request $request, string $permission): void
    {
        abort_unless(
            $request->user() && $request->user()->can($permission),
            403,
            'غير مسموح لك بتنفيذ هذا الإجراء'
        );
    }

    /**
     * الأدوار المتاحة في النظام.
     */
    private function availableRoles(): array
    {
        return ['admin', 'director', 'employee', 'user'];
    }

    /**
     * التحقق من إمكانية تعيين الدور.
     *
     * Admin: جميع الأدوار.
     * Director: director و employee فقط.
     */
    private function ensureAssignableRole(User $actor, string $roleName): void
    {
        abort_unless(
            $actor->can('users.assign_roles'),
            403,
            'لا تملك صلاحية تعيين الأدوار'
        );

        abort_unless(
            in_array($roleName, $this->availableRoles(), true),
            422,
            'الدور المطلوب غير صالح'
        );

        if ($actor->hasRole('admin', 'web')) {
            // Admin يستطيع تعيين جميع الأدوار المعتمدة.
        } elseif ($actor->hasRole('director', 'web')) {
            abort_unless(
                in_array($roleName, ['director', 'employee'], true),
                403,
                'لا يمكنك تعيين هذا الدور'
            );
        } else {
            abort(403, 'غير مسموح لك بتعيين الأدوار');
        }

        $exists = Role::where('name', $roleName)
            ->where('guard_name', 'web')
            ->exists();

        abort_unless($exists, 422, 'الدور غير موجود في النظام');
    }

    /**
     * تجهيز بيانات المستخدم للاستجابة.
     *
     * - role        : اسم الدور الحالي (Spatie)
     * - permissions : array بأسماء كل الصلاحيات (مباشرة + عبر الأدوار)
     * - profile_picture_url : رابط كامل للصورة
     *
     * ملاحظة: نستخدم تحميل مسبق (eager load) للعلاقات لتجنّب N+1.
     */
    private function formatUser(User $user, bool $withPermissions = true): User
    {
        // الدور الحالي (من Spatie)
        $user->setAttribute('role', $user->getRoleNames()->first());

        // الصلاحيات
        if ($withPermissions) {
            // حمّل العلاقات لو مش محمّلة (عشان getAllPermissions تكون سريعة)
            if (!$user->relationLoaded('roles')) {
                $user->load('roles.permissions');
            }
            if (!$user->relationLoaded('permissions')) {
                $user->load('permissions');
            }

            $user->setAttribute(
                'permissions',
                $user->getAllPermissions()
                    ->pluck('name')
                    ->unique()
                    ->values()
                    ->toArray()
            );
        }

        // رابط الصورة الكامل
        $user->profile_picture_url = $user->profile_picture
            ? url($user->profile_picture)
            : null;

        return $user;
    }

    /**
     * حفظ صورة المستخدم.
     */
    private function storeProfilePicture($file): string
    {
        $directory = public_path('profile_pictures');

        File::ensureDirectoryExists($directory);

        $filename = Str::uuid() . '.' . $file->getClientOriginalExtension();

        $file->move($directory, $filename);

        return 'profile_pictures/' . $filename;
    }

    /**
     * حذف صورة المستخدم القديمة.
     */
    private function deleteProfilePicture(?string $path): void
    {
        if (!$path) {
            return;
        }

        $fullPath = public_path($path);

        if (is_file($fullPath)) {
            unlink($fullPath);
        }
    }

    /**
     * تسجيل مستخدم جديد.
     */
    public function register(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'name_en' => 'nullable|string|max:255',
            'phone' => 'required|string|unique:users,phone',
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $path = null;

        if ($request->hasFile('profile_picture')) {
            $path = $this->storeProfilePicture(
                $request->file('profile_picture')
            );
        }

        try {
            $user = DB::transaction(function () use ($validated, $path) {
                $user = User::create([
                    'name' => $validated['name'],
                    'name_en' => $validated['name_en'] ?? null,
                    'phone' => $validated['phone'],
                    'profile_picture' => $path,
                    'password' => '123456',
                ]);

                $user->assignRole('user');

                $otp = (string) random_int(100000, 999999);

                $user->update([
                    'otp' => $otp,
                    'otp_expires_at' => now()->addMinutes(5),
                ]);

                return $user;
            });
        } catch (\Throwable $e) {
            $this->deleteProfilePicture($path);
            throw $e;
        }

        $msg = " *رمز تسجيل الدخول - شركة الأهرام*\n\n"
            . "رمز التحقق:\n*{$user->otp}*\n\n"
            . "صالح لمدة 5 دقائق\nلا تشارك الرمز";

        $this->dispatchWhatsApp($user->phone, $msg);

        return response()->json([
            'message' => 'تم إنشاء الحساب بنجاح، تحقق من هاتفك للحصول على OTP',
            'user' => $this->formatUser($user),
        ], 201);
    }

    /**
     * تحديث الملف الشخصي للمستخدم الحالي.
     */
    public function updateProfile(Request $request)
    {
        $user = $request->user();

        $validated = $request->validate([
            'name' => 'nullable|string|max:255',
            'name_en' => 'nullable|string|max:255',
            'email' => [
                'nullable',
                'email',
                Rule::unique('users', 'email')->ignore($user->id),
            ],
            'phone' => 'nullable|string',
            'address' => 'nullable|string',
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $data = [];

        foreach (['name', 'name_en', 'email', 'phone', 'address'] as $field) {
            if (array_key_exists($field, $validated) && $validated[$field] !== null) {
                $data[$field] = $validated[$field];
            }
        }

        $oldPicture = null;

        if ($request->hasFile('profile_picture')) {
            $newPath = $this->storeProfilePicture(
                $request->file('profile_picture')
            );

            $oldPicture = $user->profile_picture;
            $data['profile_picture'] = $newPath;
        }

        try {
            $user->update($data);
        } catch (\Throwable $e) {
            if (isset($newPath)) {
                $this->deleteProfilePicture($newPath);
            }

            throw $e;
        }

        if ($oldPicture) {
            $this->deleteProfilePicture($oldPicture);
        }

        return response()->json([
            'message' => 'Profile updated successfully',
            'user' => $this->formatUser($user->fresh()),
        ]);
    }

    /**
     * تغيير كلمة المرور.
     */
    public function changePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required|string',
            'new_password' => 'required|string|min:6|confirmed',
        ]);

        $user = $request->user();

        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json([
                'message' => 'Current password is incorrect',
            ], 400);
        }

        $user->update([
            'password' => $request->new_password,
        ]);

        return response()->json([
            'message' => 'Password changed successfully',
        ]);
    }

    /**
     * إنشاء مستخدم بواسطة Admin أو Director.
     */
    public function createUserByAdmin(Request $request)
    {
        $this->ensurePermission($request, 'users.create');

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:6',
            'role' => ['required', Rule::in($this->availableRoles())],
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $actor = $request->user();

        $this->ensureAssignableRole($actor, $validated['role']);

        $path = null;

        if ($request->hasFile('profile_picture')) {
            $path = $this->storeProfilePicture(
                $request->file('profile_picture')
            );
        }

        try {
            $user = DB::transaction(function () use ($validated, $path) {
                $user = User::create([
                    'name' => $validated['name'],
                    'email' => $validated['email'],
                    'password' => $validated['password'],
                    'profile_picture' => $path,
                ]);

                $user->assignRole($validated['role']);

                return $user;
            });
        } catch (\Throwable $e) {
            $this->deleteProfilePicture($path);
            throw $e;
        }

        return response()->json([
            'message' => 'تم إنشاء المستخدم بنجاح',
            'user' => $this->formatUser($user),
        ], 201);
    }

    /**
     * تسجيل الدخول بالبريد وكلمة المرور أو الهاتف و OTP.
     * الريسبونس بيرجّع role + permissions.
     */
    public function login(Request $request)
    {
        // Email + Password
        if ($request->filled('email')) {
            $request->validate([
                'email' => 'required|email',
                'password' => 'required|string',
            ]);

            $user = User::where('email', $request->email)->first();

            if (!$user || !$user->password || !Hash::check($request->password, $user->password)) {
                return response()->json([
                    'message' => 'بيانات غير صحيحة',
                ], 401);
            }

            $token = $user->createToken('api-token')->plainTextToken;

            // تأكد إن العلاقات محمّلة قبل الـ formatUser
            $user->load('roles.permissions', 'permissions');

            return response()->json([
                'message' => 'تم تسجيل الدخول بنجاح',
                'token' => $token,
                'user' => $this->formatUser($user),
            ]);
        }

        // Phone + OTP
        if ($request->filled('phone')) {
            $request->validate([
                'phone' => 'required|string|exists:users,phone',
            ]);

            $user = User::where('phone', $request->phone)->first();

            $otp = (string) random_int(100000, 999999);

            $user->update([
                'otp' => $otp,
                'otp_expires_at' => now()->addMinutes(5),
            ]);

            $msg = " *رمز تسجيل الدخول - شركة الأهرام*\n\n"
                . "رمز التحقق:\n *{$otp}*\n\n"
                . "صالح لمدة 5 دقائق\nلا تشارك الرمز";

            $this->dispatchWhatsApp($user->phone, $msg);

            return response()->json([
                'message' => 'تم إرسال كود التحقق',
            ]);
        }

        return response()->json([
            'message' => 'البيانات غير مكتملة',
        ], 422);
    }

    /**
     * التحقق من OTP وتسجيل الدخول.
     * الريسبونس بيرجّع role + permissions.
     */
    public function verifyOtp(Request $request)
    {
        $request->validate([
            'phone' => 'required|string|exists:users,phone',
            'otp' => 'required|string',
        ]);

        $user = User::where('phone', $request->phone)->first();

        $isExpired = !$user->otp_expires_at
            || now()->greaterThan($user->otp_expires_at);

        if (
            !$user->otp
            || (string) $user->otp !== (string) $request->otp
            || $isExpired
        ) {
            return response()->json([
                'message' => 'كود التحقق غير صحيح أو منتهي',
            ], 401);
        }

        $user->update([
            'otp' => null,
            'otp_expires_at' => null,
        ]);

        $token = $user->createToken('api-token')->plainTextToken;

        // تأكد إن العلاقات محمّلة
        $user->load('roles.permissions', 'permissions');

        return response()->json([
            'message' => 'تم تسجيل الدخول بنجاح',
            'token' => $token,
            'user' => $this->formatUser($user->fresh()),
        ]);
    }

    /**
     * تسجيل الخروج.
     */
    public function logout(Request $request)
    {
        $token = $request->user()->currentAccessToken();

        if ($token) {
            $token->delete();
        }

        return response()->json([
            'message' => 'Logged out successfully',
        ]);
    }

    /**
     * تحديث بيانات مستخدم.
     */
    public function updateUserByAdmin(Request $request, $id)
    {
        $this->ensurePermission($request, 'users.update');

        $actor = $request->user();

        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'message' => 'المستخدم غير موجود',
            ], 404);
        }

        $validated = $request->validate([
            'name' => 'nullable|string|max:255',
            'email' => [
                'nullable',
                'email',
                Rule::unique('users', 'email')->ignore($user->id),
            ],
            'role' => [
                'nullable',
                Rule::in($this->availableRoles()),
            ],
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'accepts_emails' => 'nullable|boolean',
        ]);

        // التحقق من الدور قبل تنفيذ أي تعديل.
        if (
            array_key_exists('role', $validated)
            && $validated['role'] !== null
        ) {
            $newRole = $validated['role'];
            $currentRole = $user->getRoleNames()->first();

            if ($newRole !== $currentRole) {
                if ($user->hasRole('admin', 'web') && $actor->hasRole('director', 'web')) {
                    abort(403, 'لا يمكنك تغيير دور حساب Admin');
                }

                if ($user->id === $actor->id) {
                    abort(403, 'لا يمكنك تغيير دور حسابك بنفسك');
                }

                $this->ensureAssignableRole($actor, $newRole);

                if (
                    $user->hasRole('admin', 'web')
                    && $newRole !== 'admin'
                    && Role::where('name', 'admin')->where('guard_name', 'web')->count() > 0
                ) {
                    $adminCount = User::role('admin', 'web')->count();

                    if ($adminCount <= 1) {
                        abort(403, 'لا يمكن إزالة دور آخر Admin في النظام');
                    }
                }
            }
        }

        $data = [];

        foreach (['name', 'email', 'accepts_emails'] as $field) {
            if (array_key_exists($field, $validated)) {
                $data[$field] = $validated[$field];
            }
        }

        $oldPicture = null;
        $newPath = null;

        if ($request->hasFile('profile_picture')) {
            $newPath = $this->storeProfilePicture(
                $request->file('profile_picture')
            );

            $oldPicture = $user->profile_picture;
            $data['profile_picture'] = $newPath;
        }

        try {
            DB::transaction(function () use ($user, $data, $validated) {
                if (!empty($data)) {
                    $user->update($data);
                }

                if (
                    array_key_exists('role', $validated)
                    && $validated['role'] !== null
                    && $validated['role'] !== $user->getRoleNames()->first()
                ) {
                    $user->syncRoles([$validated['role']]);
                }
            });
        } catch (\Throwable $e) {
            if ($newPath) {
                $this->deleteProfilePicture($newPath);
            }

            throw $e;
        }

        if ($oldPicture) {
            $this->deleteProfilePicture($oldPicture);
        }

        return response()->json([
            'message' => 'تم تحديث بيانات المستخدم بنجاح',
            'user' => $this->formatUser($user->fresh()),
        ]);
    }

    /**
     * حذف مستخدم.
     */
    public function deleteUserByAdmin(Request $request, $id)
    {
        $this->ensurePermission($request, 'users.delete');

        $actor = $request->user();

        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'message' => 'المستخدم غير موجود',
            ], 404);
        }

        if ($user->id === $actor->id) {
            return response()->json([
                'message' => 'لا يمكنك حذف حسابك الحالي',
            ], 403);
        }

        if ($user->hasRole('admin', 'web')) {
            if ($actor->hasRole('director', 'web')) {
                return response()->json([
                    'message' => 'لا يمكنك حذف حساب Admin',
                ], 403);
            }

            if (User::role('admin', 'web')->count() <= 1) {
                return response()->json([
                    'message' => 'لا يمكن حذف آخر Admin في النظام',
                ], 403);
            }
        }

        $picture = $user->profile_picture;

        $user->delete();

        $this->deleteProfilePicture($picture);

        return response()->json([
            'message' => 'تم حذف المستخدم بنجاح',
        ]);
    }

    /**
     * عرض جميع المستخدمين (مع role + permissions لكل مستخدم).
     */
    public function getAllUsers(Request $request)
    {
        $this->ensurePermission($request, 'users.view');

        // eager load عشان نمنع N+1 على roles.permissions و permissions
        $users = User::with(['roles.permissions', 'permissions'])
            ->orderByDesc('id')
            ->get()
            ->map(function (User $user) {
                return $this->formatUser($user);
            });

        return response()->json([
            'users' => $users,
        ]);
    }
}