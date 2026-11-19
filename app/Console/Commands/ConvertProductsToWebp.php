<?php

namespace App\Console\Commands;

use App\Models\Product;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Throwable;

class ConvertProductsToWebp extends Command
{
    protected $signature = 'products:convert-webp {--dry-run}';

    protected $description = 'Convert existing product images to WebP safely';

    public function handle(): int
    {
        if (!function_exists('imagewebp')) {
            $this->error('GD WebP is not supported.');
            return self::FAILURE;
        }

        $disk = Storage::disk('public');

        $converted = 0;
        $skipped = 0;
        $failed = 0;

        Product::chunkById(50, function ($products) use (
            $disk, &$converted, &$skipped, &$failed
        ) {
            foreach ($products as $product) {

                $updates = [];
                $oldFiles = [];
                $newFiles = [];

                $images = [
                    'img' => $product->img,
                    'images' => is_array($product->images)
                        ? $product->images
                        : [],
                ];

                try {
                    // Main image
                    if (!empty($images['img'])) {
                        $result = $this->convertImage(
                            $images['img'],
                            $disk
                        );

                        if ($result) {
                            $updates['img'] = $result;
                            $oldFiles[] = $images['img'];
                            $newFiles[] = $result;
                        }
                    }

                    // Additional images
                    $newAdditional = [];
                    $additionalChanged = false;

                    foreach ($images['images'] as $oldPath) {
                        if (empty($oldPath)) {
                            $newAdditional[] = $oldPath;
                            continue;
                        }

                        $result = $this->convertImage(
                            $oldPath,
                            $disk
                        );

                        if ($result) {
                            $newAdditional[] = $result;
                            $oldFiles[] = $oldPath;
                            $newFiles[] = $result;
                            $additionalChanged = true;
                        } else {
                            $newAdditional[] = $oldPath;
                        }
                    }

                    if ($additionalChanged) {
                        $updates['images'] = $newAdditional;
                    }

                    if (empty($updates)) {
                        $skipped++;
                        continue;
                    }

                    if ($this->option('dry-run')) {
                        foreach ($newFiles as $path) {
                            $disk->delete($path);
                        }

                        $this->line("DRY RUN: Product #{$product->id}");
                        $converted++;
                        continue;
                    }

                    // Update DB first, then delete originals
                    DB::transaction(function () use ($product, $updates) {
                        $product->update($updates);
                    });

                    foreach ($oldFiles as $oldPath) {
                        $fullPath = public_path($oldPath);

                        if (is_file($fullPath)) {
                            @unlink($fullPath);
                        }
                    }

                    $converted++;

                    $this->info("Converted Product #{$product->id}");

                } catch (Throwable $e) {
                    // Preserve original files on failure
                    foreach ($newFiles as $path) {
                        $disk->delete($path);
                    }

                    $failed++;

                    $this->error(
                        "Product #{$product->id}: {$e->getMessage()}"
                    );
                }
            }
        });

        $this->newLine();

        $this->table(
            ['Result', 'Count'],
            [
                ['Converted', $converted],
                ['Skipped', $skipped],
                ['Failed', $failed],
            ]
        );

        return $failed > 0 ? self::FAILURE : self::SUCCESS;
    }

    private function convertImage($oldPath, $disk): ?string
    {
        $oldPath = ltrim($oldPath, '/');

        // Already converted
        if (strtolower(pathinfo($oldPath, PATHINFO_EXTENSION)) === 'webp') {
            return null;
        }

        $source = public_path($oldPath);

        if (!is_file($source)) {
            $this->warn("Missing image: {$oldPath}");
            return null;
        }

        $mime = mime_content_type($source);

        $src = match ($mime) {
            'image/jpeg' => @imagecreatefromjpeg($source),
            'image/png' => @imagecreatefrompng($source),
            'image/gif' => @imagecreatefromgif($source),
            'image/webp' => @imagecreatefromwebp($source),
            default => false,
        };

        if (!$src) {
            throw new \RuntimeException("Cannot read image: {$oldPath}");
        }

        $width = imagesx($src);
        $height = imagesy($src);

        $newWidth = min($width, 1200);
        $newHeight = (int) round($height * ($newWidth / $width));

        $dst = imagecreatetruecolor($newWidth, $newHeight);

        imagealphablending($dst, false);
        imagesavealpha($dst, true);

        $transparent = imagecolorallocatealpha($dst, 0, 0, 0, 127);
        imagefilledrectangle($dst, 0, 0, $newWidth, $newHeight, $transparent);

        imagecopyresampled(
            $dst,
            $src,
            0, 0, 0, 0,
            $newWidth,
            $newHeight,
            $width,
            $height
        );

        $newPath = 'products/' . Str::uuid() . '.webp';

        $fullDestination = $disk->path($newPath);

        if (!is_dir(dirname($fullDestination))) {
            mkdir(dirname($fullDestination), 0755, true);
        }

        $success = imagewebp($dst, $fullDestination, 80);

        imagedestroy($src);
        imagedestroy($dst);

        if (!$success || !is_file($fullDestination)) {
            throw new \RuntimeException("WebP conversion failed: {$oldPath}");
        }

        return $newPath;
    }
}
