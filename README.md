<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&amp;color=0:0f2027,50:203a43,100:2c5364&amp;height=200&amp;section=header&amp;text=Store%20API&amp;fontSize=52&amp;fontColor=ffffff&amp;fontAlignY=38&amp;desc=E-Commerce%20%C2%B7%20Roles%20and%20Permissions%20%C2%B7%20Contact%20Inbox&amp;descSize=20&amp;descAlignY=58&amp;animation=fadeIn" width="100%" alt="header" />

<a href="https://git.io/typing-svg">
<img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&amp;weight=600&amp;size=20&amp;duration=3000&amp;pause=900&amp;color=38BDF8&amp;center=true&amp;vCenter=true&amp;width=720&amp;lines=Laravel+REST+API+%C2%B7+E-Commerce+Backend;Products+%C2%B7+Orders+%C2%B7+Manual+Payment+Review;Granular+Permissions+%C2%B7+Roles+%C2%B7+Sanctum+Auth;Contact+Inbox+%C2%B7+Read%2FUnread+%C2%B7+WhatsApp+Messaging" alt="Typing SVG" />
</a>

<br/>

[![Laravel](https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white)](https://laravel.com)
[![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://php.net)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://mysql.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-0ea5e9?style=for-the-badge)](LICENSE)

</div>

---

## 📖 نظرة عامة

**Store API** هو REST API لمتجر إلكتروني مبني بـ Laravel. بيوفر إدارة الكتالوج
(منتجات، أقسام، ماركات، أنواع منتجات، خدمات)، ودورة طلبات مع **مراجعة يدوية
للمدفوعات** (العميل يرفع إيصال والإدارة توافق أو ترفض)، ونظام **صلاحيات دقيق على
مستوى كل Route**، وإشعارات، ورسائل واتساب، وصندوق **تواصل معنا** بخاصية
مقروء / غير مقروء.

- واجهة API فقط (JSON) — بدون واجهات عرض.
- المصادقة بـ **Laravel Sanctum** (Bearer tokens).
- كل مسار إداري محمي بـ `permission:<name>` middleware.
- المسارات العامة المهمة عليها Rate Limiting.

---

## ✨ المميزات

| الميزة | الوصف |
| :--- | :--- |
| 🔐 مصادقة | تسجيل، دخول، تحقق OTP، تعديل الملف الشخصي، تغيير كلمة المرور |
| 👥 أدوار وصلاحيات | صلاحيات منفصلة لكل مورد (`*.create` / `*.update` / `*.delete`) مع مزامنة الصلاحيات للأدوار |
| 📦 كتالوج | منتجات، أقسام، ماركات، أنواع منتجات، خدمات، مناطق توصيل |
| 🏷️ تسويق | بانرات، بانرات عروض (مع إنشاء عرض لكل المنتجات)، كوبونات خصم، آراء العملاء |
| 🧾 طلبات | إنشاء طلب بدون تسجيل دخول، طلباتي، تحديث الحالة من الإدارة |
| 💳 مدفوعات | رفع إيصال الدفع + مراجعة الإدارة (موافقة / رفض) |
| 🔔 إشعارات | إشعارات للمستخدم مع عدّاد غير المقروء وتعليم كمقروء |
| 💬 واتساب | إرسال رسالة واحدة أو جماعية من لوحة الإدارة |
| 📬 تواصل معنا | استقبال رسائل عامة + إدارتها بحالة مقروء/غير مقروء وفلترة |
| 📄 إدارة المحتوى | من نحن، سياسة الإرجاع، سياسة الخصوصية، معلومات الشحن، معلومات المتجر |
| ⚙️ إعدادات | إعدادات الموقع الديناميكية و iframes |
| 🚦 Rate Limiting | حدود منفصلة للتسجيل، الدخول، OTP، الطلبات، رفع الإيصالات، وتواصل معنا |

---

## 🧰 التقنيات

- PHP 8.1+ / Laravel
- MySQL / MariaDB
- Laravel Sanctum
- Custom `permission` middleware

---

## ✅ المتطلبات

| المتطلب | ملاحظات |
| :--- | :--- |
| PHP **8.1+** | مع امتدادات `pdo_mysql` و `mbstring` و `openssl` و `fileinfo` و `curl` |
| Composer 2.x | التثبيت من `composer.lock` |
| MySQL 8+ / MariaDB 10.4+ | قاعدة البيانات |
| Node.js | **اختياري** — فقط لو بتبني أصول الواجهة |

---

## 📂 هيكل المشروع

```text
app/
├── Http/
│   ├── Controllers/           # كل الـ controllers (Auth, Product, Order, Payment, ContactUs, ...)
│   └── Middleware/            # permission middleware
├── Models/                    # Eloquent models
routes/
└── api.php                    # كل مسارات الـ API
database/
├── migrations/                # هيكل قاعدة البيانات
docs/
└── ContactUs.postman_collection.json   # مجموعة Postman لموديول تواصل معنا
```

---

## 🚀 التشغيل محليًا

### الطريقة السريعة

```bash
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan storage:link
php artisan serve
```

### الطريقة خطوة بخطوة

```bash
# 1. استنساخ المشروع
git clone https://github.com/<your-username>/<your-repo>.git
cd <your-repo>

# 2. تثبيت الاعتماديات
composer install

# 3. إعداد البيئة
cp .env.example .env
php artisan key:generate

# 4. اضبط بيانات قاعدة البيانات في .env ثم:
php artisan migrate

# 5. رابط التخزين العام (لصور المنتجات وإيصالات الدفع)
php artisan storage:link

# 6. التشغيل
php artisan serve
```

بعد التشغيل يكون الـ API على:

```text
http://localhost:8000/api
```

---

## 🧭 الصلاحيات

الأدوار بتتحكم في الوصول عن طريق `permission:<name>` على كل Route. الصلاحيات بتتربط
بالأدوار من `PUT /api/admin/roles/{id}/permissions`.

| المورد | الصلاحيات |
| :--- | :--- |
| الأدوار | `roles.view`, `roles.manage` |
| المستخدمون | `users.view`, `users.create`, `users.update`, `users.delete`, `users.assign_roles` |
| المنتجات | `products.create`, `products.update`, `products.delete` |
| الأقسام | `categories.create`, `categories.update`, `categories.delete` |
| الماركات | `brands.create`, `brands.update`, `brands.delete` |
| أنواع المنتجات | `product-types.create`, `product-types.update`, `product-types.delete` |
| الخدمات | `services.create`, `services.update`, `services.delete` |
| مناطق التوصيل | `delivery-areas.create`, `delivery-areas.update`, `delivery-areas.delete` |
| البانرات | `banners.create`, `banners.update`, `banners.delete` |
| بانرات العروض | `offer-banners.create`, `offer-banners.update`, `offer-banners.delete` |
| آراء العملاء | `testimonials.create`, `testimonials.update`, `testimonials.delete` |
| كوبونات الخصم | `discount-coupons.create`, `discount-coupons.update`, `discount-coupons.delete` |
| الطلبات | `orders.view`, `orders.update` |
| المدفوعات | `review-payments` |
| الحذف المالي | `delete-financial-records` |
| تواصل معنا | `contact-us.view`, `contact-us.update`, `contact-us.delete` |
| تقييمات المنتجات | `product-reviews.delete` |
| المحتوى + حالة المتجر | `content.update` |
| الإعدادات | `settings.update` |
| Iframes | `iframes.update` |
| الإشعارات | `notifications.view` |
| واتساب | `whatsapp.send` |

---

## 🔑 المصادقة

الـ API بيستخدم **Bearer Token** (Sanctum). ابعت التوكن مع كل طلب محمي:

```http
Authorization: Bearer <your-token>
Accept: application/json
```

---

## 🧾 الطلبات والمدفوعات

```text
العميل ينشئ طلب (POST /api/orders)  ← بدون تسجيل دخول
        │
        ▼
العميل يرفع إيصال الدفع (POST /api/orders/{id}/payment)
        │
        ▼
الإدارة تراجع الدفع (permission: review-payments)
   ├── approve ← تأكيد الدفع
   └── reject  ← رفض الدفع
        │
        ▼
الإدارة تحدّث حالة الطلب (PUT /api/orders/{id})  [orders.update]
```

- إنشاء الطلب ورفع الإيصال عليهم Rate Limit (`20` طلب/دقيقة).
- الحذف المالي (حذف طلب أو دفعة) يحتاج صلاحية مستقلة `delete-financial-records`.
- لازم `OrderController::show()` يتأكد إن الطلب يخص المستخدم الحالي (فحص ملكية).

---

## 📬 تواصل معنا (Contact Us)

العملاء بيبعتوا رسائل من غير تسجيل دخول، والموظفين بيديروها بصلاحيات منفصلة وحالة
مقروء / غير مقروء.

| Method | Endpoint | الصلاحية | الوصف |
| :--- | :--- | :--- | :--- |
| POST | `/api/contact-us` | عام (`10` طلب/دقيقة) | إرسال رسالة |
| GET | `/api/contact-us` | `contact-us.view` | كل الرسائل مع `unread_count` |
| GET | `/api/contact-us?status=unread` | `contact-us.view` | غير المقروءة فقط |
| GET | `/api/contact-us?status=read` | `contact-us.view` | المقروءة فقط |
| GET | `/api/contact-us/{id}` | `contact-us.view` | عرض رسالة (بتتعلّم مقروءة تلقائيًا) |
| PUT | `/api/contact-us/{id}` | `contact-us.update` | تعديل رسالة |
| PATCH | `/api/contact-us/{id}/read` | `contact-us.update` | تعليم كمقروءة |
| PATCH | `/api/contact-us/{id}/unread` | `contact-us.update` | تعليم كغير مقروءة |
| PATCH | `/api/contact-us/read-all` | `contact-us.update` | تعليم الكل كمقروء |
| DELETE | `/api/contact-us/{id}` | `contact-us.delete` | حذف رسالة |

**مثال للاستجابة:** `GET /api/contact-us`

```json
{
  "unread_count": 3,
  "contacts": [
    {
      "id": 12,
      "name": "Ahmed Ali",
      "email": "ahmed@example.com",
      "phone": "01012345678",
      "subject": "استفسار عن منتج",
      "message": "عايز أعرف تفاصيل أكتر",
      "is_read": false,
      "read_at": null,
      "created_at": "2026-11-19T11:00:00.000000Z"
    }
  ]
}
```

---

## 🗺️ ملخص الـ API

| المجموعة | المسارات | المصادقة |
| :--- | :--- | :--- |
| المصادقة | `/api/register`, `/api/login`, `/api/verify-otp` | عام (Rate Limited) |
| الكتالوج | `/api/products`, `/categories`, `/brands`, `/product-types`, `/services`, `/delivery-areas` | عام (قراءة) |
| التسويق | `/api/banners`, `/offer-banners`, `/discount-coupons`, `/testimonials` | عام (قراءة) |
| المحتوى | `/api/about-us`, `/returns-policy`, `/privacy-policy`, `/shipping-info`, `/store-info` | عام (قراءة) |
| الطلبات | `POST /api/orders`, `POST /api/orders/{id}/payment`, `/payment-methods` | عام |
| تواصل معنا | `POST /api/contact-us` | عام |
| الحساب | `/api/logout`, `/update-profile`, `/change-password` | Sanctum |
| طلباتي | `/api/my-orders`, `/api/orders/{id}` | Sanctum |
| الإشعارات | `/api/notifications/*` | Sanctum |
| الإيميل | `POST /api/send-mail` | Sanctum |
| الإدارة | `/api/admin/*` (مستخدمون، أدوار، صلاحيات، واتساب، إشعارات) | Sanctum + permission |
| إدارة الموارد | `POST / PUT / DELETE` على كل مورد | Sanctum + permission |
| المدفوعات | `/api/admin/payments/*` | Sanctum + `review-payments` |

> للرفع بـ `multipart/form-data` استخدم نسخ `POST` الخاصة بالتحديث
> (مثل `/products/update/{id}` و `/categories/update/{id}`).

---

## 🚦 Rate Limiting

| المسار | الحد |
| :--- | :--- |
| `POST /api/register` | 10 طلبات / دقيقة |
| `POST /api/login` | 10 طلبات / دقيقة |
| `POST /api/verify-otp` | 5 طلبات / دقيقة |
| `POST /api/orders` | 20 طلب / دقيقة |
| `POST /api/orders/{id}/payment` | 20 طلب / دقيقة |
| `POST /api/contact-us` | 10 طلبات / دقيقة |

---

## ⚙️ متغيرات البيئة المهمة

| المتغير | الوصف |
| :--- | :--- |
| `APP_ENV` / `APP_DEBUG` | `APP_DEBUG` **لازم** يكون `false` في الإنتاج |
| `APP_URL` | رابط التطبيق |
| `DB_*` | إعدادات قاعدة البيانات |
| `SANCTUM_STATEFUL_DOMAINS` | نطاقات Sanctum للـ SPA |
| `MAIL_*` | إعدادات البريد (SMTP) |
| `WHATSAPP_*` | إعدادات خدمة واتساب (عدّل الأسماء حسب مشروعك) |

---

## 🛡️ ملاحظات أمان

- `APP_DEBUG=false` في الإنتاج، ولا ترفع `.env` على Git.
- كل المسارات الإدارية محمية بـ `auth:sanctum` + `permission:*`.
- المسارات العامة اللي بتكتب بيانات (`register`, `login`, `verify-otp`, `orders`, `contact-us`) عليها Rate Limiting.
- لا تستخدم `GET` لتغيير الحالة (حالة المتجر بتتغير بـ `POST /api/store/toggle-status` بصلاحية `content.update`).
- بعد أي تعديل في الروتس أو الصلاحيات:

```bash
php artisan route:clear && php artisan cache:clear
```

---

## 📚 التوثيق

- [مجموعة Postman لموديول تواصل معنا](docs/ContactUs.postman_collection.json)

---

## 👤 المطوّر

**Abdalrhman AbdoAlhade** — Back-End Developer (PHP/Laravel)

[![Portfolio](https://img.shields.io/badge/Portfolio-0ea5e9?style=for-the-badge&logo=vercel&logoColor=white)](https://abdalrhman-abdo-alhade.vercel.app/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/abdalrhman-abdoalhade-6673312ba)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/AbdalrhmanAbdoAlhade)

---

## 📄 الرخصة

هذا المشروع مرخص تحت رخصة **MIT** — راجع [LICENSE](LICENSE).
