<?php

namespace App\Http\Controllers;

use App\Models\UserNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserNotificationController extends Controller
{
   public function __construct()
    {
        $this->middleware('auth:sanctum');
    }
    // GET /api/notifications
    public function index(Request $request)
    {
        $user = $request->user();

        $perPage = intval($request->get('per_page', 15));

        $query = UserNotification::where('user_id', $user->id)
            ->orderBy('created_at', 'desc');

        // فلتر: فقط غير المقروءة؟
        if ($request->has('only_unread') && $request->get('only_unread')) {
            $query->whereNull('read_at');
        }

        $notifications = $query->paginate($perPage);

        return response()->json($notifications);
    }

    // POST /api/notifications
    // ملاحظة: عادة الاشعارات ينشأها السيرفر (مثلاً admin أو system)، لكن نسمح به هنا كـ API لإنشاء اشعار
    public function store(Request $request)
    {
        $data = $request->all();

        $validator = Validator::make($data, [
            'user_id' => 'required|exists:users,id',
            'title' => 'nullable|string|max:255',
            'message' => 'nullable|string',
            'type' => 'nullable|string|max:100',
            'data' => 'nullable|array',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $notification = UserNotification::create([
            'user_id' => $data['user_id'],
            'title' => $data['title'] ?? null,
            'message' => $data['message'] ?? null,
            'type' => $data['type'] ?? null,
            'data' => $data['data'] ?? null,
        ]);

        return response()->json(['message' => 'Notification created', 'notification' => $notification], 201);
    }

    // GET /api/notifications/{id}
    public function show(Request $request, $id)
    {
        $user = $request->user();

        $notification = UserNotification::where('user_id', $user->id)->findOrFail($id);

        return response()->json($notification);
    }

    // PATCH /api/notifications/{id}
    // نستخدمها لتحديث الحقول أو تمييز كمقروء/غير
    public function update(Request $request, $id)
    {
        $user = $request->user();

        $notification = UserNotification::where('user_id', $user->id)->findOrFail($id);

        $validator = Validator::make($request->all(), [
            'title' => 'nullable|string|max:255',
            'message' => 'nullable|string',
            'type' => 'nullable|string|max:100',
            'data' => 'nullable|array',
            'mark_read' => 'nullable|boolean',
            'mark_unread' => 'nullable|boolean',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        if ($request->has('mark_read') && $request->boolean('mark_read')) {
            $notification->markAsRead();
        }

        if ($request->has('mark_unread') && $request->boolean('mark_unread')) {
            $notification->markAsUnread();
        }

        // تحديث البيانات العامة
        $notification->fill($request->only(['title', 'message', 'type', 'data']));
        $notification->save();

        return response()->json(['message' => 'Notification updated', 'notification' => $notification]);
    }

    // DELETE /api/notifications/{id}
    public function destroy(Request $request, $id)
    {
        $user = $request->user();

        $notification = UserNotification::where('user_id', $user->id)->findOrFail($id);
        $notification->delete();

        return response()->json(['message' => 'Notification deleted']);
    }

    // POST /api/notifications/{id}/mark-read
    public function markRead(Request $request, $id)
    {
        $user = $request->user();
        $notification = UserNotification::where('user_id', $user->id)->findOrFail($id);
        $notification->markAsRead();

        return response()->json(['message' => 'Marked as read', 'notification' => $notification]);
    }

    // POST /api/notifications/mark-all-read
    public function markAllRead(Request $request)
    {
        $user = $request->user();
        UserNotification::where('user_id', $user->id)->whereNull('read_at')->update(['read_at' => now()]);

        return response()->json(['message' => 'All notifications marked as read']);
    }

    // GET /api/notifications/unread-count
    public function unreadCount(Request $request)
    {
        $user = $request->user();
        $count = UserNotification::where('user_id', $user->id)->whereNull('read_at')->count();

        return response()->json(['unread' => $count]);
    }
    
    // GET /api/admin/notifications
public function adminIndex(Request $request)
{
    $user = $request->user();

    // تأكد أنه أدمن
    if ($user->role !== 'admin') {
        return response()->json(['message' => 'غير مصرح لك بالدخول.'], 403);
    }

    // جلب كل الإشعارات بترتيب زمني تنازلي
    $perPage = intval($request->get('per_page', 15));
    $notifications = \App\Models\UserNotification::orderBy('created_at', 'desc')->paginate($perPage);

    return response()->json($notifications);
}

}
