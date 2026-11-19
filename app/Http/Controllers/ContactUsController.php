<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ContactUs;
use Illuminate\Http\Request;

class ContactUsController extends Controller
{
    // عرض كل الرسائل - فلتر: ?status=read | unread
    public function index(Request $request)
    {
        $query = ContactUs::query()->latest();

        if ($request->status === 'read') {
            $query->read();
        } elseif ($request->status === 'unread') {
            $query->unread();
        }

        return response()->json([
            'unread_count' => ContactUs::unread()->count(),
            'contacts'     => $query->get(),
        ]);
    }

    // عرض رسالة محددة - وبتتعلّم مقروءة تلقائيًا
    public function show($id)
    {
        $contact = ContactUs::findOrFail($id);

        if (!$contact->is_read) {
            $contact->update([
                'is_read' => true,
                'read_at' => now(),
            ]);
        }

        return response()->json($contact);
    }

    // استقبال رسالة من المستخدم (مفتوح للجميع)
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'    => 'required|string|max:255',
            'email'   => 'nullable|email',
            'phone'   => 'nullable|string|max:20',
            'subject' => 'nullable|string|max:255',
            'message' => 'nullable|string',
        ]);

        $contact = ContactUs::create($validated);

        return response()->json([
            'message' => 'Contact info created successfully',
            'contact' => $contact,
        ], 201);
    }

    // تعديل رسالة
    public function update(Request $request, $id)
    {
        $contact = ContactUs::findOrFail($id);

        $validated = $request->validate([
            'name'    => 'sometimes|string|max:255',
            'email'   => 'nullable|email',
            'phone'   => 'nullable|string|max:20',
            'subject' => 'nullable|string|max:255',
            'message' => 'nullable|string',
        ]);

        $contact->update($validated);

        return response()->json([
            'message' => 'Contact info updated successfully',
            'contact' => $contact,
        ]);
    }

    // تعليم رسالة كمقروءة
    public function markAsRead($id)
    {
        $contact = ContactUs::findOrFail($id);

        $contact->update([
            'is_read' => true,
            'read_at' => now(),
        ]);

        return response()->json([
            'message' => 'Marked as read',
            'contact' => $contact,
        ]);
    }

    // تعليم رسالة كغير مقروءة
    public function markAsUnread($id)
    {
        $contact = ContactUs::findOrFail($id);

        $contact->update([
            'is_read' => false,
            'read_at' => null,
        ]);

        return response()->json([
            'message' => 'Marked as unread',
            'contact' => $contact,
        ]);
    }

    // تعليم كل الرسائل كمقروءة
    public function markAllAsRead()
    {
        $count = ContactUs::unread()->update([
            'is_read' => true,
            'read_at' => now(),
        ]);

        return response()->json([
            'message' => 'All messages marked as read',
            'updated' => $count,
        ]);
    }

    // حذف رسالة
    public function destroy($id)
    {
        $contact = ContactUs::findOrFail($id);
        $contact->delete();

        return response()->json(['message' => 'Contact info deleted successfully']);
    }
}