<?php

namespace App\Http\Controllers;

use App\Models\ReturnsPolicy;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ReturnsPolicyController extends Controller
{
    protected function checkAdmin()
    {
        $user = Auth::user();

        if (!$user || $user->role !== 'admin') {
            abort(403, 'Unauthorized: Admins only');
        }
    }

    public function index()
    {
        $policies = ReturnsPolicy::all();
        return response()->json($policies);
    }

    public function show($id)
    {
        $policy = ReturnsPolicy::findOrFail($id);
        return response()->json($policy);
    }

    public function store(Request $request)
    {
        try {
            $this->checkAdmin();

            $validated = $request->validate([
                'description' => 'required|string|max:2550000',
                     'description_en' => 'nullable|string|max:2550000',
            ]);

            $policy = ReturnsPolicy::create($validated);

            return response()->json([
                'message' => 'Returns policy created successfully',
                'policy' => $policy,
            ], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'حدث خطأ أثناء إنشاء سياسة الاسترجاع.', 'message' => $e->getMessage()], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $this->checkAdmin();

            $policy = ReturnsPolicy::findOrFail($id);

            $validated = $request->validate([
                'description' => 'sometimes|string|max:2550000',
                     'description_en' => 'nullable|string|max:2550000',
            ]);

            $policy->update($validated);

            return response()->json([
                'message' => 'Returns policy updated successfully',
                'policy' => $policy,
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'حدث خطأ أثناء تحديث سياسة الاسترجاع.', 'message' => $e->getMessage()], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $this->checkAdmin();

            $policy = ReturnsPolicy::findOrFail($id);
            $policy->delete();

            return response()->json(['message' => 'Returns policy deleted successfully']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'حدث خطأ أثناء حذف سياسة الاسترجاع.', 'message' => $e->getMessage()], 500);
        }
    }
}
