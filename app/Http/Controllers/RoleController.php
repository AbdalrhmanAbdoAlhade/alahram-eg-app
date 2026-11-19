<?php

namespace App\Http\Controllers;

use App\Models\Role;              // ← بدل Spatie\Permission\Models\Role
use Illuminate\Http\Request;

class RoleController extends Controller
{
    public function index()
    {
        $roles = Role::where('guard_name', 'web')
            ->withCount(['permissions', 'users'])   // ← دلوقتي هتشتغل
            ->orderBy('id')
            ->get(['id', 'name', 'guard_name', 'created_at']);

        return response()->json([
            'roles' => $roles,
        ]);
    }

    public function show($id)
    {
        $role = Role::where('guard_name', 'web')
            ->with(['permissions:id,name', 'users:id,name,email,phone'])
            ->findOrFail($id);

        return response()->json([
            'role' => [
                'id'          => $role->id,
                'name'        => $role->name,
                'guard_name'  => $role->guard_name,
                'permissions' => $role->permissions->pluck('name'),
                'users_count' => $role->users->count(),
                'users'       => $role->users,
            ],
        ]);
    }
}