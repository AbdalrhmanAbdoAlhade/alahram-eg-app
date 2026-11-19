<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\MorphToMany;
use Spatie\Permission\Models\Permission as SpatiePermission;

class Permission extends SpatiePermission
{
    /**
     * علاقة المستخدمين اللي عندهم الصلاحية دي مباشرة (مش عن طريق role).
     */
    public function users(): MorphToMany
    {
        return $this->morphedByMany(
            \App\Models\User::class,
            'model',
            config('permission.table_names.model_has_permissions'),
            'permission_id',
            config('permission.column_names.model_morph_key')
        );
    }

    /**
     * علاقة الأدوار اللي عندها الصلاحية دي.
     */
    public function roles(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {
        return $this->belongsToMany(
            \App\Models\Role::class,
            config('permission.table_names.role_has_permissions'),
            'permission_id',
            'role_id'
        );
    }
}