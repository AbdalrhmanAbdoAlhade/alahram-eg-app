<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    // تسجيل مستخدم جديد
public function register(Request $request)
{
    $request->validate([
        'name' => 'required|string',
        'email' => 'required|email|unique:users,email',
        'password' => 'required|string|confirmed|min:6',
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
        'email' => $request->email,
        'password' => bcrypt($request->password),
        'profile_picture' => $path,
    ]);

    $token = $user->createToken('api-token')->plainTextToken;

    // أضف الرابط الكامل
    $user->profile_picture_url = $user->profile_picture ? url($user->profile_picture) : null;

    return response()->json([
        'message' => 'User registered successfully',
        'token' => $token,
        'user' => $user,
    ], 201);
}

    
public function updateProfile(Request $request)
{
    $request->validate([
        'name' => 'nullable|string',
        'email' => 'nullable|email|unique:users,email,' . $request->user()->id,
        'phone' => 'nullable|string',
        'address' => 'nullable|string',
        'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
    ]);

    $user = $request->user();

    $data = [
        'name' => $request->name ?? $user->name,
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

    // أضف الرابط الكامل
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


    // تسجيل دخول
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        $user = User::where('email', $request->email)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json(['token' => $token, 'user' => $user]);
    }

    // تسجيل خروج
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Logged out successfully']);
    }
}
