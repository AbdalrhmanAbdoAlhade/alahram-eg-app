<?php

return [
    'enabled' => env('DB_MAINTENANCE_ENABLED', false),
    'key' => env('DB_MAINTENANCE_KEY'),
    'mysqldump_path' => env('DB_MYSQLDUMP_PATH', 'mysqldump'),
    'mysql_path' => env('DB_MYSQL_PATH', 'mysql'),
    'backup_dir' => storage_path('app/db-backups'),
];