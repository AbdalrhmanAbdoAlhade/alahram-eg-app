<?php

namespace App\Http\Controllers;

use App\Models\Permission;        // ← بدل Spatie\Permission\Models\Permission
use App\Models\Role;              // ← بدل Spatie\Permission\Models\Role
use Illuminate\Http\Request;

class PermissionController extends Controller
{
    public function index(Request $request)
    {
        $permissions = Permission::where('guard_name', 'web')
            ->orderBy('name')
            ->get(['id', 'name', 'guard_name', 'created_at']);

        if ($request->boolean('grouped')) {
            $grouped = $permissions->groupBy(function ($perm) {
                return explode('.', $perm->name)[0];
            })->map(function ($items, $group) {
                return [
                    'group'       => $group,
                    'permissions' => $items->values(),
                ];
            })->values();

            return response()->json([
                'total'   => $permissions->count(),
                'grouped' => $grouped,
            ]);
        }

        return response()->json([
            'total'       => $permissions->count(),
            'permissions' => $permissions,
        ]);
    }

    public function byRole($id)
    {
        $role = Role::with('permissions:id,name')
            ->where('guard_name', 'web')
            ->findOrFail($id);

        return response()->json([
            'role' => [
                'id'   => $role->id,
                'name' => $role->name,
            ],
            'permissions' => $role->permissions->pluck('name'),
            'total'       => $role->permissions->count(),
        ]);
    }

    public function syncRolePermissions(Request $request, $id)
    {
        $request->validate([
            'permissions'   => 'required|array',
            'permissions.*' => 'string|exists:permissions,name',
        ]);

        $role = Role::where('guard_name', 'web')->findOrFail($id);

        if ($role->name === 'admin' && !$request->user()->hasRole('admin')) {
            abort(403, 'فقط Admin يمكنه تعديل صلاحيات Admin');
        }

        $role->syncPermissions($request->input('permissions'));

        app(\Spatie\Permission\PermissionRegistrar::class)->forgetCachedPermissions();

        return response()->json([
            'message' => 'تم تحديث صلاحيات الدور بنجاح',
            'role'    => $role->name,
            'total'   => $role->permissions()->count(),
        ]);
    }
}