<?php

namespace App\Http\Controllers;

use App\Models\Testimonial;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;

class TestimonialController extends Controller
{
    private function authorizeAdmin()
    {
        $user = Auth::user();
        if (!$user || $user->role !== 'admin') {
            abort(403, 'Unauthorized: Admins only');
        }
    }

    public function index()
    {
        $testimonials = Testimonial::all();

        $testimonials->transform(function ($item) {
            if ($item->img) {
                $item->img = url($item->img); // رابط URL كامل
            }
            return $item;
        });

        return response()->json($testimonials);
    }

    public function show($id)
    {
        $testimonial = Testimonial::findOrFail($id);

        if ($testimonial->img) {
            $testimonial->img = url($testimonial->img);
        }

        return response()->json($testimonial);
    }

    public function store(Request $request)
    {
        $this->authorizeAdmin();

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'review' => 'required|string',
            'img' => 'nullable|image|max:2048',
            'rating' => 'nullable|numeric|min:0|max:5',
        ]);

     if ($request->hasFile('img')) {
    $file = $request->file('img');
    $originalName = preg_replace('/\s+/', '-', $file->getClientOriginalName()); // إزالة الفراغات
    $filename = time() . '_' . $originalName;
    $file->move(public_path('testimonials'), $filename);
    $validated['img'] = 'testimonials/' . $filename;
}


        $testimonial = Testimonial::create($validated);

        if ($testimonial->img) {
            $testimonial->img = url($testimonial->img);
        }

        return response()->json([
            'message' => 'Testimonial created successfully',
            'testimonial' => $testimonial,
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $this->authorizeAdmin();

        $testimonial = Testimonial::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'review' => 'sometimes|string',
            'img' => 'nullable|image|max:2048',
            'rating' => 'nullable|numeric|min:0|max:5',
        ]);

    if ($request->hasFile('img')) {
        // حذف الصورة القديمة
        if ($testimonial->img && file_exists(public_path($testimonial->img))) {
            unlink(public_path($testimonial->img));
        }

        $file = $request->file('img');
        $originalName = preg_replace('/\s+/', '-', $file->getClientOriginalName()); // إزالة الفراغات
        $filename = time() . '_' . $originalName;
        $file->move(public_path('testimonials'), $filename);
        $validated['img'] = 'testimonials/' . $filename;
    }
        $testimonial->update($validated);

        if ($testimonial->img) {
            $testimonial->img = url($testimonial->img);
        }

        return response()->json([
            'message' => 'Testimonial updated successfully',
            'testimonial' => $testimonial,
        ]);
    }

    public function destroy($id)
    {
        $this->authorizeAdmin();

        $testimonial = Testimonial::findOrFail($id);

        if ($testimonial->img && File::exists(public_path($testimonial->img))) {
            File::delete(public_path($testimonial->img));
        }

        $testimonial->delete();

        return response()->json(['message' => 'Testimonial deleted successfully']);
    }
}
