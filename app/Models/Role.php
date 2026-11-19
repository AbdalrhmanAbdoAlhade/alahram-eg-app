<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\MorphToMany;
use Spatie\Permission\Models\Role as SpatieRole;

class Role extends SpatieRole
{
    /**
     * علاقة المستخدمين اللي عندهم الدور ده.
     * بتتعامل مع جدول model_has_roles الـ polymorphic.
     */
    public function users(): MorphToMany
    {
        return $this->morphedByMany(
            \App\Models\User::class,
            'model',
            config('permission.table_names.model_has_roles'),
            'role_id',
            config('permission.column_names.model_morph_key')
        );
    }
}