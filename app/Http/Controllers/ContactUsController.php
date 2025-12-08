<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ContactUs;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ContactUsController extends Controller
{
    protected function checkAdmin()
    {
        $user = Auth::user();

        if (!$user || $user->role !== 'admin') {
            abort(403, 'Unauthorized: Admins only');
        }
    }

    // عرض كل الرسائل (للمشرف فقط)
    public function index()
    {
       

        $contacts = ContactUs::all();
        return response()->json($contacts);
    }

    // عرض رسالة محددة (للمشرف فقط)
    public function show($id)
    {
        $this->checkAdmin();

        $contact = ContactUs::findOrFail($id);
        return response()->json($contact);
    }

    // استقبال رسالة من المستخدم (مفتوح للجميع)
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'nullable|email',
            'phone' => 'nullable|string|max:20',
            'subject' => 'nullable|string|max:255',
            'message' => 'nullable|string',
        ]);

        $contact = ContactUs::create($validated);

        return response()->json([
            'message' => 'Contact info created successfully',
            'contact' => $contact,
        ], 201);
    }

    // تعديل رسالة (للمشرف فقط)
    public function update(Request $request, $id)
    {
      

        $contact = ContactUs::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'email' => 'nullable|email',
            'phone' => 'nullable|string|max:20',
            'subject' => 'nullable|string|max:255',
            'message' => 'nullable|string',
        ]);

        $contact->update($validated);

        return response()->json([
            'message' => 'Contact info updated successfully',
            'contact' => $contact,
        ]);
    }

    // حذف رسالة (للمشرف فقط)
    public function destroy($id)
    {
        $this->checkAdmin();

        $contact = ContactUs::findOrFail($id);
        $contact->delete();

        return response()->json(['message' => 'Contact info deleted successfully']);
    }
}
