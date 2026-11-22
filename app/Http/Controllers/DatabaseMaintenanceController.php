<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Schema;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Symfony\Component\Process\Process;

class DatabaseMaintenanceController extends Controller
{
    protected function guard(Request $request, ?string $confirmPrefix = null): void
    {
        if (!config('database_maintenance.enabled')) {
            abort(404);
        }

        $user = Auth::user();

        if (!$user || $user->role !== 'admin') {
            abort(403, 'غير مصرح لك: للأدمن فقط');
        }

        $key = (string) config('database_maintenance.key');
        $sent = (string) $request->header('X-Maintenance-Key', '');

        if ($key === '' || !hash_equals($key, $sent)) {
            abort(403, 'مفتاح الصيانة غير صحيح');
        }

        if ($confirmPrefix !== null) {
            $expected = $confirmPrefix . ' ' . config('database.connections.mysql.database');

            if (trim((string) $request->input('confirm')) !== $expected) {
                abort(422, 'جملة التأكيد غير صحيحة. المطلوب بالظبط: ' . $expected);
            }
        }
    }

    protected function backupDir(): string
    {
        $dir = config('database_maintenance.backup_dir');

        if (!File::isDirectory($dir)) {
            File::makeDirectory($dir, 0750, true);
        }

        return $dir;
    }

    protected function dbArgs(): array
    {
        $c = config('database.connections.mysql');

        return [
            '-h', (string) $c['host'],
            '-P', (string) $c['port'],
            '-u', (string) $c['username'],
        ];
    }

    protected function dbEnv(): array
    {
        return ['MYSQL_PWD' => (string) config('database.connections.mysql.password')];
    }

    protected function makeBackup(string $label = 'manual'): string
    {
        $dbName = config('database.connections.mysql.database');
        $path = $this->backupDir() . '/db_' . now()->format('Y-m-d_His') . '_' . $label . '.sql';

        $command = array_merge(
            [config('database_maintenance.mysqldump_path')],
            $this->dbArgs(),
            [
                '--single-transaction',
                '--routines',
                '--triggers',
                '--no-tablespaces',
                '--result-file=' . $path,
                $dbName,
            ]
        );

        $process = new Process($command, null, $this->dbEnv());
        $process->setTimeout(1800);
        $process->run();

        if (!$process->isSuccessful() || !File::exists($path) || File::size($path) === 0) {
            Log::error('DB backup failed', ['error' => $process->getErrorOutput()]);
            @unlink($path);
            throw new \RuntimeException('فشل إنشاء الباك أب');
        }

        return $path;
    }

    protected function listTables(): array
    {
        return collect(DB::select('SHOW TABLES'))
            ->map(fn ($row) => array_values((array) $row)[0])
            ->values()
            ->all();
    }

    protected function respondError(\Throwable $e, string $fallback)
    {
        if ($e instanceof HttpException) {
            return response()->json(['error' => $e->getMessage()], $e->getStatusCode());
        }

        if ($e instanceof \Illuminate\Validation\ValidationException) {
            return response()->json(['errors' => $e->errors()], 422);
        }

        Log::error($fallback, ['message' => $e->getMessage()]);

        return response()->json(['error' => $fallback, 'message' => $e->getMessage()], 500);
    }

    // GET /admin/database/backups
    public function index(Request $request)
    {
        try {
            $this->guard($request);

            $files = collect(File::files($this->backupDir()))
                ->filter(fn ($f) => $f->getExtension() === 'sql')
                ->map(fn ($f) => [
                    'name' => $f->getFilename(),
                    'size_mb' => round($f->getSize() / 1048576, 2),
                    'created_at' => date('Y-m-d H:i:s', $f->getMTime()),
                ])
                ->sortByDesc('created_at')
                ->values();

            return response()->json($files);
        } catch (\Throwable $e) {
            return $this->respondError($e, 'حدث خطأ أثناء عرض الباك أب');
        }
    }

    // POST /admin/database/backup
    public function backup(Request $request)
    {
        try {
            $this->guard($request);

            $path = $this->makeBackup('manual');

            Log::warning('DB backup created', ['file' => basename($path), 'user_id' => Auth::id()]);

            return response()->json([
                'message' => 'Backup created successfully',
                'file' => basename($path),
                'size_mb' => round(File::size($path) / 1048576, 2),
            ], 201);
        } catch (\Throwable $e) {
            return $this->respondError($e, 'حدث خطأ أثناء إنشاء الباك أب');
        }
    }

    // GET /admin/database/download/{file}
    public function download(Request $request, $file)
    {
        try {
            $this->guard($request);

            $file = basename($file);
            $path = $this->backupDir() . '/' . $file;

            if (!preg_match('/^[A-Za-z0-9_\-\.]+\.sql$/', $file) || !File::exists($path)) {
                abort(404, 'الملف غير موجود');
            }

            return response()->download($path);
        } catch (\Throwable $e) {
            return $this->respondError($e, 'حدث خطأ أثناء تحميل الباك أب');
        }
    }

    // POST /admin/database/wipe
    // body: confirm="WIPE <db_name>" , tables[] (اختياري) , run_migrations (اختياري)
    public function wipe(Request $request)
    {
        try {
            $this->guard($request, 'WIPE');

            $validated = $request->validate([
                'tables' => 'nullable|array',
                'tables.*' => 'string',
                'run_migrations' => 'nullable|boolean',
            ]);

            // باك أب أوتوماتيك قبل أي مسح
            $backupPath = $this->makeBackup('before_wipe');

            $existing = $this->listTables();

            if (!empty($validated['tables'])) {
                $unknown = array_diff($validated['tables'], $existing);

                if (!empty($unknown)) {
                    return response()->json([
                        'errors' => ['tables' => ['جداول غير موجودة: ' . implode(', ', $unknown)]],
                    ], 422);
                }

                Schema::disableForeignKeyConstraints();

                try {
                    foreach ($validated['tables'] as $table) {
                        DB::table($table)->truncate();
                    }
                } finally {
                    Schema::enableForeignKeyConstraints();
                }

                $mode = 'truncate';
            } else {
                Artisan::call('db:wipe', ['--force' => true]);

                if ($request->boolean('run_migrations')) {
                    Artisan::call('migrate', ['--force' => true]);
                }

                $mode = 'full_wipe';
            }

            Log::alert('DB wipe executed', [
                'mode' => $mode,
                'tables' => $validated['tables'] ?? 'ALL',
                'backup' => basename($backupPath),
                'user_id' => Auth::id(),
                'ip' => $request->ip(),
            ]);

            return response()->json([
                'message' => 'Database wiped successfully',
                'mode' => $mode,
                'backup_file' => basename($backupPath),
            ]);
        } catch (\Throwable $e) {
            return $this->respondError($e, 'حدث خطأ أثناء مسح الداتا بيز');
        }
    }

    // POST /admin/database/restore  (multipart)
    // body: confirm="RESTORE <db_name>" + (file=ملف sql) أو (backup_file=اسم باك أب موجود)
    public function restore(Request $request)
    {
        $tempUpload = null;

        try {
            $this->guard($request, 'RESTORE');

            $request->validate([
                'file' => 'nullable|file|max:512000',
                'backup_file' => 'nullable|string',
            ]);

            if ($request->hasFile('file')) {
                $upload = $request->file('file');

                if (strtolower($upload->getClientOriginalExtension()) !== 'sql') {
                    return response()->json(['errors' => ['file' => ['لازم الملف يكون .sql']]], 422);
                }

                $tempUpload = $this->backupDir() . '/upload_' . uniqid() . '.sql';
                $upload->move($this->backupDir(), basename($tempUpload));
                $sourcePath = $tempUpload;
            } elseif ($request->filled('backup_file')) {
                $name = basename($request->input('backup_file'));
                $sourcePath = $this->backupDir() . '/' . $name;

                if (!preg_match('/^[A-Za-z0-9_\-\.]+\.sql$/', $name) || !File::exists($sourcePath)) {
                    return response()->json(['errors' => ['backup_file' => ['الباك أب غير موجود']]], 422);
                }
            } else {
                return response()->json(['errors' => ['file' => ['ارفع ملف sql أو حدد backup_file']]], 422);
            }

            // باك أب أمان للحالة الحالية قبل الاسترجاع
            $safetyBackup = $this->makeBackup('before_restore');

            $dbName = config('database.connections.mysql.database');

            $command = array_merge(
                [config('database_maintenance.mysql_path')],
                $this->dbArgs(),
                [$dbName]
            );

            $handle = fopen($sourcePath, 'r');

            $process = new Process($command, null, $this->dbEnv());
            $process->setTimeout(3600);
            $process->setInput($handle);
            $process->run();

            fclose($handle);

            if (!$process->isSuccessful()) {
                Log::error('DB restore failed', ['error' => $process->getErrorOutput()]);

                return response()->json([
                    'error' => 'فشل الاسترجاع',
                    'message' => $process->getErrorOutput(),
                    'safety_backup' => basename($safetyBackup),
                ], 500);
            }

            try {
                Artisan::call('cache:clear');
            } catch (\Throwable $e) {
                // الكاش ممكن يكون على الداتا بيز نفسها، مش مشكلة
            }

            Log::alert('DB restore executed', [
                'source' => basename($sourcePath),
                'safety_backup' => basename($safetyBackup),
                'user_id' => Auth::id(),
                'ip' => $request->ip(),
            ]);

            return response()->json([
                'message' => 'Database restored successfully',
                'safety_backup' => basename($safetyBackup),
            ]);
        } catch (\Throwable $e) {
            return $this->respondError($e, 'حدث خطأ أثناء استرجاع الداتا بيز');
        } finally {
            if ($tempUpload && File::exists($tempUpload)) {
                @unlink($tempUpload);
            }
        }
    }
}