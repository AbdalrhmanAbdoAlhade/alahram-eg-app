
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use App\Models\User;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\PermissionRegistrar;

return new class extends Migration
{
    public function up(): void
    {
        app(PermissionRegistrar::class)->forgetCachedPermissions();

        DB::transaction(function () {

            $guard = 'web';

            $permissions = [
                'users.view',
                'users.create',
                'users.update',
                'users.delete',
                'roles.view',
                'roles.manage',
            ];

            foreach ($permissions as $permission) {
                Permission::findOrCreate($permission, $guard);
            }

            $roles = [
                'admin',
                'director',
                'employee',
                'user',
            ];

            foreach ($roles as $roleName) {
                Role::findOrCreate($roleName, $guard);
            }

            $admin = Role::findByName('admin', $guard);
            $director = Role::findByName('director', $guard);

            $admin->syncPermissions($permissions);

            $director->syncPermissions([
                'users.view',
                'users.create',
                'users.update',
                'users.delete',
                'roles.view',
            ]);

            $users = User::query()->orderBy('id')->get();

            foreach ($users as $user) {
                $legacyRole = $user->getRawOriginal('role');

                $roleName = $legacyRole ?: 'user';

                if (!in_array($roleName, $roles, true)) {
                    throw new RuntimeException(
                        "Unknown legacy role [{$roleName}] for user ID {$user->id}"
                    );
                }

                $user->syncRoles([$roleName]);
            }

        });

        app(PermissionRegistrar::class)->forgetCachedPermissions();
    }

    public function down(): void
    {
        // Intentionally do not delete roles or permissions.
        // They may have been modified or assigned after migration.
    }
};
