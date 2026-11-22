<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Banner;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Symfony\Component\HttpKernel\Exception\HttpException;

class BannerController extends Controller
{
    protected function checkAdmin()
    {
        $user = Auth::user();

        if (!$user) {
            abort(403, 'غير مصرح لك: يجب تسجيل الدخول');
        }

        $allowedRoles = ['admin', 'director', 'employee'];

        if (!in_array($user->role, $allowedRoles)) {
            abort(403, 'غير مصرح لك: يجب أن تكون أدمن أو مدير أو موظف');
        }
    }

    protected function deletePublicFile(?string $path): void
    {
        if ($path) {
            $fullPath = public_path($path);
            if (file_exists($fullPath)) {
                @unlink($fullPath);
            }
        }
    }

  public function videos()
{
    $banners = Cache::remember('banners_videos', 600, function () {
        return Banner::videos()
            ->with(['category', 'product'])
            ->orderByDesc('id')
            ->get();
    });

    return response()->json($banners);
}
    protected function moveToPublic($file, string $folder): string
    {
        $filename = uniqid() . '.' . $file->getClientOriginalExtension();
        $file->move(public_path($folder), $filename);

        return $folder . '/' . $filename;
    }

    public function index()
    {
        $banners = Cache::remember('banners_all', 600, function () {
            return Banner::with(['category', 'product'])->get();
        });

        return response()->json($banners);
    }

    public function show($id)
    {
        $banner = Cache::remember("banner_{$id}", 600, function () use ($id) {
            return Banner::with(['category', 'product'])->findOrFail($id);
        });

        return response()->json($banner);
    }

    public function store(Request $request)
    {
        try {
            $this->checkAdmin();

            $mediaType = $request->input('media_type', 'image');

            $rules = [
                'media_type' => 'nullable|in:image,video',
                'title' => 'nullable|string|max:255',
                'description' => 'nullable|string',
                'title_en' => 'nullable|string|max:255',
                'description_en' => 'nullable|string',
                'category_id' => 'nullable|integer|exists:categories,id',
                'product_id' => 'nullable|integer|exists:products,id',
            ];

            if ($mediaType === 'video') {
                $rules['video'] = 'required|file|mimetypes:video/mp4,video/webm,video/quicktime|max:102400';
                $rules['img'] = 'nullable|image|max:20048'; // صورة غلاف اختيارية
            } else {
                $rules['img'] = 'required|image|max:20048';
                $rules['video'] = 'nullable|file|mimetypes:video/mp4,video/webm,video/quicktime|max:102400';
            }

            $validated = $request->validate($rules);
            $validated['media_type'] = $mediaType;

            if ($request->hasFile('img')) {
                $validated['img'] = $this->moveToPublic($request->file('img'), 'banners');
            }

            if ($mediaType === 'video' && $request->hasFile('video')) {
                $validated['video'] = $this->moveToPublic($request->file('video'), 'banners/videos');
            } else {
                unset($validated['video']);
            }

            $banner = Banner::create($validated);

            Cache::forget('banners_all');

            return response()->json([
                'message' => 'Banner created successfully',
                'banner' => $banner,
            ], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        } catch (HttpException $e) {
            return response()->json(['error' => $e->getMessage()], $e->getStatusCode());
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'حدث خطأ أثناء إنشاء البانر.',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $this->checkAdmin();

            $banner = Banner::findOrFail($id);

            $mediaType = $request->input('media_type', $banner->media_type ?? 'image');

            $validated = $request->validate([
                'media_type' => 'nullable|in:image,video',
                'title' => 'nullable|string|max:255',
                'description' => 'nullable|string',
                'title_en' => 'nullable|string|max:255',
                'description_en' => 'nullable|string',
                'category_id' => 'nullable|integer|exists:categories,id',
                'product_id' => 'nullable|integer|exists:products,id',
                'img' => 'nullable|image|max:20048',
                'video' => 'nullable|file|mimetypes:video/mp4,video/webm,video/quicktime|max:102400',
            ]);

            $validated['media_type'] = $mediaType;

            // لو بيحوّل لفيديو ومفيش فيديو قديم ولا جديد
            if ($mediaType === 'video' && !$request->hasFile('video') && !$banner->video) {
                return response()->json([
                    'errors' => ['video' => ['الفيديو مطلوب عند اختيار نوع فيديو']],
                ], 422);
            }

            // لو بيحوّل لصورة ومفيش صورة قديمة ولا جديدة
            if ($mediaType === 'image' && !$request->hasFile('img') && !$banner->img) {
                return response()->json([
                    'errors' => ['img' => ['الصورة مطلوبة عند اختيار نوع صورة']],
                ], 422);
            }

            if ($request->hasFile('img')) {
                $this->deletePublicFile($banner->img);
                $validated['img'] = $this->moveToPublic($request->file('img'), 'banners');
            } else {
                unset($validated['img']);
            }

            if ($request->hasFile('video')) {
                $this->deletePublicFile($banner->video);
                $validated['video'] = $this->moveToPublic($request->file('video'), 'banners/videos');
            } else {
                unset($validated['video']);
            }

            // لو رجّعه لصورة، امسح الفيديو القديم
            if ($mediaType === 'image' && $banner->video && !$request->hasFile('video')) {
                $this->deletePublicFile($banner->video);
                $validated['video'] = null;
            }

            $banner->update($validated);

            Cache::forget('banners_all');
            Cache::forget("banner_{$id}");

            return response()->json([
                'message' => 'Banner updated successfully',
                'banner' => $banner->fresh(),
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        } catch (HttpException $e) {
            return response()->json(['error' => $e->getMessage()], $e->getStatusCode());
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'حدث خطأ أثناء تحديث البانر.',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $this->checkAdmin();

            $banner = Banner::findOrFail($id);

            $this->deletePublicFile($banner->img);
            $this->deletePublicFile($banner->video);

            $banner->delete();

            Cache::forget('banners_all');
            Cache::forget("banner_{$id}");

            return response()->json(['message' => 'Banner deleted successfully']);
        } catch (HttpException $e) {
            return response()->json(['error' => $e->getMessage()], $e->getStatusCode());
        }
    }
}