<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ShippingInfo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ShippingInfoController extends Controller
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
        $infos = ShippingInfo::all();
        return response()->json($infos);
    }

    public function show($id)
    {
        $info = ShippingInfo::findOrFail($id);
        return response()->json($info);
    }

    public function store(Request $request)
    {
        $this->checkAdmin();

        $validated = $request->validate([
            'description' => 'required|string|max:2550000',
                 'description_en' => 'nullable|string|max:2550000',
        ]);

        $info = ShippingInfo::create($validated);

        return response()->json([
            'message' => 'Shipping info created successfully',
            'shipping_info' => $info,
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $this->checkAdmin();

        $info = ShippingInfo::findOrFail($id);

        $validated = $request->validate([
            'description' => 'sometimes|string|max:2550000',
                 'description_en' => 'nullable|string|max:2550000',
        ]);

        $info->update($validated);

        return response()->json([
            'message' => 'Shipping info updated successfully',
            'shipping_info' => $info,
        ]);
    }

    public function destroy($id)
    {
        $this->checkAdmin();

        $info = ShippingInfo::findOrFail($id);
        $info->delete();

        return response()->json(['message' => 'Shipping info deleted successfully']);
    }
}
