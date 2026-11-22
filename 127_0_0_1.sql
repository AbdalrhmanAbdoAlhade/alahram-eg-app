-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- مضيف: 127.0.0.1:3306
-- وقت الجيل: 22 نوفمبر 2026 الساعة 17:13
-- إصدار الخادم: 8.4.10-10
-- نسخة PHP: 8.1.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- قاعدة بيانات: `alahram`
--
CREATE DATABASE IF NOT EXISTS `alahram` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `alahram`;

-- --------------------------------------------------------

--
-- بنية الجدول `about_us`
--

CREATE TABLE `about_us` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `goal` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `mission` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `vision` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `goal_en` text COLLATE utf8mb4_unicode_ci,
  `mission_en` text COLLATE utf8mb4_unicode_ci,
  `vision_en` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `title_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `about_us`
--

INSERT INTO `about_us` (`id`, `title`, `description`, `image`, `goal`, `mission`, `vision`, `goal_en`, `mission_en`, `vision_en`, `created_at`, `updated_at`, `title_en`, `description_en`) VALUES
(1, 'الاهرام', '<p>شركة الأهرام هي شركة متخصصة في صبغات الماكينة، وماكينات التلوين بالكمبيوتر وبرمجتها، مع توفير قطع الغيار الأصلية وخدمات الصيانة الدورية والشاملة بأعلى مستوى من الاحترافية.</p><p><br></p><p>تأسست الشركة منذ أكثر من 14 عامًا، وخلال هذه السنوات اكتسبنا خبرة واسعة مكنتنا من تلبية احتياجات مراكز التلوين وشركات الدهانات، وتقديم حلول متكاملة تساعدهم على تحقيق أفضل نتائج في دقة الألوان وكفاءة التشغيل.</p><p><br></p><p>نحرص في الأهرام على تقديم خدمات موثوقة تعتمد على الخبرة العملية، والدقة في التنفيذ، والالتزام بمعايير الجودة، مع دعم فني مستمر يضمن استمرارية العمل بأفضل أداء ممكن.</p><p><br></p><p>هدفنا هو أن نكون الشريك الموثوق لعملائنا في كل ما يخص أنظمة التلوين، من التركيب والبرمجة إلى الصيانة والدعم الفني</p>', 'https://alahram.d-aflaj.sa/about_us/69397ee62563b.jpg', '<p>هدفنا هو توفير صبغات ماكينات التلوين بجودة عالية وسعر منافس، مع تقديم الدعم الفني بعد البيع، وبرمجة ماكينات التلوين والسوفت وير الخاص بها بما يواكب التطورات السنوية، لتلبية احتياجات عملائنا بأسرع وقت ممكن مع الحفاظ على جودة وكفاءة العمل</p>', '<p>تقديم صبغات وماكينات تلوين عالية الجودة، مع دعم فني موثوق وخدمات برمجة وصيانة متكاملة، لضمان رضا العملاء وتلبية احتياجاتهم بسرعة وكفاءة</p>', '<p>نسعى لنكون الشركة الرائدة في مجال صبغات وماكينات التلوين، من خلال تقديم حلول مبتكرة وعالية الجودة تلبي احتياجات عملائنا باستمرار، مع مواكبة أحدث التطورات التكنولوجية في الصناعة</p>', '<p>Our goal is to provide high-quality paint for coloring machines at competitive prices, along with reliable after-sales technical support. We also focus on programming coloring machines and their software to keep up with annual technological advancements, ensuring our clients’ needs are met as quickly as possible while maintaining the quality and efficiency of our work.</p>', '<p>To provide high-quality paint and coloring machines, along with reliable technical support and comprehensive programming and maintenance services, ensuring customer satisfaction and meeting their needs quickly and efficiently.</p>', '<p>We aim to be a leading company in the field of paint and coloring machines by providing innovative, high-quality solutions that consistently meet our clients’ needs while keeping pace with the latest technological advancements in the industry.</p>', NULL, '2026-01-02 12:46:04', 'الاهرام', '<p>Al Ahram is a specialized company in machine tinting systems, computerized color mixing machines, and their programming, with full support for spare parts availability, routine maintenance, and comprehensive maintenance services.</p><p><br></p><p>Established over 14 years ago, Al Ahram has built solid experience in serving color mixing centers and paint companies, providing reliable and efficient solutions that ensure accurate color results and smooth machine performance.</p><p><br></p><p>We are committed to delivering high-quality services based on technical expertise, precision, and long-term reliability. Our team works closely with clients to support their operations and ensure continuous, optimal performance of their tinting systems.</p><p><br></p><p>At Al Ahram, our goal is to be a trusted partner for all color mixing and tinting machine needs, from setup and programming to ongoing maintenance and technical support.</p>');

-- --------------------------------------------------------

--
-- بنية الجدول `banners`
--

CREATE TABLE `banners` (
  `id` bigint UNSIGNED NOT NULL,
  `img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'image',
  `video` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `product_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `title_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `banners`
--

INSERT INTO `banners` (`id`, `img`, `media_type`, `video`, `title`, `description`, `category_id`, `product_id`, `created_at`, `updated_at`, `title_en`, `description_en`) VALUES
(2, 'banners/694bafc504a2b.jpg', 'image', NULL, 'عالم من الألوان', 'اكتشف مجموعتنا الواسعة من الألوان عالية الجودة لجميع احتياجاتك الإبداعية', 2, NULL, '2025-12-24 09:17:57', '2025-12-24 09:17:57', 'عالم من الألوان', 'اكتشف مجموعتنا الواسعة من الألوان عالية الجودة لجميع احتياجاتك الإبداعية'),
(4, NULL, 'video', 'banners/videos/6b02d74bf2650.mp4', 'عنوان البانر', 'وصف البانر', NULL, NULL, '2026-11-22 11:51:39', '2026-11-22 11:51:39', 'Banner title', 'Banner description'),
(6, NULL, 'video', 'banners/videos/6b02f7476dc23.mp4', 'Sed et magna volupta', 'Sit est nostrud quo', 1, NULL, '2026-11-22 14:08:07', '2026-11-22 14:08:07', 'Voluptatem Rerum et', 'Minima iure voluptat');

-- --------------------------------------------------------

--
-- بنية الجدول `brands`
--

CREATE TABLE `brands` (
  `id` bigint UNSIGNED NOT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `banner_status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `categories`
--

INSERT INTO `categories` (`id`, `img`, `banner`, `name`, `description`, `banner_status`, `created_at`, `updated_at`, `parent_id`, `name_en`, `description_en`) VALUES
(1, 'categories/695aa29b6eed5.png', 'categories/695aa330557a0.png', 'قسم ملونات Brightint', 'BrightTint صبغات تضم 16 لونًا زاهيًا بثبات قوي وتجانس ممتاز لنتائج احترافية.', 1, '2025-12-10 13:17:10', '2026-01-04 17:28:16', NULL, 'Colors section Brightint', 'Waffle Center BrightTint pigments come in 16 vibrant colors, delivering excellent color stability and consistent, professional results.'),
(2, 'categories/695aa31249059.png', 'categories/695aa3124952b.png', 'قسم ملونات VIBRANTZ', 'VIBRANTZ شركة هولندية متخصصة في الصبغات، توفر 16 لونًا عالي الجودة بثبات قوي وتجانس ممتاز لنتائج احترافية.', 1, '2025-12-10 13:32:31', '2026-01-04 17:27:46', NULL, 'Colors section VIBRANTZ', 'مركز الواVIBRANTZ is a Dutch company that specializes in pigments, offering 16 high-quality colors with excellent color stability and consistent professional resultsن'),
(3, 'categories/695d698a57bd5.jpg', 'categories/695d698a57cce.jpg', 'قسم الماكينات الجديده', 'مركز الوانقسم الماكينات الجديدة اكتشف أحدث الماكينات المتوفرة لدينا، بمواصفات متطورة وأداء موثوق', 1, '2025-12-10 13:36:32', '2026-01-06 19:59:06', NULL, 'New Machines', 'مركز الوانExplore our New Machines section, featuring the latest equipment with advanced performance and reliability.'),
(4, 'categories/695d69af1398a.jpg', 'categories/695d69af13a11.jpg', 'قسم الماكينات المستعمله', 'قسم الماكينات المستعملة – اكتشف معدات موثوقة مستعملة بجودة عالية وبسعر مناسب', 1, '2025-12-10 13:37:43', '2026-01-06 20:00:50', NULL, 'Used Machines', 'our Used Machines section, offering reliable pre-owned equipment at great value.ان'),
(5, 'categories/6963f0e38f8cd.png', 'categories/6963f0e38faf6.png', 'كاتلوجات', 'كاتوجات تضم كلاًمن NCS -NOVA-COLOYR TRIND-RAL', 1, '2026-01-06 20:28:29', '2026-01-11 18:50:11', NULL, 'CATALOG', 'NCS -NOVA-COLOYR TRIND-RAL'),
(7, 'categories/6afee354b1664.png', 'categories/6afee354b1e35.png', 'Laborum illum dolor', 'Sint qui et id null', 0, '2026-11-19 11:53:56', '2026-11-19 11:53:56', NULL, 'Sapiente modi et ill', 'Laborum officia et t'),
(8, 'categories/6afeec5dc9eb3.png', 'categories/6afeec5dc9f2a.png', 'Mollitia suscipit re', 'Provident ut simili', 1, '2026-11-19 12:32:29', '2026-11-19 12:32:29', NULL, 'Iusto et in ut aliqu', 'In doloremque expedi');

-- --------------------------------------------------------

--
-- بنية الجدول `contact_us`
--

CREATE TABLE `contact_us` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `contact_us`
--

INSERT INTO `contact_us` (`id`, `name`, `email`, `phone`, `subject`, `message`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES
(1, 'ABDUL MOTIN', 'amotin2010@gmail.com', '0532213220', 'تلوينه كمبيوتر', 'عنوان دهانات بلازون فرع رنية', 0, NULL, '2026-03-31 06:31:37', '2026-03-31 06:31:37'),
(2, 'أحمد محمد', 'ahmed@example.com', '01012345678', 'استفسار عن طلب', 'السلام عليكم، أريد الاستفسار عن موعد التوصيل.', 1, '2026-11-19 11:05:00', '2026-11-18 13:33:38', '2026-11-19 11:05:00');

-- --------------------------------------------------------

--
-- بنية الجدول `delivery_areas`
--

CREATE TABLE `delivery_areas` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `delivery_areas`
--

INSERT INTO `delivery_areas` (`id`, `name`, `name_en`, `shipping_cost`, `created_at`, `updated_at`) VALUES
(1, 'test', 'test', 20.00, '2025-12-24 09:50:13', '2025-12-24 09:50:13');

-- --------------------------------------------------------

--
-- بنية الجدول `discount_coupons`
--

CREATE TABLE `discount_coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount` int NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `end_date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(1, '2e2d67d2-a118-4799-aa20-aa4d5903aca3', 'database', 'default', '{\"uuid\":\"2e2d67d2-a118-4799-aa20-aa4d5903aca3\",\"displayName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\SendWhatsAppMessageJob\\\":2:{s:8:\\\"\\u0000*\\u0000phone\\\";s:13:\\\"2001040701880\\\";s:10:\\\"\\u0000*\\u0000message\\\";s:151:\\\" *رمز تسجيل الدخول - شركة الأهرام*\\n\\nرمز التحقق:\\n*710676*\\n\\n صالح لمدة 5 دقائق\\n لا تشارك الرمز\\\";}\"},\"createdAt\":1767731882,\"delay\":null}', 'Exception: Failed to send WhatsApp to 2001040701880 in /home/alahrm-api/htdocs/api.alahrm.com/app/Jobs/SendWhatsAppMessageJob.php:34\nStack trace:\n#0 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): App\\Jobs\\SendWhatsAppMessageJob->handle()\n#1 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#3 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#4 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#5 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()\n#6 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}()\n#7 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#8 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()\n#9 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#10 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}()\n#11 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#12 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then()\n#13 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#14 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#15 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(451): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(401): Illuminate\\Queue\\Worker->process()\n#17 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(187): Illuminate\\Queue\\Worker->runJob()\n#18 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#19 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#20 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#23 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#24 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#25 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#26 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Command/Command.php(318): Illuminate\\Console\\Command->execute()\n#27 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#28 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(1110): Illuminate\\Console\\Command->run()\n#29 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(359): Symfony\\Component\\Console\\Application->doRunCommand()\n#30 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(194): Symfony\\Component\\Console\\Application->doRun()\n#31 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#32 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()\n#33 /home/alahrm-api/htdocs/api.alahrm.com/artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#34 {main}', '2026-01-06 20:38:03'),
(2, 'dc69a3f5-6d5b-4682-8e02-3c502c25ddaf', 'database', 'default', '{\"uuid\":\"dc69a3f5-6d5b-4682-8e02-3c502c25ddaf\",\"displayName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\SendWhatsAppMessageJob\\\":2:{s:8:\\\"\\u0000*\\u0000phone\\\";s:17:\\\"2020 011 12087090\\\";s:10:\\\"\\u0000*\\u0000message\\\";s:151:\\\" *رمز تسجيل الدخول - شركة الأهرام*\\n\\nرمز التحقق:\\n*811341*\\n\\n صالح لمدة 5 دقائق\\n لا تشارك الرمز\\\";}\"},\"createdAt\":1768969282,\"delay\":null}', 'Exception: Failed to send WhatsApp to 2020 011 12087090 in /home/alahrm-api/htdocs/api.alahrm.com/app/Jobs/SendWhatsAppMessageJob.php:34\nStack trace:\n#0 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): App\\Jobs\\SendWhatsAppMessageJob->handle()\n#1 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#3 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#4 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#5 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()\n#6 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}()\n#7 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#8 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()\n#9 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#10 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}()\n#11 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#12 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then()\n#13 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#14 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#15 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(451): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(401): Illuminate\\Queue\\Worker->process()\n#17 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(187): Illuminate\\Queue\\Worker->runJob()\n#18 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#19 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#20 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#23 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#24 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#25 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#26 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Command/Command.php(318): Illuminate\\Console\\Command->execute()\n#27 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#28 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(1110): Illuminate\\Console\\Command->run()\n#29 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(359): Symfony\\Component\\Console\\Application->doRunCommand()\n#30 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(194): Symfony\\Component\\Console\\Application->doRun()\n#31 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#32 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()\n#33 /home/alahrm-api/htdocs/api.alahrm.com/artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#34 {main}', '2026-01-21 04:22:03'),
(3, 'f895ef42-cb76-4717-8416-7c3c1faaa4b0', 'database', 'default', '{\"uuid\":\"f895ef42-cb76-4717-8416-7c3c1faaa4b0\",\"displayName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\SendWhatsAppMessageJob\\\":2:{s:8:\\\"\\u0000*\\u0000phone\\\";s:13:\\\"2003267275062\\\";s:10:\\\"\\u0000*\\u0000message\\\";s:151:\\\" *رمز تسجيل الدخول - شركة الأهرام*\\n\\nرمز التحقق:\\n*455565*\\n\\n صالح لمدة 5 دقائق\\n لا تشارك الرمز\\\";}\"},\"createdAt\":1769705396,\"delay\":null}', 'Exception: Failed to send WhatsApp to 2003267275062 in /home/alahrm-api/htdocs/api.alahrm.com/app/Jobs/SendWhatsAppMessageJob.php:34\nStack trace:\n#0 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): App\\Jobs\\SendWhatsAppMessageJob->handle()\n#1 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#3 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#4 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#5 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()\n#6 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}()\n#7 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#8 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()\n#9 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#10 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}()\n#11 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#12 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then()\n#13 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#14 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#15 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(451): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(401): Illuminate\\Queue\\Worker->process()\n#17 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(187): Illuminate\\Queue\\Worker->runJob()\n#18 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#19 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#20 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#23 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#24 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#25 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#26 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Command/Command.php(318): Illuminate\\Console\\Command->execute()\n#27 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#28 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(1110): Illuminate\\Console\\Command->run()\n#29 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(359): Symfony\\Component\\Console\\Application->doRunCommand()\n#30 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(194): Symfony\\Component\\Console\\Application->doRun()\n#31 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#32 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()\n#33 /home/alahrm-api/htdocs/api.alahrm.com/artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#34 {main}', '2026-01-29 16:50:03'),
(4, 'b8f0732a-e6dd-4c27-8197-c976ac714999', 'database', 'default', '{\"uuid\":\"b8f0732a-e6dd-4c27-8197-c976ac714999\",\"displayName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\SendWhatsAppMessageJob\\\":2:{s:8:\\\"\\u0000*\\u0000phone\\\";s:13:\\\"2003267275062\\\";s:10:\\\"\\u0000*\\u0000message\\\";s:152:\\\" *رمز تسجيل الدخول - شركة الأهرام*\\n\\nرمز التحقق:\\n *471681*\\n\\n صالح لمدة 5 دقائق\\n لا تشارك الرمز\\\";}\"},\"createdAt\":1769705428,\"delay\":null}', 'Exception: Failed to send WhatsApp to 2003267275062 in /home/alahrm-api/htdocs/api.alahrm.com/app/Jobs/SendWhatsAppMessageJob.php:34\nStack trace:\n#0 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): App\\Jobs\\SendWhatsAppMessageJob->handle()\n#1 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#3 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#4 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#5 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()\n#6 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}()\n#7 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#8 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()\n#9 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#10 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}()\n#11 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#12 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then()\n#13 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#14 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#15 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(451): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(401): Illuminate\\Queue\\Worker->process()\n#17 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(187): Illuminate\\Queue\\Worker->runJob()\n#18 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#19 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#20 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#23 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#24 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#25 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#26 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Command/Command.php(318): Illuminate\\Console\\Command->execute()\n#27 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#28 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(1110): Illuminate\\Console\\Command->run()\n#29 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(359): Symfony\\Component\\Console\\Application->doRunCommand()\n#30 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(194): Symfony\\Component\\Console\\Application->doRun()\n#31 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#32 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()\n#33 /home/alahrm-api/htdocs/api.alahrm.com/artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#34 {main}', '2026-01-29 16:51:01'),
(5, 'c8866dd3-fbdf-432f-9a57-161575066367', 'database', 'default', '{\"uuid\":\"c8866dd3-fbdf-432f-9a57-161575066367\",\"displayName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\SendWhatsAppMessageJob\\\":2:{s:8:\\\"\\u0000*\\u0000phone\\\";s:13:\\\"2001040701880\\\";s:10:\\\"\\u0000*\\u0000message\\\";s:152:\\\" *رمز تسجيل الدخول - شركة الأهرام*\\n\\nرمز التحقق:\\n *813933*\\n\\n صالح لمدة 5 دقائق\\n لا تشارك الرمز\\\";}\"},\"createdAt\":1770637133,\"delay\":null}', 'Exception: Failed to send WhatsApp to 2001040701880 in /home/alahrm-api/htdocs/api.alahrm.com/app/Jobs/SendWhatsAppMessageJob.php:34\nStack trace:\n#0 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): App\\Jobs\\SendWhatsAppMessageJob->handle()\n#1 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#3 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#4 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#5 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()\n#6 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}()\n#7 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#8 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()\n#9 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#10 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}()\n#11 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#12 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then()\n#13 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#14 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#15 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(451): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(401): Illuminate\\Queue\\Worker->process()\n#17 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(187): Illuminate\\Queue\\Worker->runJob()\n#18 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#19 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#20 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#23 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#24 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#25 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#26 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Command/Command.php(318): Illuminate\\Console\\Command->execute()\n#27 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#28 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(1110): Illuminate\\Console\\Command->run()\n#29 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(359): Symfony\\Component\\Console\\Application->doRunCommand()\n#30 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(194): Symfony\\Component\\Console\\Application->doRun()\n#31 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#32 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()\n#33 /home/alahrm-api/htdocs/api.alahrm.com/artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#34 {main}', '2026-02-09 11:39:02'),
(6, '625d59a6-2945-469e-b7bf-6c51e92f2501', 'database', 'default', '{\"uuid\":\"625d59a6-2945-469e-b7bf-6c51e92f2501\",\"displayName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\SendWhatsAppMessageJob\\\":2:{s:8:\\\"\\u0000*\\u0000phone\\\";s:12:\\\"201040701880\\\";s:10:\\\"\\u0000*\\u0000message\\\";s:152:\\\" *رمز تسجيل الدخول - شركة الأهرام*\\n\\nرمز التحقق:\\n *583094*\\n\\n صالح لمدة 5 دقائق\\n لا تشارك الرمز\\\";}\"},\"createdAt\":1770637824,\"delay\":null}', 'Exception: Failed to send WhatsApp to 201040701880 in /home/alahrm-api/htdocs/api.alahrm.com/app/Jobs/SendWhatsAppMessageJob.php:34\nStack trace:\n#0 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): App\\Jobs\\SendWhatsAppMessageJob->handle()\n#1 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#3 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#4 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#5 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()\n#6 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}()\n#7 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#8 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()\n#9 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#10 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}()\n#11 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#12 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then()\n#13 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#14 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#15 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(451): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(401): Illuminate\\Queue\\Worker->process()\n#17 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(187): Illuminate\\Queue\\Worker->runJob()\n#18 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#19 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#20 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#23 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#24 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#25 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#26 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Command/Command.php(318): Illuminate\\Console\\Command->execute()\n#27 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#28 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(1110): Illuminate\\Console\\Command->run()\n#29 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(359): Symfony\\Component\\Console\\Application->doRunCommand()\n#30 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(194): Symfony\\Component\\Console\\Application->doRun()\n#31 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#32 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()\n#33 /home/alahrm-api/htdocs/api.alahrm.com/artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#34 {main}', '2026-02-09 11:51:02'),
(7, 'b41e3122-39b9-4347-8291-633e14777bc0', 'database', 'default', '{\"uuid\":\"b41e3122-39b9-4347-8291-633e14777bc0\",\"displayName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\SendWhatsAppMessageJob\\\":2:{s:8:\\\"\\u0000*\\u0000phone\\\";s:12:\\\"249123622104\\\";s:10:\\\"\\u0000*\\u0000message\\\";s:151:\\\" *رمز تسجيل الدخول - شركة الأهرام*\\n\\nرمز التحقق:\\n*691331*\\n\\n صالح لمدة 5 دقائق\\n لا تشارك الرمز\\\";}\"},\"createdAt\":1775510679,\"delay\":null}', 'Exception: Failed to send WhatsApp to 249123622104 in /home/alahrm-api/htdocs/api.alahrm.com/app/Jobs/SendWhatsAppMessageJob.php:34\nStack trace:\n#0 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): App\\Jobs\\SendWhatsAppMessageJob->handle()\n#1 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#3 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#4 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#5 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()\n#6 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}()\n#7 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#8 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()\n#9 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#10 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}()\n#11 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#12 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then()\n#13 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#14 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#15 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(451): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(401): Illuminate\\Queue\\Worker->process()\n#17 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(187): Illuminate\\Queue\\Worker->runJob()\n#18 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#19 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#20 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#23 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#24 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#25 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#26 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Command/Command.php(318): Illuminate\\Console\\Command->execute()\n#27 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#28 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(1110): Illuminate\\Console\\Command->run()\n#29 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(359): Symfony\\Component\\Console\\Application->doRunCommand()\n#30 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(194): Symfony\\Component\\Console\\Application->doRun()\n#31 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#32 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()\n#33 /home/alahrm-api/htdocs/api.alahrm.com/artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#34 {main}', '2026-04-06 21:25:02');
INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(8, '57c46c37-49ae-4a7f-bc9d-a8b2363b2420', 'database', 'default', '{\"uuid\":\"57c46c37-49ae-4a7f-bc9d-a8b2363b2420\",\"displayName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\SendWhatsAppMessageJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\SendWhatsAppMessageJob\\\":2:{s:8:\\\"\\u0000*\\u0000phone\\\";s:12:\\\"249915595977\\\";s:10:\\\"\\u0000*\\u0000message\\\";s:151:\\\" *رمز تسجيل الدخول - شركة الأهرام*\\n\\nرمز التحقق:\\n*427262*\\n\\n صالح لمدة 5 دقائق\\n لا تشارك الرمز\\\";}\"},\"createdAt\":1775510987,\"delay\":null}', 'Exception: Failed to send WhatsApp to 249915595977 in /home/alahrm-api/htdocs/api.alahrm.com/app/Jobs/SendWhatsAppMessageJob.php:34\nStack trace:\n#0 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): App\\Jobs\\SendWhatsAppMessageJob->handle()\n#1 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#3 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#4 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#5 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(129): Illuminate\\Container\\Container->call()\n#6 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}()\n#7 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#8 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then()\n#9 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#10 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}()\n#11 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}()\n#12 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then()\n#13 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#14 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#15 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(451): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(401): Illuminate\\Queue\\Worker->process()\n#17 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(187): Illuminate\\Queue\\Worker->runJob()\n#18 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#19 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#20 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#23 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#24 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Container/Container.php(836): Illuminate\\Container\\BoundMethod::call()\n#25 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(211): Illuminate\\Container\\Container->call()\n#26 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Command/Command.php(318): Illuminate\\Console\\Command->execute()\n#27 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Console/Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#28 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(1110): Illuminate\\Console\\Command->run()\n#29 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(359): Symfony\\Component\\Console\\Application->doRunCommand()\n#30 /home/alahrm-api/htdocs/api.alahrm.com/vendor/symfony/console/Application.php(194): Symfony\\Component\\Console\\Application->doRun()\n#31 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#32 /home/alahrm-api/htdocs/api.alahrm.com/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle()\n#33 /home/alahrm-api/htdocs/api.alahrm.com/artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#34 {main}', '2026-04-06 21:30:03');

-- --------------------------------------------------------

--
-- بنية الجدول `iframe_settings`
--

CREATE TABLE `iframe_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `facebook` tinyint(1) NOT NULL DEFAULT '0',
  `instagram` tinyint(1) NOT NULL DEFAULT '0',
  `twitter` tinyint(1) NOT NULL DEFAULT '0',
  `whatsapp` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_05_28_142321_create_personal_access_tokens_table', 1),
(5, '2025_05_28_142412_create_about_us_table', 1),
(6, '2025_05_28_142412_create_discount_coupons_table', 1),
(7, '2025_05_28_142413_create_privacy_policies_table', 1),
(8, '2025_05_28_142413_create_returns_policies_table', 1),
(9, '2025_05_28_142413_create_shipping_infos_table', 1),
(10, '2025_05_28_142413_create_store_infos_table', 1),
(11, '2025_05_28_142414_create_banners_table', 1),
(12, '2025_05_28_142414_create_categories_table', 1),
(13, '2025_05_28_142414_create_contact_us_table', 1),
(14, '2025_05_28_142414_create_offer_banners_table', 1),
(15, '2025_05_28_142415_create_brands_table', 1),
(16, '2025_05_28_142415_create_product_reviews_table', 1),
(17, '2025_05_28_142415_create_products_table', 1),
(18, '2025_05_28_142415_create_testimonials_table', 1),
(19, '2025_06_02_071528_create_iframe_settings_table', 1),
(20, '2025_06_02_093708_create_orders_table', 1),
(21, '2025_06_02_093751_create_order_items_table', 1),
(22, '2025_06_28_193107_add_parent_id_to_categories_table', 1),
(23, '2025_07_20_193107_create_payments_table', 1),
(24, '2025_10_26_133242_create_delivery_areas_table', 1),
(25, '2025_10_26_133242_create_settings_table', 1),
(26, '2025_10_26_133323_add_delivery_area_id_to_orders_table', 1),
(27, '2025_10_26_161736_add_shipping_cost_to_orders_table', 1),
(28, '2025_10_26_161736_create_user_notifications_table', 1),
(29, '2025_10_28_115702_update_store_info_social_media', 1),
(30, '2025_10_30_103447_add_accepts_emails_to_users_table', 1),
(31, '2025_10_30_104442_add_vat_to_settings_table', 1),
(32, '2025_10_30_104937_add_vat_to_orders_table', 1),
(33, '2025_12_08_123115_create_services_table', 1),
(34, '2025_12_25_111650_add_details_to_orders_table', 2),
(35, '2026_11_17_120115_create_permission_tables', 3),
(36, '2026_11_17_120200_migrate_legacy_roles_to_spatie', 3),
(37, '2026_11_17_124622_add_users_assign_roles_permission', 4),
(38, '2026_11_17_131356_add_youtube_video_url_to_products_table', 5),
(39, '2026_11_17_131356_create_product_steps_table', 5),
(40, '2026_11_17_000001_create_product_types_table', 6),
(41, '2026_11_17_000002_add_type_id_to_products_table', 6),
(42, '2026_11_18_000001_add_checkout_fields_to_orders_table', 7),
(43, '2026_11_18_000002_remove_paymob_columns_from_orders_table', 7),
(44, '2026_11_18_000003_rebuild_payments_table', 7),
(45, '2026_11_18_000004_add_payment_info_to_settings_table', 7),
(46, '2026_11_19_104721_add_is_read_to_contact_us_table', 8);

-- --------------------------------------------------------

--
-- بنية الجدول `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(4, 'App\\Models\\User', 2),
(4, 'App\\Models\\User', 5),
(4, 'App\\Models\\User', 6),
(4, 'App\\Models\\User', 7),
(4, 'App\\Models\\User', 8),
(4, 'App\\Models\\User', 9),
(4, 'App\\Models\\User', 10),
(4, 'App\\Models\\User', 11),
(4, 'App\\Models\\User', 12),
(4, 'App\\Models\\User', 13),
(4, 'App\\Models\\User', 14),
(4, 'App\\Models\\User', 15),
(4, 'App\\Models\\User', 16),
(4, 'App\\Models\\User', 17),
(4, 'App\\Models\\User', 18),
(4, 'App\\Models\\User', 19),
(4, 'App\\Models\\User', 20),
(4, 'App\\Models\\User', 21),
(4, 'App\\Models\\User', 22),
(4, 'App\\Models\\User', 23),
(4, 'App\\Models\\User', 24),
(4, 'App\\Models\\User', 25),
(4, 'App\\Models\\User', 26),
(4, 'App\\Models\\User', 27),
(4, 'App\\Models\\User', 28),
(4, 'App\\Models\\User', 29),
(4, 'App\\Models\\User', 30),
(2, 'App\\Models\\User', 31),
(4, 'App\\Models\\User', 32),
(4, 'App\\Models\\User', 33);

-- --------------------------------------------------------

--
-- بنية الجدول `offer_banners`
--

CREATE TABLE `offer_banners` (
  `id` bigint UNSIGNED NOT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `title_en` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `product_id` bigint UNSIGNED DEFAULT NULL,
  `end_date` date NOT NULL,
  `discount` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payment_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `discount_coupon_id` bigint UNSIGNED DEFAULT NULL,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delivery_area_id` bigint UNSIGNED DEFAULT NULL,
  `shipping_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `vat_percentage` decimal(5,2) NOT NULL DEFAULT '0.00',
  `vat_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `country` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `governorate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_number` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `terms_accepted_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `name`, `company`, `phone`, `email`, `city`, `total_price`, `status`, `address`, `payment_type`, `discount_coupon_id`, `discount_amount`, `created_at`, `updated_at`, `delivery_area_id`, `shipping_cost`, `vat_percentage`, `vat_amount`, `country`, `state`, `governorate`, `district`, `whatsapp_number`, `latitude`, `longitude`, `notes`, `terms_accepted_at`, `deleted_at`) VALUES
(1, 1, 'أحمد محمد', NULL, '201023402756', 'abdo.king22227@gmail.com', 'القاهرة', 20.00, 'pending', 'شارع التحرير - الدور الثالث', 'cash', NULL, 0.00, '2025-12-25 11:18:36', '2025-12-25 11:18:36', NULL, 20.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 'أحمد محمد', NULL, '201023402756', 'abdo.king22227@gmail.com', 'القاهرة', 20.00, 'pending', 'شارع التحرير - الدور الثالث', 'cash', NULL, 0.00, '2025-12-25 11:32:28', '2025-12-25 11:32:28', NULL, 20.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, 'أحمد محمد', NULL, '201023402756', 'abdo.king22227@gmail.com', 'القاهرة', 420.00, 'pending', 'شارع التحرير - الدور الثالث', 'cash', NULL, 0.00, '2025-12-25 11:43:24', '2025-12-25 11:43:24', NULL, 20.00, 0.00, 0.00, 'sa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, 'أحمد محمد', NULL, '201023402756', 'abdo.king22227@gmail.com', 'القاهرة', 420.00, 'pending', 'شارع التحرير - الدور الثالث', 'cash', NULL, 0.00, '2025-12-25 11:54:24', '2025-12-25 11:54:24', NULL, 20.00, 0.00, 0.00, 'sa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 1, 'أحمد محمد', NULL, '201280739906', 'abdo.king22227@gmail.com', 'القاهرة', 420.00, 'canceled', 'شارع التحرير - الدور الثالث', 'cash', NULL, 0.00, '2025-12-25 11:55:33', '2025-12-30 16:36:13', NULL, 20.00, 0.00, 0.00, 'sa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 1, 'أحمد محمد', NULL, '201280739906', 'abdo.king22227@gmail.com', 'القاهرة', 420.00, 'pending', 'شارع التحرير - الدور الثالث', 'cash', NULL, 0.00, '2025-12-25 11:55:47', '2025-12-25 11:55:47', NULL, 20.00, 0.00, 0.00, 'sa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 2, 'test', NULL, '0231352', 'test@example.com', 'test', 1210.00, 'pending', 'test', 'cash', NULL, 0.00, '2025-12-25 12:04:04', '2025-12-25 12:04:04', NULL, 20.00, 0.00, 0.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 1, 'alahram-admin', NULL, '201023402756', 'alahram-admin@example.com', 'test', 220.00, 'pending', 'Abo Shath', 'cash', NULL, 0.00, '2025-12-25 12:55:10', '2025-12-25 12:55:10', NULL, 20.00, 0.00, 0.00, 'sa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 7, 'mohamed', NULL, '201023402756', 'eng0880@hotmail.com', 'test', 1210.00, 'pending', 'Abo Shath', 'cash', NULL, 0.00, '2025-12-29 11:28:24', '2025-12-29 11:28:24', NULL, 20.00, 0.00, 0.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 7, 'mohamed', NULL, '201023402756', 'abdo@abdo.com', 'test', 1210.00, 'pending', 'Abo Shath', 'cash', NULL, 0.00, '2025-12-29 11:33:59', '2025-12-29 11:33:59', NULL, 20.00, 0.00, 0.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 7, 'mohamed', NULL, '201023402756', 'empty@empty.com', 'test', 1210.00, 'pending', '6490 شارع ابراهيم بن النبي ,21955 مكة', 'cash', NULL, 0.00, '2025-12-29 11:35:29', '2025-12-29 11:35:29', NULL, 20.00, 0.00, 0.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 7, 'mohamed', NULL, '201023402756', 'empty@empty.com', 'test', 1210.00, 'pending', '6490 شارع ابراهيم بن النبي ,21955 مكة', 'cash', NULL, 0.00, '2025-12-29 11:36:04', '2025-12-29 11:36:04', NULL, 20.00, 0.00, 0.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 21, 'احمد', NULL, '201007152465', 'ahmed.m.boshy@gmail.com', 'test', 620.00, 'pending', '16المرحله السابعه ب-تمليك الاسماعيليه ثالث', 'cash', NULL, 0.00, '2025-12-29 19:25:57', '2025-12-29 19:25:57', NULL, 20.00, 0.00, 0.00, 'sa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 21, 'احمد', NULL, '201007152465', 'ahmed.m.boshy@gmail.com', 'test', 3590.00, 'pending', '16المرحله السابعه ب-تمليك الاسماعيليه ثالث', 'cash', NULL, 0.00, '2025-12-29 19:31:11', '2025-12-29 19:31:11', NULL, 20.00, 0.00, 0.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 23, 'JGIH', NULL, '201040701880', 'eiaahmed52@gmail.com', 'test', 882500.00, 'pending', 'JPIUILU\'IREUFG', 'cash', NULL, 0.00, '2026-01-06 20:41:17', '2026-01-06 20:41:17', NULL, 0.00, 0.00, 0.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 24, 'Doha', NULL, '201014040516', 'empty@empty.com', 'test', 540.00, 'pending', 'Ismail', 'cash', NULL, 0.00, '2026-01-06 23:50:20', '2026-01-06 23:50:20', NULL, 20.00, 0.00, 0.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 25, 'Mahmoud', NULL, '201021937864', 'empty@empty.com', 'test', 5080.00, 'pending', 'Ismail', 'cash', NULL, 0.00, '2026-01-07 13:09:11', '2026-01-07 13:09:11', NULL, 20.00, 0.00, 0.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 7, 'mohamed', NULL, '201023402756', 'abdo.king22227@gamil.com', 'test', 540.00, 'pending', 'Abo Shath', 'cash', NULL, 0.00, '2026-01-12 09:22:47', '2026-01-12 09:22:47', NULL, 20.00, 0.00, 0.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, NULL, 'أحمد محمد', NULL, '201019324725', 'customer@example.com', 'الإسماعيلية', 1144.00, 'pending', 'شارع الجمهورية، مبنى 12', 'vodafone_cash', NULL, 0.00, '2026-11-22 14:53:46', '2026-11-22 14:53:46', NULL, 0.00, 10.00, 104.00, 'eg', 'منطقة القناة', 'الإسماعيلية', 'حي الشيخ زايد', '201019324725', 30.5965000, 32.2715000, NULL, '2026-11-22 14:53:46', NULL),
(22, NULL, 'Brynn Stark', NULL, '+1 (295) 913-8976', 'tagebaku@mailinator.com', 'test', 572.00, 'pending', 'القاهرة, محافظة القاهرة, مصر', 'vodafone_cash', NULL, 0.00, '2026-11-22 15:10:29', '2026-11-22 15:10:29', NULL, 0.00, 10.00, 52.00, 'eg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-11-22 15:10:29', NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
(1, 1, 12, 1, 0.00, '2025-12-25 11:18:36', '2025-12-25 11:18:36'),
(2, 1, 1, 1, 0.00, '2025-12-25 11:18:36', '2025-12-25 11:18:36'),
(7, 4, 12, 1, 0.00, '2025-12-25 11:32:28', '2025-12-25 11:32:28'),
(8, 4, 1, 1, 0.00, '2025-12-25 11:32:28', '2025-12-25 11:32:28'),
(9, 5, 12, 1, 200.00, '2025-12-25 11:43:24', '2025-12-25 11:43:24'),
(10, 5, 1, 1, 200.00, '2025-12-25 11:43:24', '2025-12-25 11:43:24'),
(11, 6, 12, 1, 200.00, '2025-12-25 11:54:24', '2025-12-25 11:54:24'),
(12, 6, 1, 1, 200.00, '2025-12-25 11:54:24', '2025-12-25 11:54:24'),
(13, 7, 12, 1, 200.00, '2025-12-25 11:55:33', '2025-12-25 11:55:33'),
(14, 7, 1, 1, 200.00, '2025-12-25 11:55:33', '2025-12-25 11:55:33'),
(15, 8, 12, 1, 200.00, '2025-12-25 11:55:47', '2025-12-25 11:55:47'),
(16, 8, 1, 1, 200.00, '2025-12-25 11:55:47', '2025-12-25 11:55:47'),
(17, 9, 1, 1, 1190.00, '2025-12-25 12:04:04', '2025-12-25 12:04:04'),
(18, 10, 15, 1, 200.00, '2025-12-25 12:55:10', '2025-12-25 12:55:10'),
(19, 11, 1, 1, 1190.00, '2025-12-29 11:28:24', '2025-12-29 11:28:24'),
(20, 12, 1, 1, 1190.00, '2025-12-29 11:33:59', '2025-12-29 11:33:59'),
(21, 13, 1, 1, 1190.00, '2025-12-29 11:35:29', '2025-12-29 11:35:29'),
(22, 14, 1, 1, 1190.00, '2025-12-29 11:36:04', '2025-12-29 11:36:04'),
(23, 15, 1, 1, 200.00, '2025-12-29 19:25:57', '2025-12-29 19:25:57'),
(24, 15, 2, 1, 200.00, '2025-12-29 19:25:57', '2025-12-29 19:25:57'),
(25, 15, 14, 1, 200.00, '2025-12-29 19:25:57', '2025-12-29 19:25:57'),
(26, 16, 1, 3, 1190.00, '2025-12-29 19:31:11', '2025-12-29 19:31:11'),
(27, 17, 45, 1, 420000.00, '2026-01-06 20:41:17', '2026-01-06 20:41:17'),
(28, 17, 48, 1, 320000.00, '2026-01-06 20:41:17', '2026-01-06 20:41:17'),
(29, 17, 49, 1, 142500.00, '2026-01-06 20:41:17', '2026-01-06 20:41:17'),
(30, 18, 1, 1, 520.00, '2026-01-06 23:50:20', '2026-01-06 23:50:20'),
(31, 19, 1, 1, 520.00, '2026-01-07 13:09:11', '2026-01-07 13:09:11'),
(32, 19, 2, 2, 720.00, '2026-01-07 13:09:11', '2026-01-07 13:09:11'),
(33, 19, 12, 2, 650.00, '2026-01-07 13:09:11', '2026-01-07 13:09:11'),
(34, 19, 13, 1, 1800.00, '2026-01-07 13:09:11', '2026-01-07 13:09:11'),
(35, 20, 1, 1, 520.00, '2026-01-12 09:22:47', '2026-01-12 09:22:47'),
(36, 21, 1, 2, 520.00, '2026-11-22 14:53:46', '2026-11-22 14:53:46'),
(37, 22, 1, 1, 520.00, '2026-11-22 15:10:29', '2026-11-22 15:10:29');

-- --------------------------------------------------------

--
-- بنية الجدول `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `payments`
--

CREATE TABLE `payments` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `method` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `sender_phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `reviewed_by` bigint UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `payments`
--

INSERT INTO `payments` (`id`, `order_id`, `method`, `amount`, `sender_phone`, `reference_number`, `receipt_path`, `status`, `reviewed_by`, `reviewed_at`, `rejection_reason`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 21, 'vodafone_cash', 1144.00, '01012345678', NULL, 'receipts/172221f0-8267-4bd5-8e7f-ea87ae6c8d20.jpeg', 'pending', NULL, NULL, NULL, '2026-11-22 14:53:46', '2026-11-22 14:53:46', NULL),
(2, 22, 'vodafone_cash', 572.00, '+1 (252) 954-5123', '985', 'receipts/1b2808af-14af-4022-aefa-3cb23adccfea.jpeg', 'pending', NULL, NULL, NULL, '2026-11-22 15:10:29', '2026-11-22 15:10:29', NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `payments_legacy`
--

CREATE TABLE `payments_legacy` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `paymob_order_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_token` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `products` json NOT NULL,
  `coupon_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'users.view', 'web', '2026-11-17 12:41:31', '2026-11-17 12:41:31'),
(2, 'users.create', 'web', '2026-11-17 12:41:31', '2026-11-17 12:41:31'),
(3, 'users.update', 'web', '2026-11-17 12:41:31', '2026-11-17 12:41:31'),
(4, 'users.delete', 'web', '2026-11-17 12:41:31', '2026-11-17 12:41:31'),
(5, 'roles.view', 'web', '2026-11-17 12:41:31', '2026-11-17 12:41:31'),
(6, 'roles.manage', 'web', '2026-11-17 12:41:31', '2026-11-17 12:41:31'),
(7, 'users.assign_roles', 'web', '2026-11-17 12:47:22', '2026-11-17 12:47:22'),
(8, 'review-payments', 'web', '2026-11-18 09:28:53', '2026-11-18 09:28:53'),
(9, 'delete-financial-records', 'web', '2026-11-18 09:28:53', '2026-11-18 09:28:53'),
(10, 'products.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(11, 'products.create', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(12, 'products.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(13, 'products.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(14, 'product-types.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(15, 'product-types.create', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(16, 'product-types.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(17, 'product-types.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(18, 'product-reviews.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(19, 'product-reviews.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(20, 'categories.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(21, 'categories.create', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(22, 'categories.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(23, 'categories.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(24, 'brands.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(25, 'brands.create', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(26, 'brands.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(27, 'brands.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(28, 'banners.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(29, 'banners.create', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(30, 'banners.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(31, 'banners.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(32, 'offer-banners.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(33, 'offer-banners.create', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(34, 'offer-banners.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(35, 'offer-banners.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(36, 'testimonials.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(37, 'testimonials.create', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(38, 'testimonials.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(39, 'testimonials.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(40, 'services.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(41, 'services.create', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(42, 'services.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(43, 'services.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(44, 'discount-coupons.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(45, 'discount-coupons.create', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(46, 'discount-coupons.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(47, 'discount-coupons.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(48, 'content.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(49, 'content.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(50, 'settings.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(51, 'settings.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(52, 'delivery-areas.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(53, 'delivery-areas.create', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(54, 'delivery-areas.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(55, 'delivery-areas.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(56, 'iframes.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(57, 'iframes.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(58, 'notifications.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(59, 'contact-us.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(60, 'contact-us.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(61, 'whatsapp.send', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(62, 'mail.send', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(63, 'orders.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(64, 'orders.update', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(65, 'orders.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(66, 'payments.view', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(67, 'payments.approve', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(68, 'payments.reject', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(69, 'payments.delete', 'web', '2026-11-18 12:20:28', '2026-11-18 12:20:28'),
(70, 'permissions.view', 'web', '2026-11-18 12:28:10', '2026-11-18 12:28:10');

-- --------------------------------------------------------

--
-- بنية الجدول `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'api-token', '591ee188381b09763753eae325764087d34a07e17a9fa7aa7a2dd7a58d0f5e42', '[\"*\"]', '2025-12-10 13:40:59', NULL, '2025-12-10 12:06:40', '2025-12-10 13:40:59'),
(2, 'App\\Models\\User', 1, 'api-token', '49268a38c60c788b8af4e405a34d5e0535fcb29858067a32de32f445a3b48f99', '[\"*\"]', '2025-12-10 12:51:45', NULL, '2025-12-10 12:17:30', '2025-12-10 12:51:45'),
(3, 'App\\Models\\User', 1, 'api-token', 'f08f6b1ac8e7b45bc0bb2559cdc1426b1cb9e062e2b69bd03890f33165adbfc8', '[\"*\"]', '2025-12-10 13:54:06', NULL, '2025-12-10 12:51:51', '2025-12-10 13:54:06'),
(4, 'App\\Models\\User', 1, 'api-token', 'e0b735d12a8c7d64e805165f87308750ee5426669df835819e02bdb0f8f27723', '[\"*\"]', '2025-12-10 14:09:36', NULL, '2025-12-10 13:56:27', '2025-12-10 14:09:36'),
(5, 'App\\Models\\User', 1, 'api-token', '713feaf23c0e6a9c8d6b7ac10f7488e2bffa608a719e2f5befadaa782d309a30', '[\"*\"]', NULL, NULL, '2025-12-22 19:54:45', '2025-12-22 19:54:45'),
(6, 'App\\Models\\User', 1, 'api-token', '1d5c9a8dd8d717dc1098ac4192a9feea93b7a1cc2543e525d8681a2bd5b723a5', '[\"*\"]', '2025-12-30 17:32:13', NULL, '2025-12-22 19:55:08', '2025-12-30 17:32:13'),
(7, 'App\\Models\\User', 1, 'api-token', '08c932f569e7cd46d19e2b29b04d5d19b91eff5a5cfa8f918df5b9b12105a510', '[\"*\"]', '2025-12-24 11:29:40', NULL, '2025-12-24 09:08:06', '2025-12-24 11:29:40'),
(8, 'App\\Models\\User', 1, 'api-token', '7050844cc69f95e41afea73ca891a7621e82d1da81d7b1d59e065fef05986437', '[\"*\"]', '2025-12-24 10:42:28', NULL, '2025-12-24 09:26:59', '2025-12-24 10:42:28'),
(9, 'App\\Models\\User', 1, 'api-token', 'a35ea128c19a966482a39500f5ee5c78e885150ac862a627436b0965e18aa825', '[\"*\"]', '2025-12-24 11:21:56', NULL, '2025-12-24 10:42:28', '2025-12-24 11:21:56'),
(10, 'App\\Models\\User', 1, 'api-token', '9a1049103fad16d7881845d9424adaabfde7bf78ecab1f9e53ec10ad72597e41', '[\"*\"]', '2025-12-24 11:43:00', NULL, '2025-12-24 11:29:50', '2025-12-24 11:43:00'),
(11, 'App\\Models\\User', 1, 'api-token', 'b0182fd0b07a5d6a6fe306b54c8c0f3b4fce960309cfcd72b6c9c51392a180fd', '[\"*\"]', '2025-12-24 11:49:22', NULL, '2025-12-24 11:43:04', '2025-12-24 11:49:22'),
(12, 'App\\Models\\User', 1, 'api-token', '7fe19044cb2c98d926b2e933871d5ebd80d66bc707d6980a21786bada3dcc8b4', '[\"*\"]', NULL, NULL, '2025-12-24 11:50:11', '2025-12-24 11:50:11'),
(13, 'App\\Models\\User', 1, 'api-token', '138f0140090b44b95ece3ba081259951d612fde5a8f5198c244993f8cac49f45', '[\"*\"]', NULL, NULL, '2025-12-24 11:50:13', '2025-12-24 11:50:13'),
(14, 'App\\Models\\User', 1, 'api-token', 'c4fea51380ad12e22fd8375e5e24e34f5e6c4cf12a5ae8035fdf229e622f7b77', '[\"*\"]', '2025-12-24 11:55:01', NULL, '2025-12-24 11:51:44', '2025-12-24 11:55:01'),
(15, 'App\\Models\\User', 1, 'api-token', '3de92eaa22d9d048e61ebf67f1c38fd7b71bc4ece85251f1760deccbc0d7c5f9', '[\"*\"]', '2025-12-24 13:16:39', NULL, '2025-12-24 12:06:14', '2025-12-24 13:16:39'),
(16, 'App\\Models\\User', 1, 'api-token', 'edfc299f088695d53632090151d29e944ba15427f811348df7e00e59eec2c3a6', '[\"*\"]', '2025-12-24 12:41:50', NULL, '2025-12-24 12:25:21', '2025-12-24 12:41:50'),
(17, 'App\\Models\\User', 1, 'api-token', '536279db1f58bfb2e4112dd8d0d9ab86e4573115bdc969ab2765d9c4b1c8453a', '[\"*\"]', '2025-12-29 08:31:14', NULL, '2025-12-24 13:16:41', '2025-12-29 08:31:14'),
(18, 'App\\Models\\User', 1, 'api-token', '3504755b1d0a74a9b47f7789f703693d481f0aec3eee288d49f7f4e49c6981d5', '[\"*\"]', '2025-12-24 13:20:39', NULL, '2025-12-24 13:17:29', '2025-12-24 13:20:39'),
(19, 'App\\Models\\User', 1, 'api-token', 'f2bb9da6440ee0553557a284d72045f8cb7015432f5e4892e990242ae56d9b9f', '[\"*\"]', '2025-12-25 11:07:01', NULL, '2025-12-25 10:57:07', '2025-12-25 11:07:01'),
(20, 'App\\Models\\User', 2, 'api-token', 'b4b012fae6b80e3de7241ed4457173019f429162b85d98e497c30094c1f5c3ef', '[\"*\"]', NULL, NULL, '2025-12-25 12:03:42', '2025-12-25 12:03:42'),
(21, 'App\\Models\\User', 2, 'api-token', '706edcd8e6b55a42397e607cda9328880e3acc872d6f47e1d135aa8f208e5693', '[\"*\"]', NULL, NULL, '2025-12-25 12:03:50', '2025-12-25 12:03:50'),
(22, 'App\\Models\\User', 1, 'api-token', '502de4106298d20e93b446d98b7c99f2e7392cf289a8359c9351547ff7e88453', '[\"*\"]', NULL, NULL, '2025-12-25 12:54:50', '2025-12-25 12:54:50'),
(23, 'App\\Models\\User', 5, 'api-token', '5e8664d20f8fcbaad28634812bd3016fff4abc5d4b7930112035eac80786af8f', '[\"*\"]', NULL, NULL, '2025-12-28 13:29:25', '2025-12-28 13:29:25'),
(24, 'App\\Models\\User', 6, 'api-token', '52b0d01b55aad7737f6ed2ac19117e08ead5be32691f4f7031012745bfda831b', '[\"*\"]', NULL, NULL, '2025-12-28 13:59:55', '2025-12-28 13:59:55'),
(25, 'App\\Models\\User', 11, 'api-token', 'd8664e8dd3f02a3b25138e7071689a6100ba379924210c8c03bb49e92c68e79f', '[\"*\"]', NULL, NULL, '2025-12-28 15:18:01', '2025-12-28 15:18:01'),
(26, 'App\\Models\\User', 11, 'api-token', '3a9e127529b49525c6cf49e494bb8c294195f322f92f6f6413f77329ec410693', '[\"*\"]', NULL, NULL, '2025-12-28 15:22:32', '2025-12-28 15:22:32'),
(27, 'App\\Models\\User', 11, 'api-token', '9e85f990415d12d52b6eab10e4e8f253d03e36f9d49c491f51fa517d648852b1', '[\"*\"]', NULL, NULL, '2025-12-28 17:00:17', '2025-12-28 17:00:17'),
(28, 'App\\Models\\User', 1, 'api-token', '897ddefeff91ec24744708649cc458f760bf33b7fe4b5ef2c7ab9a5ff3c4548e', '[\"*\"]', '2026-01-05 10:52:45', NULL, '2025-12-29 08:31:15', '2026-01-05 10:52:45'),
(29, 'App\\Models\\User', 5, 'api-token', '85825b484bc5fb7440a0876707b4cb79cc8e2f45a3441af95995df8a4399f50c', '[\"*\"]', NULL, NULL, '2025-12-29 11:00:45', '2025-12-29 11:00:45'),
(30, 'App\\Models\\User', 5, 'api-token', '52819bea36bc58928b94e037bb83015574a3982026222b937161f94b2bed35d1', '[\"*\"]', '2025-12-29 11:17:49', NULL, '2025-12-29 11:14:29', '2025-12-29 11:17:49'),
(31, 'App\\Models\\User', 5, 'api-token', '23202099a2354da761936316240bbbe001d0b70fb234fdea0471a94452d050fb', '[\"*\"]', NULL, NULL, '2025-12-29 11:24:27', '2025-12-29 11:24:27'),
(32, 'App\\Models\\User', 7, 'api-token', 'a6eba94a745922cc5ba23fce44e2f52efccf1ca7c6bd6345218597a07538742a', '[\"*\"]', '2025-12-29 11:47:52', NULL, '2025-12-29 11:28:06', '2025-12-29 11:47:52'),
(33, 'App\\Models\\User', 5, 'api-token', '3676663df5a8a5e3a4e2eaaee0efca4d3348da26db5e7a23fcc41e2a327457ad', '[\"*\"]', '2025-12-29 11:54:28', NULL, '2025-12-29 11:40:08', '2025-12-29 11:54:28'),
(34, 'App\\Models\\User', 11, 'api-token', 'da3b84e5ad65382bd359d77020bfa5144f1cd2f0d90fed6d341a02070ef9875d', '[\"*\"]', NULL, NULL, '2025-12-29 12:39:29', '2025-12-29 12:39:29'),
(35, 'App\\Models\\User', 19, 'api-token', 'a54908f94169707e08180c47f738d4f8900f877916e22f96a9c785cac00331ac', '[\"*\"]', NULL, NULL, '2025-12-29 12:40:43', '2025-12-29 12:40:43'),
(36, 'App\\Models\\User', 5, 'api-token', '5286417d76f6f7d027ab98750656f92cf141e655fde5e40995a7cfc09ee0576f', '[\"*\"]', '2025-12-29 13:33:41', NULL, '2025-12-29 13:12:21', '2025-12-29 13:33:41'),
(37, 'App\\Models\\User', 11, 'api-token', '965deecba61e6b92c85a02cab4ada997e0e268effe1dada901035966d0f12bbb', '[\"*\"]', NULL, NULL, '2025-12-29 13:38:02', '2025-12-29 13:38:02'),
(38, 'App\\Models\\User', 11, 'api-token', 'd0fe4a6f34b36cccd999959f808bed77b65f04a64123d2841b972896544fc26d', '[\"*\"]', NULL, NULL, '2025-12-29 13:40:05', '2025-12-29 13:40:05'),
(39, 'App\\Models\\User', 21, 'api-token', '21b2deeed27fdcd475e0abb288b02b8dded876f25e7252f356f9c162ef62c3a1', '[\"*\"]', NULL, NULL, '2025-12-29 19:24:04', '2025-12-29 19:24:04'),
(40, 'App\\Models\\User', 5, 'api-token', '3243e16f65ffdc0ea0d58770cccaf11ef468bde5ced413b7227db1138bfa6db3', '[\"*\"]', '2025-12-30 08:48:36', NULL, '2025-12-30 08:48:29', '2025-12-30 08:48:36'),
(41, 'App\\Models\\User', 5, 'api-token', '02db26f6dcf9e1a3b037d84dff9091239f568e96e8c8f7a89c908a4b279ea127', '[\"*\"]', '2025-12-30 09:11:36', NULL, '2025-12-30 08:51:08', '2025-12-30 09:11:36'),
(42, 'App\\Models\\User', 11, 'api-token', '12498eade1b78fc584d861280764311a496994a447c93257b9c7df455cea41b1', '[\"*\"]', NULL, NULL, '2025-12-30 13:03:00', '2025-12-30 13:03:00'),
(43, 'App\\Models\\User', 1, 'api-token', '26a52caf1cd359761555d56ea02c7d29dd58ed46bb04d561c5c3381484050d8d', '[\"*\"]', '2026-01-02 12:31:41', NULL, '2025-12-30 14:49:15', '2026-01-02 12:31:41'),
(44, 'App\\Models\\User', 1, 'api-token', '4ef02d32da5e294a7a861305c4ff5a9ef1496c7c9c6c116ac8b3f3e385b87f5c', '[\"*\"]', '2025-12-30 18:11:41', NULL, '2025-12-30 15:08:02', '2025-12-30 18:11:41'),
(45, 'App\\Models\\User', 1, 'api-token', '2d107b5553402cfd4647ad0cd29de1b1e3e721c06b03fc25667a8718d01f4324', '[\"*\"]', NULL, NULL, '2025-12-30 17:33:24', '2025-12-30 17:33:24'),
(46, 'App\\Models\\User', 1, 'api-token', 'de7d6f377b021519d227d3dc8dac02914d027c7dfeb5e1ca72965146ebc71e1e', '[\"*\"]', '2026-01-06 18:46:34', NULL, '2025-12-30 17:33:34', '2026-01-06 18:46:34'),
(47, 'App\\Models\\User', 1, 'api-token', '057d2da2e1e6bd77fcb6adba5653a8001d876c7fbe58b12e30941f21d862380a', '[\"*\"]', '2026-01-03 16:54:19', NULL, '2026-01-02 12:31:43', '2026-01-03 16:54:19'),
(48, 'App\\Models\\User', 1, 'api-token', '3332329848eba1fcb6f72bdcff3cfc5d768dc8ee580279b71f34a29399962e2f', '[\"*\"]', '2026-01-04 17:21:09', NULL, '2026-01-03 16:54:22', '2026-01-04 17:21:09'),
(49, 'App\\Models\\User', 7, 'api-token', '62e89aa4c95227ff55d056f75384994075ce70e15b7f12314acea1f3c5e0db05', '[\"*\"]', NULL, NULL, '2026-01-04 09:33:30', '2026-01-04 09:33:30'),
(50, 'App\\Models\\User', 1, 'api-token', 'a3cc6a8ec806fac6e3ceca50c99863ac99ff2b985d7c7a041ab2dc32888a2f95', '[\"*\"]', '2026-01-05 10:26:10', NULL, '2026-01-04 17:21:11', '2026-01-05 10:26:10'),
(51, 'App\\Models\\User', 1, 'api-token', '7ae61f000390f5d230e56ab66cd36288c2688cd0e655703bc52a3237fc2a1f7f', '[\"*\"]', '2026-01-05 11:01:25', NULL, '2026-01-05 10:52:47', '2026-01-05 11:01:25'),
(52, 'App\\Models\\User', 1, 'api-token', '1c3d4cbfe87f3a755b3bc765c5139c91d30193d86845a2581b30ad806ee88550', '[\"*\"]', '2026-01-12 07:14:00', NULL, '2026-01-05 11:01:37', '2026-01-12 07:14:00'),
(53, 'App\\Models\\User', 1, 'api-token', 'efecdb7835129c0de9bc05a9d1724d6220fb4f809591f5f7c1b9ac05471f065f', '[\"*\"]', '2026-01-05 12:18:30', NULL, '2026-01-05 11:02:51', '2026-01-05 12:18:30'),
(54, 'App\\Models\\User', 1, 'api-token', '953af4f311fa44855495ade508b68dd527938d8b12eae0166878510f23f3a81a', '[\"*\"]', '2026-01-05 12:42:50', NULL, '2026-01-05 12:18:33', '2026-01-05 12:42:50'),
(55, 'App\\Models\\User', 1, 'api-token', '403e11c74a1928c938d2eac02bab344307935487713cc9fa4799e260f654b6db', '[\"*\"]', '2026-01-06 17:56:50', NULL, '2026-01-05 12:43:04', '2026-01-06 17:56:50'),
(56, 'App\\Models\\User', 1, 'api-token', '916a2d4f56a6b893f57c2f61fb36fea9be01a167d5d3eba357d091c3f9f3b2f8', '[\"*\"]', '2026-01-06 18:28:47', NULL, '2026-01-06 17:56:53', '2026-01-06 18:28:47'),
(57, 'App\\Models\\User', 1, 'api-token', 'f5085b1453e3cfd4db6a05feb8ce70af1e49ed983002c8e69fc6f0958d4c08cf', '[\"*\"]', '2026-01-06 20:15:30', NULL, '2026-01-06 18:29:25', '2026-01-06 20:15:30'),
(58, 'App\\Models\\User', 1, 'api-token', '2b67d8695215b9326ffa8dcfa5237e2f198fec3cc52b9251b140ad54db83a3fb', '[\"*\"]', '2026-01-11 18:36:32', NULL, '2026-01-06 18:46:35', '2026-01-11 18:36:32'),
(59, 'App\\Models\\User', 1, 'api-token', 'c8228ab0a849d77e08b7bb4e141fa68fe966304f63de2f72c9c571a9383fe69c', '[\"*\"]', '2026-01-07 16:34:58', NULL, '2026-01-06 20:15:33', '2026-01-07 16:34:58'),
(60, 'App\\Models\\User', 23, 'api-token', '2a6b5454d9a29505ceed14743baa7cda230c20eba134444d1073f176acaf7019', '[\"*\"]', NULL, NULL, '2026-01-06 20:39:29', '2026-01-06 20:39:29'),
(61, 'App\\Models\\User', 24, 'api-token', '19cbd6a1d684a74c95e49e19d78a4b8ee1ad77d8a5c8813850f3d18437b823e9', '[\"*\"]', NULL, NULL, '2026-01-06 23:49:34', '2026-01-06 23:49:34'),
(62, 'App\\Models\\User', 25, 'api-token', '6a5b1395635b7f4bcc18343ac540fc959ad0ac1eefb38fa6ec0298aa6e8af7e5', '[\"*\"]', NULL, NULL, '2026-01-07 13:08:40', '2026-01-07 13:08:40'),
(63, 'App\\Models\\User', 1, 'api-token', '884e5157c8fe9b76deb40a58b3a47efe03e5d88a05d8eb30a6f2604cd64b67da', '[\"*\"]', '2026-01-07 17:32:46', NULL, '2026-01-07 16:35:02', '2026-01-07 17:32:46'),
(64, 'App\\Models\\User', 1, 'api-token', 'e10ac8b22816a0786ed8db12547e4e6a3165e2201c17728a67a48551be772bd9', '[\"*\"]', '2026-01-10 15:10:44', NULL, '2026-01-10 14:15:39', '2026-01-10 15:10:44'),
(65, 'App\\Models\\User', 1, 'api-token', 'bb55a6e9026a2360f2e5e86fe896cbc87b805d3554d41c9b80a53ab4db673e51', '[\"*\"]', '2026-01-10 15:13:04', NULL, '2026-01-10 15:10:53', '2026-01-10 15:13:04'),
(66, 'App\\Models\\User', 1, 'api-token', '8866a42417764ed9db175eb7cb0c4822656d532016c8ec9482605939688c3b52', '[\"*\"]', '2026-01-11 18:32:30', NULL, '2026-01-10 15:13:21', '2026-01-11 18:32:30'),
(67, 'App\\Models\\User', 1, 'api-token', '9f41cd9f5580b5a27f7d4c5165c33a77b06e740f647e13fa9a7bc5b5b1d6557a', '[\"*\"]', '2026-02-01 06:40:09', NULL, '2026-01-11 18:32:32', '2026-02-01 06:40:09'),
(68, 'App\\Models\\User', 1, 'api-token', 'c74fc35936485bae496feaae7e420282a63c726d98251eb790c9adf961dc5f8c', '[\"*\"]', '2026-01-11 19:04:46', NULL, '2026-01-11 18:36:33', '2026-01-11 19:04:46'),
(69, 'App\\Models\\User', 1, 'api-token', '3471e5b6e158892af08404834a44000aef1f4016b79ab86f657aaae5c93fee3a', '[\"*\"]', '2026-01-12 07:22:57', NULL, '2026-01-12 07:13:41', '2026-01-12 07:22:57'),
(70, 'App\\Models\\User', 1, 'api-token', '17a7aa859312db71eb283a0a2ba41a4e592371f45f98924811768fcf10e24e1b', '[\"*\"]', '2026-01-12 09:22:00', NULL, '2026-01-12 07:14:02', '2026-01-12 09:22:00'),
(71, 'App\\Models\\User', 1, 'api-token', '155b9ef160dd188b39a71d2df3d18d54bfb875f0a485cee9c582fad0b7843bb9', '[\"*\"]', '2026-01-13 09:33:08', NULL, '2026-01-12 09:22:20', '2026-01-13 09:33:08'),
(72, 'App\\Models\\User', 7, 'api-token', '2ef33b6236061a11755ce10fb94c2958cb9540b9a4788431f74c3b014ac8eea9', '[\"*\"]', NULL, NULL, '2026-01-12 09:22:21', '2026-01-12 09:22:21'),
(73, 'App\\Models\\User', 1, 'api-token', '8a32fd81b4e34fff258d780853041fab175fdb2ca66518df970472bf69543a84', '[\"*\"]', '2026-01-21 09:01:05', NULL, '2026-01-12 09:24:48', '2026-01-21 09:01:05'),
(74, 'App\\Models\\User', 5, 'api-token', '9fb580cb1e84bec5a8de7201cc1ec3330fc55c6bff80baa9fa397086d8d9f7f8', '[\"*\"]', '2026-01-12 09:28:04', NULL, '2026-01-12 09:26:35', '2026-01-12 09:28:04'),
(75, 'App\\Models\\User', 1, 'api-token', '69b20e26ea63b708d6f85dfbfbecb11b885b56ba64a9e6ce55fe2ad6e70784da', '[\"*\"]', '2026-06-08 12:38:03', NULL, '2026-01-13 09:33:09', '2026-06-08 12:38:03'),
(76, 'App\\Models\\User', 27, 'api-token', '2472206b7b88e3fc8cda28ef1763dfe6a5dfd6e845a46bcddd860e111088377c', '[\"*\"]', NULL, NULL, '2026-01-21 04:24:21', '2026-01-21 04:24:21'),
(77, 'App\\Models\\User', 1, 'api-token', 'c1620c86e443b304cd8b9ea43377243bfb2326cce96b2650dc55378e8148a2ad', '[\"*\"]', '2026-05-18 13:10:37', NULL, '2026-01-21 09:01:06', '2026-05-18 13:10:37'),
(78, 'App\\Models\\User', 1, 'api-token', '9cb3727076608cbe3de0325d992f9496d8f0653aabfb73b5897a1182e1386df4', '[\"*\"]', '2026-02-01 08:08:36', NULL, '2026-02-01 06:40:14', '2026-02-01 08:08:36'),
(79, 'App\\Models\\User', 1, 'api-token', '1d43c7d58ec81e2864eaf382e7fac69e9f98897a724f65a5dafa0dafb2599e95', '[\"*\"]', '2026-02-17 08:49:18', NULL, '2026-02-17 08:31:57', '2026-02-17 08:49:18'),
(80, 'App\\Models\\User', 1, 'api-token', 'bdd9654a95b22664f86efdb62ad733f288ca31dfb5143289a2861f8c8260ecdd', '[\"*\"]', '2026-06-01 11:09:41', NULL, '2026-06-01 11:09:38', '2026-06-01 11:09:41'),
(81, 'App\\Models\\User', 1, 'api-token', 'cdafcc31225edd6535e74686076eac912d50cf45707a1c681c1d8c9879c543aa', '[\"*\"]', '2026-06-01 11:56:26', NULL, '2026-06-01 11:10:39', '2026-06-01 11:56:26'),
(82, 'App\\Models\\User', 1, 'api-token', '58fa0d47dbd6fb4f6fe636ba5abaede9d3d070869c5e11e99e6c7fced91751b3', '[\"*\"]', '2026-09-07 12:02:37', NULL, '2026-06-01 11:51:43', '2026-09-07 12:02:37'),
(83, 'App\\Models\\User', 1, 'api-token', 'd30bb0f6a64552e88e879524374d859e8eb69e195bd40cc5cfb1a9a319f4365a', '[\"*\"]', '2026-11-12 12:34:18', NULL, '2026-11-12 12:34:00', '2026-11-12 12:34:18'),
(84, 'App\\Models\\User', 1, 'api-token', '766e277d8e944191096291167e99230854b5f1a5055f9e44c2ff752f21dec19e', '[\"*\"]', '2026-11-15 10:46:31', NULL, '2026-11-12 12:36:09', '2026-11-15 10:46:31'),
(85, 'App\\Models\\User', 1, 'api-token', 'd1967dea9842d9e787272dbdab25b0bb36ae88795ba333eca65164308c8fa51d', '[\"*\"]', '2026-11-18 10:43:40', NULL, '2026-11-15 10:46:32', '2026-11-18 10:43:40'),
(86, 'App\\Models\\User', 1, 'api-token', '2c23c9f64eea0467a87a528f0d995265140161a583065adc1dedc617c7b2a35d', '[\"*\"]', '2026-11-17 11:30:56', NULL, '2026-11-17 09:44:10', '2026-11-17 11:30:56'),
(87, 'App\\Models\\User', 1, 'api-token', 'bb8f92e5e993216efdccfa2219d18ec8d91e6f55ce4e81f0802374043db413ae', '[\"*\"]', '2026-11-17 13:16:37', NULL, '2026-11-17 11:34:06', '2026-11-17 13:16:37'),
(88, 'App\\Models\\User', 1, 'api-token', '2a8f81752b6f9a2adc8e3a1e6a9465e5646023105c858f77e8a4c35bd1cc43a4', '[\"*\"]', '2026-11-18 07:50:19', NULL, '2026-11-17 13:25:58', '2026-11-18 07:50:19'),
(89, 'App\\Models\\User', 1, 'api-token', 'f38c33448f52b595547971725ccd751c6b243b219b1a475a6ee6d83120f8df2d', '[\"*\"]', '2026-11-18 09:04:43', NULL, '2026-11-18 07:54:33', '2026-11-18 09:04:43'),
(90, 'App\\Models\\User', 1, 'api-token', 'a33997d2fb3a47429675bf7ff0e18d69f338a4821430eb645f7ade9b91babb8a', '[\"*\"]', '2026-11-18 10:16:11', NULL, '2026-11-18 09:12:03', '2026-11-18 10:16:11'),
(91, 'App\\Models\\User', 1, 'api-token', 'ee149fb2cf725a3413cb32dce4e24674f6aae14e2b3f01e3a84e4dc641476221', '[\"*\"]', '2026-11-18 11:21:45', NULL, '2026-11-18 10:16:31', '2026-11-18 11:21:45'),
(92, 'App\\Models\\User', 1, 'api-token', 'e0f84ed16c3ee41bb9799e301b203c92f96b2bd10cf43531c18ce91b1d0abbf6', '[\"*\"]', '2026-11-19 10:56:50', NULL, '2026-11-18 10:34:16', '2026-11-19 10:56:50'),
(93, 'App\\Models\\User', 1, 'api-token', 'a2f2d0b47f9da623b92ad43c20727e2125be8ad5361fff4ae8c514e91834c722', '[\"*\"]', '2026-11-19 12:18:37', NULL, '2026-11-18 10:35:35', '2026-11-19 12:18:37'),
(94, 'App\\Models\\User', 1, 'api-token', '97627754e10a1bb18bf0fd032048de8b98b98eaa150a2654df014476553a3659', '[\"*\"]', '2026-11-19 12:22:14', NULL, '2026-11-18 10:43:42', '2026-11-19 12:22:14'),
(95, 'App\\Models\\User', 1, 'api-token', 'd7e0cf037359d7880e359d832dc7ecb0d6e17fe6a14ee1ce1491f7654515ca50', '[\"*\"]', '2026-11-18 12:28:52', NULL, '2026-11-18 11:24:28', '2026-11-18 12:28:52'),
(96, 'App\\Models\\User', 1, 'api-token', 'ff2b78cf67d594182e322225fc06496768794c9d1cf9ef38939d1e5f97717308', '[\"*\"]', '2026-11-18 13:30:56', NULL, '2026-11-18 12:30:05', '2026-11-18 13:30:56'),
(97, 'App\\Models\\User', 1, 'api-token', 'f129eef0bb77d4335b8109ee3c9b3ef3b2b015e2cf351b80ebc2ad58a607449d', '[\"*\"]', NULL, NULL, '2026-11-18 12:35:17', '2026-11-18 12:35:17'),
(98, 'App\\Models\\User', 1, 'api-token', '587af3adcf71c4891b51a882d321fa58b7b85031dc99dd6378a2dae7299fac2e', '[\"*\"]', NULL, NULL, '2026-11-18 13:23:42', '2026-11-18 13:23:42'),
(99, 'App\\Models\\User', 1, 'api-token', '604b75339678715f6d6ead4fb3e4970b641bd8e037e943c0c76cda15a640a8e9', '[\"*\"]', '2026-11-19 10:37:02', NULL, '2026-11-18 13:39:45', '2026-11-19 10:37:02'),
(100, 'App\\Models\\User', 1, 'api-token', 'd27db029c63c5ddcbea25fb701119127c7976de675393a2fae9386ec53288f8a', '[\"*\"]', '2026-11-19 11:41:47', NULL, '2026-11-19 10:39:45', '2026-11-19 11:41:47'),
(101, 'App\\Models\\User', 1, 'api-token', '9a048c2ebd81d5debc0c6cfe7c7fc48df504933ba64eec13ac988903953ef221', '[\"*\"]', NULL, NULL, '2026-11-19 10:44:27', '2026-11-19 10:44:27'),
(102, 'App\\Models\\User', 1, 'api-token', '203f52ba3cda0ab9181edac9e428635c1bd93f659e3bf9f408feec6efc33394d', '[\"*\"]', '2026-11-19 12:13:14', NULL, '2026-11-19 11:42:37', '2026-11-19 12:13:14'),
(103, 'App\\Models\\User', 1, 'api-token', 'd4860835e0ce582bf87b9bfc7bb307f8e43c9824d51848d7650a488eeb9b8bc2', '[\"*\"]', '2026-11-19 12:20:05', NULL, '2026-11-19 12:19:07', '2026-11-19 12:20:05'),
(104, 'App\\Models\\User', 1, 'api-token', '0e19d0d0942db95bd93ea077304475dff7a1795b75f4cbe84e1a15550175ac39', '[\"*\"]', '2026-11-19 12:26:42', NULL, '2026-11-19 12:20:26', '2026-11-19 12:26:42'),
(105, 'App\\Models\\User', 1, 'api-token', 'f82f4f7b7fda76147a187e7defed599c7bc52dd900f2a4e54f1d6312df87b967', '[\"*\"]', '2026-11-21 01:05:58', NULL, '2026-11-19 12:23:10', '2026-11-21 01:05:58'),
(106, 'App\\Models\\User', 1, 'api-token', '4aef8dd0620af0667378a9de1b04099efb9f3b529802baced43aea60609e59f0', '[\"*\"]', '2026-11-21 14:17:52', NULL, '2026-11-19 21:38:02', '2026-11-21 14:17:52'),
(107, 'App\\Models\\User', 1, 'api-token', 'f55322b9f48f1cab1610a3c0cadcb3237c9ba24bb35b13bd11077d91d436ef7d', '[\"*\"]', '2026-11-19 21:39:49', NULL, '2026-11-19 21:38:13', '2026-11-19 21:39:49'),
(108, 'App\\Models\\User', 1, 'api-token', 'e41e323f9045c39369968630c3c4b07fc4d8bf9b42bd3a8c8c47d3d8596d7306', '[\"*\"]', '2026-11-22 11:51:39', NULL, '2026-11-22 11:41:08', '2026-11-22 11:51:39'),
(109, 'App\\Models\\User', 1, 'api-token', 'a05a9657808a322ec71ecf036bf0d3821713d60352b56589c9c46be1f3cdf8da', '[\"*\"]', '2026-11-22 14:00:28', NULL, '2026-11-22 13:47:23', '2026-11-22 14:00:28'),
(110, 'App\\Models\\User', 1, 'api-token', '02decdac94ae2363a8b4c2311bee143c97bc84bd55dab0f3d25c2b032e478492', '[\"*\"]', '2026-11-22 14:41:01', NULL, '2026-11-22 14:00:50', '2026-11-22 14:41:01'),
(111, 'App\\Models\\User', 1, 'api-token', 'da2a98c6d685d68127f1ac9d331e9431d421490d86e769fffd4d94e61cc95451', '[\"*\"]', NULL, NULL, '2026-11-22 14:52:55', '2026-11-22 14:52:55');

-- --------------------------------------------------------

--
-- بنية الجدول `privacy_policy`
--

CREATE TABLE `privacy_policy` (
  `id` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `privacy_policy`
--

INSERT INTO `privacy_policy` (`id`, `description`, `description_en`, `created_at`, `updated_at`) VALUES
(1, '1', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `images` json DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_eg` decimal(10,2) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `discount` int DEFAULT NULL,
  `specs` json DEFAULT NULL,
  `brand_id` bigint UNSIGNED DEFAULT NULL,
  `type_id` bigint UNSIGNED DEFAULT NULL,
  `quantity` int NOT NULL,
  `isFeatured` tinyint(1) NOT NULL DEFAULT '0',
  `discount_end_date` date DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT NULL,
  `seo_keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `price_ar` decimal(10,2) DEFAULT NULL,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `youtube_video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `products`
--

INSERT INTO `products` (`id`, `category_id`, `images`, `img`, `name`, `code`, `price_eg`, `description`, `discount`, `specs`, `brand_id`, `type_id`, `quantity`, `isFeatured`, `discount_end_date`, `rating`, `seo_keywords`, `seo_description`, `created_at`, `updated_at`, `price_ar`, `name_en`, `description_en`, `youtube_video_url`) VALUES
(1, 1, '[\"products/a1cd9ead-4228-45be-a10f-fd7ff135e6f8.webp\"]', 'products/d8b2fbc4-87da-419f-bcb3-f8478d6ae801.webp', 'RT YELLOW OXIDE', 'RT_001', 520.00, '<p>YELLOW OXIDE</p>', NULL, '[[{\"Color\": \"Yellow oxide\"}, {\"liter\": \"1 liter\"}]]', NULL, 1, 50, 0, NULL, NULL, 'null', 'null', '2025-12-10 13:40:59', '2026-11-18 12:52:46', 38.00, 'RT YELLOW OXIDE', '<p>YELLOW OXIDE</p>', NULL),
(2, 1, '[\"products/f156eed3-1ea3-4b24-80e4-30230abf56c3.webp\"]', 'products/5f930cdc-6d29-473d-8afa-7d45449d0670.webp', 'FT VILET', 'FT_002', 720.00, '<p>VILET</p>', NULL, '[[{\"color\": \"vilet\"}, {\"liter\": \"1 liter\"}]]', NULL, 1, 50, 0, NULL, NULL, 'null', 'null', '2025-12-10 13:40:59', '2026-11-18 12:52:47', 44.00, 'FT VILET', '<p>VILET</p>', NULL),
(12, 1, '[\"products/58598f85-d34d-43b4-a4b6-08b008682126.webp\"]', 'products/b48a06d1-fd4e-40b8-9b72-7b8b659de958.webp', 'MT LIGHT BLUE', 'MT_003', 650.00, '<p>LIGHT BLUE</p>', NULL, '[[{\"key\": \"color\", \"value\": \"red\"}, {\"key\": \"size\", \"value\": \"M\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2025-12-10 13:40:59', '2026-11-18 12:52:48', 38.00, 'MT LIGHT BLUE', '<p>LIGHT BLUE</p>', NULL),
(13, 1, '[\"products/b483c982-df00-40d9-9714-ca0a6203337f.webp\"]', 'products/9ad017ec-4f7d-4814-ba01-2a33ea2ca65f.webp', 'PT ORANGE RED', 'PT_004', 1800.00, '<p>ORANGE RED</p>', NULL, '[[{\"key\": \"color\", \"value\": \"red\"}, {\"key\": \"size\", \"value\": \"M\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2025-12-10 13:40:59', '2026-11-18 12:52:48', 129.00, 'PT ORANGE RED', '<p>ORANGE RED</p>', NULL),
(14, 1, '[\"products/35102973-1693-4aa8-a5c2-6ff9bdee7e99.webp\"]', 'products/3e73616a-9ec4-430e-88a8-31d1fd73057d.webp', 'RS RED', 'RS_005', 950.00, '<p>RED</p>', NULL, '[[{\"key\": \"color\", \"value\": \"red\"}, {\"key\": \"size\", \"value\": \"M\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2025-12-10 13:40:59', '2026-11-18 12:52:49', 61.00, 'RS RED', '<p>RED</p>', NULL),
(15, 1, '[\"products/9608b974-702c-4e22-9dab-0fde3bbfca51.webp\"]', 'products/f8cf1d2f-c111-4685-9a7d-e633dc7f5e1b.webp', 'HS BORDEAUX', 'HS_006', 1500.00, '<p>BORDEAUX</p>', NULL, '[[{\"key\": \"color\", \"value\": \"red\"}, {\"key\": \"size\", \"value\": \"M\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2025-12-10 13:40:59', '2026-11-18 12:52:50', 105.00, 'HS BORDEAUX', '<p>BORDEAUX</p>', NULL),
(18, 1, '[\"products/d5525a3e-9588-44a2-8f9d-b64203d06785.webp\"]', 'products/5500f611-eeac-4710-bb81-94e670ca35af.webp', 'ST UMBER', 'ST_007', 500.00, '<p>UMBER</p>', NULL, '[[{\"COLOR\": \"BROWN\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 11:33:05', '2026-11-18 12:52:50', 34.00, 'ST UMBER', '<p>UMBER</p>', NULL),
(19, 1, '[\"products/64f8e214-56b0-42e8-9b82-b6342ebd2f2a.webp\"]', 'products/d1826eef-4d31-4c7a-bd5d-970c4d12f280.webp', 'KS YELLOW', 'KS_008', 950.00, '<p>YELLOW</p>', NULL, '[[{\"COLOR\": \"YELLOW\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 11:36:47', '2026-11-18 12:52:51', 56.00, 'KS YELLOW', '<p>YELLOW</p>', NULL),
(20, 1, '[\"products/27f2b60a-e350-4e06-84a5-fa57f59eacbb.webp\"]', 'products/18068e5f-fe92-4cf7-8fe8-0554ee76dfcd.webp', 'US ORANGE YELLOW', 'US_009', 1700.00, '<p>ORANGE YELLOW</p>', NULL, '[[{\"COLOR\": \"YELLOW\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 11:38:47', '2026-11-18 12:52:52', 106.00, 'US ORANGE YELLOW', '<p>ORANGE YELLOW</p>', NULL),
(21, 1, '[\"products/d0dbf470-b622-4dab-8474-6869f320da33.webp\"]', 'products/a2c25c4c-253c-4606-b877-0154c8e4fd0d.webp', 'LS  DARK GREEN', 'LS_010', 900.00, '<p>DARK GREEN</p>', NULL, '[[{\"COLOR\": \"GREEN\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 11:40:21', '2026-11-18 12:52:52', 55.00, 'LS DARK GREEN', '<p>DARK GREEN</p>', NULL),
(22, 1, '[\"products/0f5fb620-fd97-48b8-a25b-3c43a069c182.webp\"]', 'products/b6539969-8963-44ae-ab72-ab72e48e61d7.webp', 'VT RED OXIDE', 'VT_011', 640.00, '<p> RED OXIDE</p>', NULL, '[[{\"COLOR\": \"RED\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 11:42:54', '2026-11-18 12:52:53', 40.00, 'VT RED OXIDE', '<p>RED OXIDE</p>', NULL),
(23, 1, '[\"products/7fae4731-8e85-4e17-823f-6efe489d35f7.webp\"]', 'products/5fe5022b-19cb-4fbf-99cd-613a2495cf17.webp', 'LT LIGHT GREN', 'LT _012', 740.00, '<p>LIGHT GREN</p>', NULL, '[[{\"COLOR\": \"GREEN\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 11:46:06', '2026-11-18 12:52:54', 46.00, 'LT LIGHT GREN', '<p>LIGHT GREEN</p>', NULL),
(24, 1, '[\"products/413b6775-c91d-489d-8a01-68ae0f9f4ec8.webp\"]', 'products/0a5b33e3-9529-401e-8b8b-617dcf28e966.webp', 'ZT CITRON YELLOW', 'ZT_013', 1250.00, '<p>CITRON YELLOW</p>', NULL, '[[{\"COLOR\": \"YELLOW\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 11:48:09', '2026-11-18 12:52:54', 86.00, 'ZT CITRON YELLOW', '<p>CITRON YELLOW</p>', NULL),
(25, 1, '[\"products/9dde1900-3f12-413a-8831-41d35373d7f1.webp\"]', 'products/4dca8476-bc0d-44d8-9f29-a0f0a95d1704.webp', 'MS DARK BLUE', 'MS_014', 850.00, '<p>DARK BLUE</p>', NULL, '[[{\"COLOR\": \"BLUE\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 11:50:07', '2026-11-18 12:52:55', 57.00, 'MS DARK BLUE', '<p>DARK BLUE</p>', NULL),
(26, 1, '[\"products/ae451240-9688-481a-b58f-29dcfc0cd70f.webp\"]', 'products/8a7ff59c-de8f-416b-8b9a-49334edb77ca.webp', 'XT WHITE', 'XT_015', 750.00, '<p>WHITE</p>', NULL, '[[{\"COLOR\": \"WHITE\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 11:51:40', '2026-11-18 12:52:56', 50.00, 'XT WHITE', '<p>WHITE</p>', NULL),
(27, 1, '[\"products/730d49a4-60d7-46d7-8a01-e24f682c56be.webp\"]', 'products/74b2e930-1e44-4a59-b4c3-5e480a3d054a.webp', 'TT BLACK', 'TT_016', 470.00, '<p>BLACK</p>', NULL, '[[{\"COLOR\": \"BLACK\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 11:53:07', '2026-11-18 12:52:56', 27.00, 'TT BLACK', '<p>BLACK</p>', NULL),
(29, 2, '[\"products/9b0171f4-950d-4e53-98b3-22e2ba1c0ca4.webp\"]', 'products/f17fd29c-5f65-4540-9b0b-e056271c6037.webp', 'RT YELLOW VIBRANTZ', 'RT0_017', 615.00, '<p>RT YELLOW VIBRANTZ</p>', NULL, '[[{\"COLOR\": \"YELLOW\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 12:52:06', '2026-11-18 12:52:57', 38.00, 'RT YELLOW VIBRANTZ', '<p>RT YELLOW VIBRANTZ</p>', NULL),
(30, 2, '[\"products/2112827a-048d-4551-9dd7-8042616b54fe.webp\"]', 'products/c0bc3114-ab4e-4de1-8830-3b28bdf95d1e.webp', 'MT LIGHT BLUE', 'MT_018', 740.00, '<p>MT LIGHT BLUE</p>', NULL, '[[{\"COLOR \": \"BLUE\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:00:59', '2026-11-18 12:52:58', 38.00, 'MT LIGHT BLUE', '<p>MT LIGHT BLUE</p>', NULL),
(31, 2, '[\"products/c2da54a6-520a-45f9-8600-aecc00ce0bd9.webp\"]', 'products/dfb7021e-b565-4c85-acb9-57b5555935c5.webp', 'FT VILET', 'FT_018', 860.00, '<p>FT VILET</p>', NULL, '[[{\"COLOR\": \"PURBLE\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:03:53', '2026-11-18 12:52:58', 44.00, 'FT VILET', '<p>FT VILET</p>', NULL),
(32, 2, '[\"products/458ebd9e-f48f-4a90-9d0e-cb85ad854528.webp\"]', 'products/a60e2f38-a01f-4303-963a-c298a691c14b.webp', 'PT ORANGE RED', 'PT_019', 2700.00, '<p>PT ORANGE RED</p>', NULL, '[[{\"COLOR\": \"RED\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:06:42', '2026-11-18 12:52:59', 129.00, 'PT ORANGE RED', '<p>PT ORANGE RED</p>', NULL),
(33, 2, '[\"products/965ab2f2-aa2e-441c-b233-1cc42cac489f.webp\"]', 'products/79b4e5b1-aa58-4a15-b7aa-fa8998d0af49.webp', 'HS BORDEAUX', 'HS_020', 1500.00, '<p>HS BORDEAUX</p>', NULL, '[[{\"COLOR\": \"BURGANDY\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:09:40', '2026-11-18 12:53:00', 105.00, 'HS BORDEAUX', '<p>HS BORDEAUX</p>', NULL),
(34, 2, '[\"products/f1e6925f-58a4-40f7-8889-e139fa82de10.webp\"]', 'products/510affef-9215-412d-8d9a-d9e41dbd1fab.webp', 'RS RED', 'RS_021', 1250.00, '<p>RS RED</p>', NULL, '[[{\"COLOR\": \"RED\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:11:35', '2026-11-18 12:53:01', 61.00, 'RS RED', '<p>RS RED</p>', NULL),
(35, 2, '[\"products/5ee33a3e-59b7-4721-899b-920aa8dc86b5.webp\"]', 'products/6c4d8024-7c4b-4a36-ac3c-6fc0113e3fe5.webp', 'KS YELLOW', 'KS_022', 1200.00, '<p>KS YELLOW</p>', NULL, '[[{\"COLOR\": \"YELLOW\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:13:20', '2026-11-18 12:53:02', 56.00, 'KS YELLOW', '<p>KS YELLOW</p>', NULL),
(36, 2, '[\"products/2b01f38c-9d54-4490-9412-ec051903ae29.webp\"]', 'products/9ea07518-554e-4b5d-a97c-ccd97594d2b8.webp', 'ST UMBER', 'ST_023', 580.00, '<p>ST UMBER</p>', NULL, '[[{\"COLOR\": \"BROWN\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:15:32', '2026-11-18 12:53:03', 34.00, 'ST UMBER', '<p>ST UMBER</p>', NULL),
(37, 2, '[\"products/1e798770-f9f5-46d5-843e-95014aa9a664.webp\"]', 'products/bbd75f34-0ddf-4440-a5ad-0fbb6303afc3.webp', 'LS DARK GREEN', 'LS_024', 1150.00, '<p>LS DARK GREEN</p>', NULL, '[[{\"COLOR\": \"GREEN\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:18:14', '2026-11-18 12:53:04', 55.00, 'LS DARK GREEN', '<p>LS DARK GREEN</p>', NULL),
(38, 2, '[\"products/aa357f7f-957e-4f35-a495-a1f604608115.webp\"]', 'products/a810db41-2361-4fed-97e9-3633b341429e.webp', 'US ORANGE YELLOW', 'US_025', 2100.00, '<p>US ORANGE YELLOW</p>', NULL, '[[{\"COLOR\": \"ORANGE\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:20:04', '2026-11-18 12:53:05', 106.00, 'US ORANGE YELLOW', '<p>US ORANGE YELLOW</p>', NULL),
(39, 2, '[\"products/00165aad-a3b8-4f9f-9f89-b28b8e172a98.webp\"]', 'products/de1c6503-7c76-4d52-bf37-e3d2396acc4a.webp', 'LT LIGHT GREEN', 'LT_026', 930.00, '<p>LT LIGHT GREEN</p>', NULL, '[[{\"COLOR\": \"GREEN\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:21:55', '2026-11-18 12:53:06', 46.00, 'LT LIGHT GREEN', '<p>LT LIGHT GREEN</p>', NULL),
(40, 2, '[\"products/3077c82c-abcd-44a7-a9cc-0a15c42a86d6.webp\"]', 'products/f96c0a43-3597-490c-b5af-0d4a40b1a2bd.webp', 'VT RED OXIDE', 'VT_027', 715.00, '<p>VT RED OXIDE</p>', NULL, '[[{\"COLOR \": \"RED\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:24:12', '2026-11-18 12:53:07', 40.00, 'VT RED OXIDE', '<p>VT RED OXIDE</p>', NULL),
(41, 2, '[\"products/2e257a49-c8ca-4893-9cda-7965b085665f.webp\"]', 'products/4b975efc-37fd-4e54-90d7-83340b1bf507.webp', 'MS DARK BLUE', 'MS_027', 1180.00, '<p>MS DARK BLUE</p>', NULL, '[[{\"COLOR\": \"BLUE\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:26:14', '2026-11-18 12:53:07', 57.00, 'MS DARK BLUE', '<p>MS DARK BLUE</p>', NULL),
(42, 2, '[\"products/7fd511a2-4b0e-4343-8da7-03a102f28491.webp\"]', 'products/6b9b31c6-8e3f-40ab-96fa-59d3978f6841.webp', 'ZT CITRON YELLOW', 'ZT_029', 1675.00, '<p>ZT CITRON YELLOW</p>', NULL, '[[{\"COLOR\": \"GREEN\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:28:21', '2026-11-18 12:53:08', 86.00, 'ZT CITRON YELLOW', '<p>ZT CITRON YELLOW</p>', NULL),
(43, 2, '[\"products/ab1c5b5f-543e-4a29-ace4-ffc0b6b71324.webp\"]', 'products/88d441ca-8a85-4e7f-b445-b48c6b26063b.webp', 'TT BLACK', 'TT_013', 550.00, '<p>TT BLACK</p>', NULL, '[[{\"COLOR\": \"BLACK\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:30:06', '2026-11-18 12:53:09', 27.00, 'TT BLACK', '<p>TT BLACK</p>', NULL),
(44, 2, '[\"products/59ef9395-51cc-4e25-b07a-3fcdaccad147.webp\"]', 'products/2af3d7db-7a31-4da4-b658-a111e3f8a602.webp', 'XT WHITE', 'XT_028', 860.00, '<p>XT WHITE</p>', NULL, '[[{\"COLOR\": \"WHITE\"}, {\"LITRE\": \"1L\"}]]', NULL, NULL, 50, 0, NULL, NULL, 'null', 'null', '2026-01-05 13:32:02', '2026-11-18 12:53:10', 50.00, 'XT WHITE', '<p>XT WHITE</p>', NULL),
(45, 3, '[\"products/0da88a0c-32fe-4bd6-acd3-08bab04257d6.webp\"]', 'products/6c2d1993-fc73-484e-a853-d67756518f85.webp', 'EVO1ST', 'D2026_10001', 420000.00, '<p>COROB EVO1ST Paint Dispenser budget-friendly price</p>', NULL, '[[]]', NULL, NULL, 5, 0, NULL, NULL, 'null', 'null', '2026-01-06 18:28:22', '2026-11-18 12:53:11', 35100.00, 'EVO1ST', '<p>COROB EVO1ST Paint Dispenser budget-friendly price</p>', NULL),
(48, 3, '[\"products/47c5ec27-3b32-4c88-8b4d-b78bd57fce79.webp\"]', 'products/d00de11c-f5ae-41e7-b82d-1fb419bd1489.webp', 'EVO-D180', 'D2026_10002', 320000.00, '<p>ماكينة تلوين دهانات بالكمبيوتر اوتماتيك</p>', NULL, '[[]]', NULL, NULL, 5, 0, NULL, NULL, NULL, NULL, '2026-01-06 18:57:16', '2026-11-18 12:53:11', 30000.00, 'EVO-D180', '<p>Step up your business with affordable professional dispensing</p>', NULL),
(49, 3, '[\"products/56d64bc2-bb2b-4643-a1c6-2eec3961972d.webp\", \"products/98e2cd0f-f7b8-415f-97b0-0067ab882d01.webp\"]', 'products/4e845b9f-c72b-44c2-a0f5-da3821ea7ab1.webp', 'EVO FIRST1-TX', 'D2026_10003', 142500.00, '<p>The perfect entry point into tinting</p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, NULL, NULL, '2026-01-06 19:06:27', '2026-11-18 12:53:12', 13500.00, 'EVO FIRST1-TX', '<p>The perfect entry point into tinting</p>', NULL),
(50, 4, '[\"products/4003336f-1eed-4569-8bff-d06c6ee9e28b.webp\"]', 'products/6e4320bc-49b9-494b-b88f-988533c50c0f.webp', 'شيكر هزاز سيمبل شيك 30', 'D2026_20001', 50000.00, '<p>ماكينة تقليب للدهانات بالاهتزاز </p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, NULL, NULL, '2026-01-06 19:26:47', '2026-11-18 12:53:13', 7000.00, 'SIMLE SHAKE 30', '<p>Machine to SHACK PAINTS </p>', NULL),
(51, 4, '[\"products/96b2e910-1621-443c-8ee9-3d5fd8f497c8.webp\"]', 'products/13a7c93a-47cb-487d-a13e-5bc4bec5a074.webp', 'شيكر هزاز انترالين', 'D2026_20002', 50000.00, '<p>ماكينة تقليب للدهانات بالاهتزاز </p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, NULL, NULL, '2026-01-06 19:29:30', '2026-11-18 12:53:14', 7000.00, 'SHAKER INTERLINE', '<p>Machine to SHACK PAINTS </p>', NULL),
(52, 4, '[\"products/98701b10-0aa1-4b9a-af6a-baa6a21bda07.webp\"]', 'products/7d63dd56-6fe5-4d72-9314-b8046330c648.webp', 'شيكر اس 5', 'D2026_20003', 50000.00, '<p>ماكينة تقليب للدهانات بالاهتزاز </p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, NULL, NULL, '2026-01-06 19:31:36', '2026-11-18 12:53:14', 7000.00, 'SHAKER SANTINT S5', '<p>Machine to SHACK PAINTS </p>', NULL),
(53, 4, '[\"products/af371eaa-21e4-4534-b266-2a22a5cf72e0.webp\"]', 'products/563368b8-7783-45ed-8f83-74220abb3a45.webp', 'ميكسر سانتينت جي 5', 'D2026_20004', 50000.00, '<p>ماكينة تقليب للدهانات بالتقليب</p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, 'null', 'null', '2026-01-06 19:34:00', '2026-11-18 12:53:15', 8000.00, 'MIXER SANTINT G5', '<p>Machine to MIX PAINTS</p>', NULL),
(54, 4, '[\"products/8ba8b588-1b80-4d71-8fd5-f16d452e359a.webp\"]', 'products/2a47dbb9-e761-4e7a-9fda-4ae9974bb6ef.webp', 'ميكسر انترالين', 'D2026_10005', 50000.00, '<p>ماكينه خلط دهانات</p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, NULL, NULL, '2026-01-06 19:38:02', '2026-11-18 12:53:16', 6999.99, 'mixer interline', '<p>machine to mix paints</p>', NULL),
(55, 4, '[\"products/84bcfd86-bc11-4397-b7f5-4b6d2ca3f5cf.webp\"]', 'products/5f97bc40-2352-4c51-bed8-61c241ed7647.webp', 'شيكر سانتينت', 'D2026_10006', 50000.00, '<p>ماكينه خلط دهانات</p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, NULL, NULL, '2026-01-06 19:40:53', '2026-11-18 12:53:16', 6999.99, 'shaker santint', '<p>machine to shake paints</p>', NULL),
(56, 4, '[\"products/20640d20-38a8-444e-af00-cd83782d8756.webp\", \"products/3cd1abd4-b915-46a2-b4a7-2653e64c10a6.webp\", \"products/67ca13ba-33fc-4723-b03a-de1e5e5d2601.webp\"]', 'products/1767728716_31.jpg', 'ماكينه كوروب بانكو', 'D2026_10007', 159999.97, '<p>ماكينه خلط دهانات</p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, 'null', 'null', '2026-01-06 19:45:16', '2026-11-18 12:53:17', 15000.00, 'corob banco', '<p>dispenser machine</p>', NULL),
(57, 4, '[\"products/c4d4215f-33dd-445f-bfbb-8f7f5937ef24.webp\", \"products/823b6f4f-870b-41be-9c1a-236e34d24b0b.webp\", \"products/d5eef457-18b1-466d-a2d8-b6e0f87fe6ca.webp\"]', 'products/6e22266e-cf7a-4ea1-be83-daa4067645d3.webp', 'سانتينت A1', 'D2026_10008', 80000.00, '<p>ماكينه خلط الدهانات بالكمبيوتر</p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, 'null', 'null', '2026-01-06 19:51:38', '2026-11-18 12:53:19', 9500.00, 'SANTINT A1', '<p>DISPENSER MACHINE</p>', NULL),
(58, 4, '[\"products/05ccc914-3c2b-480b-982a-192094851cd4.webp\"]', 'products/eae61cf7-921e-405a-b301-66eefcf625c1.webp', 'كوروب D200', 'D2026_10009', 120000.00, '<p>ماكينه خلط الدهاناتة بالكمبيوتر</p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, NULL, NULL, '2026-01-06 19:54:18', '2026-11-18 12:53:19', 15000.00, 'COROB D200', '<p>DISPENSER MACHINE</p>', NULL),
(59, 4, '[\"products/9e9db9a0-60ff-45e0-9cd3-efb4801f5282.webp\", \"products/584513a5-1245-4d18-9b62-4c40556a22d7.webp\", \"products/1c4f837a-ca46-4a1f-9478-27da41276a61.webp\"]', 'products/a09adc57-edea-41bf-8465-2fbeae510fae.webp', 'فاست فلويد TM300', 'D2026_10010', 120000.00, '<p>ماكينه خلط الدهاناتة بالكمبيوتر</p>', NULL, '[[]]', NULL, NULL, 10, 0, NULL, NULL, NULL, NULL, '2026-01-06 19:56:37', '2026-11-18 12:53:21', 15000.00, 'FAST FLUID TM300', '<p>DISPENSER MACHINE</p>', NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `product_reviews`
--

CREATE TABLE `product_reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `product_reviews`
--

INSERT INTO `product_reviews` (`id`, `product_id`, `name`, `review`, `rating`, `created_at`, `updated_at`) VALUES
(1, 1, 'ABDALRHMAN', '100%', 4, '2026-01-05 11:05:47', '2026-01-05 11:05:47');

-- --------------------------------------------------------

--
-- بنية الجدول `product_steps`
--

CREATE TABLE `product_steps` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `step_number` int UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `product_types`
--

CREATE TABLE `product_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `product_types`
--

INSERT INTO `product_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'النوع الأول', '2026-11-17 13:57:22', '2026-11-17 13:57:22'),
(2, 'النوع الثاني', '2026-11-17 13:57:22', '2026-11-17 13:57:22');

-- --------------------------------------------------------

--
-- بنية الجدول `returns_policy`
--

CREATE TABLE `returns_policy` (
  `id` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `returns_policy`
--

INSERT INTO `returns_policy` (`id`, `description`, `description_en`, `created_at`, `updated_at`) VALUES
(1, '1', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2026-11-17 12:41:31', '2026-11-17 12:41:31'),
(2, 'director', 'web', '2026-11-17 12:41:31', '2026-11-17 12:41:31'),
(3, 'employee', 'web', '2026-11-17 12:41:31', '2026-11-17 12:41:31'),
(4, 'user', 'web', '2026-11-17 12:41:31', '2026-11-17 12:41:31');

-- --------------------------------------------------------

--
-- بنية الجدول `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(7, 2),
(8, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2),
(29, 2),
(30, 2),
(31, 2),
(32, 2),
(33, 2),
(34, 2),
(35, 2),
(36, 2),
(37, 2),
(38, 2),
(39, 2),
(40, 2),
(41, 2),
(42, 2),
(43, 2),
(44, 2),
(45, 2),
(46, 2),
(47, 2),
(48, 2),
(49, 2),
(50, 2),
(51, 2),
(52, 2),
(53, 2),
(54, 2),
(55, 2),
(56, 2),
(57, 2),
(58, 2),
(59, 2),
(60, 2),
(61, 2),
(62, 2),
(63, 2),
(64, 2),
(65, 2),
(66, 2),
(67, 2),
(68, 2),
(70, 2),
(1, 3),
(5, 3),
(10, 3),
(11, 3),
(12, 3),
(14, 3),
(15, 3),
(16, 3),
(18, 3),
(20, 3),
(21, 3),
(22, 3),
(24, 3),
(25, 3),
(26, 3),
(28, 3),
(29, 3),
(30, 3),
(32, 3),
(33, 3),
(34, 3),
(36, 3),
(37, 3),
(38, 3),
(40, 3),
(41, 3),
(42, 3),
(44, 3),
(45, 3),
(46, 3),
(48, 3),
(50, 3),
(52, 3),
(53, 3),
(54, 3),
(56, 3),
(58, 3),
(59, 3),
(61, 3),
(63, 3),
(64, 3),
(66, 3);

-- --------------------------------------------------------

--
-- بنية الجدول `services`
--

CREATE TABLE `services` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `image_url`, `is_active`, `created_at`, `updated_at`) VALUES
(6, 'صيانة مكاينة التلوين', 'حافظ على ماكينات التلوين شغّالة بكفاءة مع الأهرام! خدمة صيانة احترافية تضمن أداء ممتاز، تقليل الأعطال، وتحقيق أفضل نتائج تلوين بأعلى جودة. اضمن راحة بالك وكفاءة معداتك مع فريقنا المتخصص', 'services/1767730444_30.jpg', 1, '2026-01-06 20:14:04', '2026-01-06 20:14:04'),
(7, 'برمجة الماكينة', 'برمجة ماكينات التلوين بدقة واحترافية نقدّم خدمة برمجة متقدمة لماكينات التلوين لضمان تشغيل دقيق وسلس، ضبط الألوان بدقة، وتحسين الأداء اليومي. مع فريقنا المتخصص، ماكيناتك هتشتغل بأعلى كفاءة وبدون أي توقف', 'services/1767730836_28.jpg', 1, '2026-01-06 20:20:36', '2026-01-06 20:20:36');

-- --------------------------------------------------------

--
-- بنية الجدول `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0tx3ioiGQXXcQfbWbP1IXnjie3qOXuneXVz5Gx2i', NULL, '57.141.20.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 (compatible; meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler))', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidFo2SjZpN0RMUWFLaHRDU1FCWEFzaEEzVDlBMWRvck1jNFQwbng3RyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795206168),
('3998nwYmnBUU7L68sGQIJrZZHGHtSZUk4W5NzspQ', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibTJyRTE2amRLUlF2OE5UM21KeUtpV3RtR1pLNTNoT2NLNUp5YVlpeSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916890),
('39WV8rcBCqsKMl8BF78qMIEy2jrTQweHBzzCFvdp', NULL, '173.239.205.4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUnlFTWpza3ZwSTQycTJwSUw3R3U1WmszdnhxdUZRVkVvUklOTUVFMyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795325053),
('3G9JbY3oUJEpWEzosWGTEJJUdKA2TFls1Zmjkfi6', NULL, '156.206.130.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUjBOS2JOUlJONlQ0NVhWS1c1OXZ1U0dQYnRFbTQwZE1aN2x0Y3BUeSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795347648),
('4poRq77rjHRwv0C5pdLVpwjXyQXLfjQCRGhKbIJM', NULL, '88.198.43.77', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMmhnRG5QcDZLUzh6OTlpcGdHYmx1ZUZqb2NueFNLdldDN0kxOWQ4NiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795325125),
('53KwTRbOHXvfGCTYV25eoSLddDpoFvLKzGUUPNfh', NULL, '146.70.132.91', 'Mozilla/5.0 (compatible; OusanBot/1.0; +https://ousan.io/bot)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieHc0SkJWVXJVM25zbjZLZnAyZW42QW5ENEo1eDZNYUN1UW1MRUxFcSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324939),
('57cgfqkKSwDuedJtjImge3L6qufUEZUZjReU21dc', NULL, '156.206.130.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZms4dWFxWFFqNmk1OTZtSVpoSU1wdm1YamZpbEZxY3JFaFhkVUJZdCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795359021),
('665IUHhEcPX9vECyAwfuN8W4uZlZxgY5YyfUoH1Y', NULL, '88.198.43.77', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRjdaaEV6SDVZSHVJVm5RSDRabHpnR2s5cjQzRE45Vjl6RTZTVDl4MiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324645),
('6v5pDfVIH1VqUAlIZEoAhjjuaeA2DRuneihown3T', NULL, '185.123.145.43', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRjBJNThvanhoN1Njc3V5V1plVHkzRWV2QlpOcEJ6djBvMnFEeFhGbSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324668),
('7kU9WAvFNN2CpReuFIWusgZEAZeHlLc8BN7wOYcF', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTmRKU3BFa2ExMENHeGhPRDdSb1A4VGJQc1VXUVptNTJXa3E1V2N3RiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916871),
('7oFAQuBw0cfevPofAgLV1b4XyIKO8UypCqr1LGY4', NULL, '122.8.92.169', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2diR0N6dWlSRUMwSEZranlSM3RkcGN6M3pITGZaOHF3Y1RSS0c1biI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792247991),
('8DPu1K9jhUDhfRNwHdSYPMeSchBgBnPM5d3liMp0', NULL, '38.132.201.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicGFCWWRKWXRNcWxxRHpicTRZbHZEejNVSUlKRHdKeXFZY2JsYVFmdSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324541),
('A0xmDnDeWbUALiJjM86MOp0aLOMUqGldXu8ms6k0', NULL, '141.98.154.51', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoicnpZTlpLaUkxbGphN01ZQWdCaVFEYlI3elV6a0UxQzRNSkVVV09pbyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1793200583),
('AKwU5j0p1CMVKmbXXBB7qWMVQlA562derpTysvT9', NULL, '91.98.176.86', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.7326.1006 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNm1UZHdTRms3OTl4a0xXdDJSQ0tBNDd3S0VlRFltamZaQ3BUVFpIUyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795175311),
('ALcdKwiE9YFLQiIeOW7gyDkvWgTa6CEiNeW4BDtW', NULL, '71.6.237.200', 'RootEvidence/1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNnhEemtrZjltRmhpajQ0MDRPMEpydG9iWFNFVmdmamVqS1MwTUREYiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792911546),
('An5SjVvWL1hHo62ex5DgIf9n3HGRXj2kTA5TgWrx', NULL, '66.42.63.31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRFZZSHFDYjFNek8wWjRIR0ZlSDNsNlNhRUxVdU1XN05DbTRsNzZjayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1791960025),
('BdkoLpD7Ep1soBK2jqvWpNEpsyTwHBtnaNbYQZPR', NULL, '104.28.233.161', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; ChatGPT-User/1.0; +https://openai.com/bot)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiekhsVVJFeWp3d1M2aDd0UDNlaGNQdlZ5bTk3dUp6b0dGMkVQRk4xbSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1793379225),
('CqaM8MqtBbARnuYP4or1NyhHsMXdStJYF4UFBwM8', NULL, '18.234.119.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_8 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOVM2U1FIZ1pXN01Gb2FGT3E4d1JRcTZtMlRvSURTeENmQkNiV1pTWSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795329309),
('cqiHxiTVXGgcrXNFQxUGzFH0Yl8D09KCiXacXjww', NULL, '102.185.17.230', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/445.5.1006576801 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOGw1Q0pSZFM0RUJEaGRiSmR2YVRzS1QzWE1LZTBXanU5ckV1c0VJaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795361592),
('Cs8VLlmKUP59It0wNPCFVvD3MB0J2MoVmsMhOnq7', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0hNS0RYNkJpTVVVTjh0NEs2ZGxFT1ZGeWlLbW9tS3pLYjlKcUlDNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916911),
('DB33dUgQpKyoCE1kErQ5xqmS3r9QhlnjmLrnYfMu', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicUIybEpZc2NXQ1RnVlpEdmZtdnFVelpiQXVvNHpmWU9LRGxTMFhESSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916897),
('DwBKQuCzAg9IsqIRH737I8eLAx0ypOKekaNmHUNv', NULL, '3.87.76.163', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVUgybTY5aVhxOEZ4VGR6V1BoQlR3MEJpcG5RN3dZaG1IdGR6VU5jeiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795054325),
('eAx4YQ28JjyBPRxHrbW6eH2Q8eQd06ylkK6ebMNb', NULL, '138.199.143.30', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.4379.1240 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNENxanlBS003NE9VbXRrS255emJCcktibHkwSWRza25vNWZNT3BIeCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794656020),
('ENIL7Zywul0zUomxucMiZ2hwVjtPXLCdlGtwdtdy', NULL, '171.22.217.179', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiODZwdVZ2eEhjd0tZOExYUlhRd0JYM05IaklTMTBOU0x4RHN1MlhTZyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324557),
('enktFagDkQz9xHqPmjmv8aXIFjthboudpxdLm2U1', NULL, '146.190.67.243', 'Mozilla/5.0 (X11; Linux x86_64; rv:153.0) Gecko/20100101 Firefox/153.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicUMxOW5OU3M3aVVVa29uVzNIejhkaTBqYVo0NHlQdFU2N1I0a1NWNyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1793291578),
('Exu7ri6U6F5gg6qvRcyMzMKMd0g2aSNWuzcYbjcE', NULL, '9.129.22.58', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNkJmeGp3WTdHNWVuYmNJWVVoNFJJOTdBc3hQbEs4OGt4TWJqYm83SyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794920088),
('FeLcVWBQ8DIJal693FOiWhOZiClQtuoFztPV07JF', NULL, '18.234.119.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_8 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemhyNExQOUkxdkVBSzFvaFpMT0poS2F0dmIzS0lGMG1NakU2S1d1WSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795329255),
('FgTD6Y1Y1xTFOs2jsxyi7gf47NyUJR8ByTrpwtwn', NULL, '156.206.181.192', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnE2QlNXSzFzS0hjWHBWQ3NwWDhwSzg5ZjZ1ZTlCa1FCaUV3clZjMiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795006280),
('FiyNEY9BGfA4mCASXzJzwixPwuCjqL0Khb4CTtXl', NULL, '5.78.28.75', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUJwM29SaXJ2TWZ3M0NvbXBKN3RGOHJHd1d1Y1BqWU94NTdvTjZuNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324524),
('FrUjr9HyzdNk7s3H4KPDvef7kBRRh35n5Ro5uGS3', NULL, '156.206.169.175', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0VLZ3NJNEFpT0J1OUJxb0dRZGZVRW1RcjlYUGtXd2JIeHpPeWlQZyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795085055),
('fwQeuhcF0hIqytGiONREhL4jZyVSHNiaTmKLEdRr', NULL, '196.139.153.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemMyUkRveXVUQzQ5WGJOSUl4V2o2bHZKZEpnWkFKc0xQeWhTUWwzQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795358782),
('gjdBNxcazLQzu74gzsbpmYuDzZtr8CEIHGvjlKvP', NULL, '71.6.237.200', 'RootEvidence/1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ1g1S0M5MWZpVTk4VHc5bW1Fd1dnZmxuVTVTMjRyVUVsVzdtazFWYyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792910252),
('Gyw2YnjYRS7MW1T6pYzo0cpbeOtftsjOuZrn0Cq1', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNXpjUjVCcXJwZTBmcVpaREVmdXo1OTJISWhSQUJWektuUXQ1Q0I4RSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916307),
('hpIf01OET7E5NSNKSIHu2TJa3PfODagySuTC8ACV', NULL, '193.31.127.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:137.0) Gecko/20100101 Firefox/137.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicUpNVUQ4bldVTUhuWlhPT1EycVhZeWM1Smk5ZU45enZSUlM5ZWwzViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792721867),
('IHSa03oFMcDp5l0266c2YueLiLEANhw3Zc8Hnram', NULL, '143.198.125.84', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0txRWFOSjFGOVozNW1PbWFGWDNFenVOSklNT1JWbkRwdmNZS1RJdCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792072041),
('ImaUPVQCy7wI5ChqiY1Gil7h4dZnGcuj60eLeZJB', NULL, '34.245.29.98', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOU9lTTdoTU44UUlDaG54WWNJOWFZZGsyZVJXU0Fza21NRVRYejNNViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794948185),
('IO0INEzagGkCDLHdDKXexFnal50LjGuEes4lHX9N', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0lwWTlkcUFDS2tyRlhlcGxpYllFbTBCSGh5aFhDaTJnY0R6ekk4MCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916320),
('iWaVFf2maEcV3V9umF0qcQfD3PSwALwNikhZUYUA', NULL, '152.163.164.48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUDJzNGFFMG5QV21HbU5pQ09yVmlOUFhOZEFhRjV6TUljdTkwclVaUyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324627),
('iXWkEWLLedEeIACgo1KryktxGJ2De1yevN0n9itH', NULL, '152.163.13.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia1BxVGR6dFhSUTc4UGFSNjYzNUhKQkNESWVzVUtLMnY0ZzBmTm5vUiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324795),
('jMHVwMYvCWShjzPMt8DpUsiwV0s9Jx2QY9MgrGj6', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiek5yTnhQejhZMVJlSUxIWE44bHo3Z1hqUjhrcUdlRGdCZ1lyWjlWYiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916278),
('jrO9cLZaj9NP1m8Ww2MiNkUCamJCZcRnOxHB4Iap', NULL, '196.139.153.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidm40bEEzRmZiTmpVWFZ3NjRiRUlqNXFVdkNINjlkQ2dsY3JnSk85ayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795359516),
('JWrRdhfU9ZZZX6JNPRxNVjHdIIsPMfWTYCGgUjJ8', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTFhPVjVYUjM2ZVBpNEdlUG94WVQ5NEdJdXVIOFRLMzVvYmViYUpQUyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916295),
('L0OvG7bpken0pPZaacujj3WjTdWfN6eaGRccrfl7', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOGswTldzbTNock1jY0NKN1JQSENpNUVZZldGaGNTblN5RngweXE5SCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916269),
('L8xOykqUy9MRSTvAHi0EKfpmpl3EykWDXdK1JTMi', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUxHU201Z2VtcXJqZFJ2MXJhNGFJQjBpMFBWVzdEUmFrVFNCdk9rMCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916301),
('ljFzYTeBu7QHV8XiQXYDUp20MashdOKsjwTLbXp9', NULL, '54.167.244.208', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_8 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVmlZWU15VGV6SXhFNDQ5WUV1NzlEc21MOWY5SWtzaW9PdWxhcDdkYiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795325446),
('lsJuGGkzm6YIXEp5rNKe9DvCLChEADdS8r3cyFWq', NULL, '32.186.136.133', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWdLQUFhQ0Z3SmJzSTBZd1JsTDBOUzNoM28xQ29CWlBGNGZmMXp6cSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794316888),
('m4iTnG4CrlVJC5MV7cp5DdzJHSCeWyHC21HzWA5r', NULL, '74.7.241.34', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.4; +https://openai.com/gptbot)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia0MxRm9hSDJER0MxR1dEeXF5YU9vcGFwQUJlU0I2R1B4TDVqTnpkdCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795326761),
('MCWcgP8VS5VOtJ4RvBYepm54Gy8H3kSiYZzDlRcu', NULL, '192.71.36.198', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3.1 Safari/605.1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTlc3NTFQaFZ1QlpyRXVXUjN1NEN2eHpOeG5kS1JQdlY4dFBMYjNpeCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1793589471),
('MUqrYy6iJxxI1Ub8vAYbmsVWU1bH31mdtEgIB51b', NULL, '74.50.123.17', 'RootEvidence/1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNTN2RmNaWkFEbFB0ZHZZWklFNTdzODU0cjZVNk1MQ2Vjc29ObjM4MiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795155148),
('Mzq7KMUb7nHmRDy0XYRLMHvh1PWOjmHq2a7PeXt7', NULL, '74.50.123.17', 'RootEvidence/1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidDhONzFoVjRYb09tOVBBVU5MOU14cFZ5NHFHT293ZnpHSTh3amhQaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795155994),
('N7XXb9DsLZTUm90wfGSxodcd0i5ZNpEBXHQlLRJw', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT25DSGRzdGZINjA1T213UXo4V1RId3JhVGlWR2x3QlBja2Joc2tsYyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916959),
('n8jT8pUWf3zznd89wCzCIdTq3eqwtFBXA52TQZfq', NULL, '34.144.173.225', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWDdZZHFBZHN6WUNKbGRYQWN6d3JRZndxUFZDMEVXUm9PVEtRZ0lZVSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792794656),
('NcXplgYH0SVf4f6Lwbash3jJaEMr4lc46D9ORdK0', NULL, '34.144.173.225', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibUdWYWZobDhqMDZDZGU5dU5nSlBQandFV0I0S0dJa0FGVVJleEsxSSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792794741),
('NLAwZ6qffHf0tEvaDu3xQFXEac2M9k3jiP210Rta', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia2t6a2pNYmxyckFhbk43U3VJQ2pYWnZ6VDBaVFhPVHRTNVFQbFdRSCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916927),
('Nwf06Qnj1G07Lb79nJRx1jiczqTm9mkCqNyqPgBA', NULL, '152.163.186.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicTdoVW8wZ3N2UzVPa3V6THIxeDNVOGFkMEFlaTl4bnduSGFlaVUzQiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324543),
('og7b3Fpg0j7k9DDw2V5QgqlwK2wI1NAc9h1kWHmc', NULL, '88.198.43.77', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnhjaTd1UFJwQkZXS2FROGtBcm9NdUJycEk2eHVhRVpwdmlhbTRBWCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795328125),
('opvSteLC8TVGcR1DMVfO0EDdTWqNqZDsezYFeBAE', NULL, '57.141.20.35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 (compatible; meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler))', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM0RBVThNSHdFYTJ2MW1idDFwR2NTQ1FPSmFhcTFoRjY4VVpad21BVCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1793900971),
('OSNHxlTIabqYpnDAiUIgSgcyJabxCVAcfhROxr7p', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibExiOHJUYjhaQzhZdk1tQzdoSzV3a3J6V0w3U3NaU3o3b0JpOGJsYSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916284),
('OVrVoOGGeLYy0GioXax7jP29giHf8IZAh7vksilM', NULL, '138.199.140.203', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.7065.1090 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ0xEQVEyeUZINWJtNnFNTnJ3N29oM205eHFFSXprdzdSa2pqTjlSMSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1793966268),
('P23N3jHf85f0fws9cBWdaj9PL0zNXusYOnh9QvoW', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.22621.4249', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidEJnUTRpVHY4Vk0xc1R1T3F0RUxhVHZNeHo5bmVveURHSDdieUQ3cCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794909002),
('p76sVK2HFe75kkqcu7NhNpcQHFTK1VD94qvyeKrh', NULL, '220.167.232.188', 'Mozilla/5.0 (iPad; CPU OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ2FhNGx6WnNacEk1NEFTaU43RnNCRmJldmNJa2xlcDlLa1FjMUM4QSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794549116),
('pb02tBUO5qYByoFqa8VOx4ydqnX0eTbExh4plWP7', NULL, '1.171.35.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTDM1YTIzbU9OMmJOdjNjQXEzNWE0cDY5WnNQTnZNVFN3WjYyc3V5dCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795301030),
('PERQtvpfeURqu7ZTj0cndI7gAB4h6Qp1xgF26WrM', NULL, '216.73.217.87', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; ClaudeBot/1.0; +claudebot@anthropic.com)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid0sza3FzQllPR0E1MUZxYktiak5WR0oyRHBBNW02dnJxdG9OWEVDeiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324672),
('PVGKaP1Txo3mhS9CyugyWER5EwwZLb3pklwttiLT', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmRmRHZzMEd0d1BjUlVEa3JmVFN3ck52NlE5V1g0UzZrem85Vm9mMyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794922380),
('pXHJS0QFIj7PtIzYpqyJASPIzJK7TDJdMqQsNcs1', NULL, '107.172.124.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMUtqNDZYc1pteXdoZnFpMDdQaGtmY0JwWm5mWXdEVHVjZTJsc3g1TyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324698),
('qAgIha0g8XJwahmecpm0JRF4zfkmJeO1rFTgeVFb', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR0ZBV3JQU3FHMDZ1bGRPM1VhVUY5bUJPV0xFMVd0dVlqUXRMalJCWiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916946),
('qejYn1n1KVuuLboIMWnsOdlMJuEiVEAd5typxi6k', NULL, '94.239.50.15', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaFZSNjJsZm1UTG1ya3BTdkJydmZlUzJna2ZySVVJa2l5R0RYSTM3USI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1793913608),
('qgb3VA1lvOw0YUvPKI13szgXg4RdLcV07uKijTUz', NULL, '92.62.121.102', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWlFxa2NQaVVITk1oRmY4OWVnZ3NteHhHM0g2S1dqb0dObHFFV1NZVyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795325052),
('R4QPJyat8bqzthHvg0uwsAjZRxI7Ql0aJiHB5eyC', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibDJma2F3WjUyQWlYTHJOUTJMdkk0WjN3cWl6d1JPUE93TmVlb1F1WSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916904),
('r6cz0l7ngegz4k4rBDDEJAX6WVdHOBN0DRNIcaHe', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV05hNDlRN25uMWY3R2Jxd1BTUXdCSVhzUGs3eHFpRnJFeFI3T2ZJRiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916290),
('RKmusouuiP2mvr3XpDLwUKMIogkFvu7QAjQRnH4T', NULL, '161.77.104.209', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibWNIenFIVlFPOGU3YjE4UkJFNGN1NmxNbGlHWjJtS3BDZVlTbkdrNyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795325566),
('RmqSEuZJ6M5bgyULnqp0FVjBUWG44tlzctGrq6OW', NULL, '102.185.17.230', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/445.5.1006576801 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibVlEWm12YVd5UkNndzJOTGxpSE1PS0ZzYmF1RGZ6NFlOUXM1cXgzTSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795361602),
('rztmqAcgledlFgzMa1aqhHW9oPhQ6NDar7kwuWFL', NULL, '102.185.17.230', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/445.5.1006576801 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNERycHdPZ1V1VDFFTWNCNWZxV0g4N3FPVmRXWmJwbWFiakFrVGROUCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795361586),
('SmcnfjNK3ysyUn7UxR9XJxAjw2evKDeqPCWux3qf', NULL, '157.173.126.66', 'Mozilla/5.0 (X11; Linux x86_64; rv:132.0) Gecko/20100101 Firefox/132.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVTU3TGhWZE81bmdBVDlWUUdsdU4ybGFrc29JZ3FmeU9Ub3VZNWRjSiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795326325),
('szfrS2tGsTk2Cd6LnsBMkdiiOiohVM40Be0o2Dai', NULL, '88.198.43.77', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRnExc2JQMXVtVVY3QUxaSlZCVm1SR1oxN2VnNUg5VjVubEcweWFKZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324525),
('tD6THldXxROY6E0M8ssKzaikUy3rsYaZ9X4BJzFQ', NULL, '196.139.153.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaWdvM2hHbk1UTlo2NU1YZ3k0MWtNOFZ2NE80dlFFb0QyZzBvV1ZzTSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795358913),
('TiY49YJEXJyr6hvgCTQJWM0y7DJMTNMzVfmbqYpG', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTDBVU2d4WTFRZHpoWDRzRzhEeFd4eHpGdmwxSHJvdEVEbUw2bmh2YyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916314),
('UdAgbcWCerJkdTn3BhqSyyXJJR7yi65gt55TBAFj', NULL, '44.255.66.189', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36 Edg/124.0.2478.80', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWWZXSDVKd2UydXJ5ajhKbUpoNkNzYTl3dGNGOGxCWUVsU1liZFlMVCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795203634),
('UhkZtBZpJNDbHfWfVIaxobbduSVVUTfyLvQklSxz', NULL, '63.33.41.36', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQndQQ1RwOVBxVXR2U2xBUHRtemJjWWt6VXhoY21uNm1tTzN2TjNCYiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794352237),
('uImHK8SjewD7ck7TG6UypREfq6gyJwSU5Zy09Wgv', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid0VISHNqb3dGUlFTVzJjd0RXMXJZbWM0VVU4QVZhRDJmQTRRaHpBTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916326),
('uof2sT4Kh4U8jf0Hmi0bV1qjF3IH3pg6DjtGT7i2', NULL, '71.6.237.200', 'RootEvidence/1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUZSem9HS0paVzVHM09FTk5pY1lOdE9ON3ZCZGFlbEhUTDY5WEhabiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792910250),
('Vdym6LqZtnosXDn7PrD4ZNu32utypgh6sfddaRds', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRERKVk9xNjJ1TWtmU2F1U25jS2xyRWdSSEgyZHVyRWtxc3JFZ1F3dCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916273),
('vSNVOu0Pp3oA624i3ATTATnQhp4cV7iqk6YJ1rtQ', NULL, '159.65.220.134', 'Mozilla/5.0 (X11; Linux x86_64; rv:153.0) Gecko/20100101 Firefox/153.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWU9wQXBmZWJPVU1xWHJhZWg2Ym5hUUpaaUhUSHJtZllqbm91SnlUeSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794491491),
('w4tiIsJjYxYdVCsT9MFZCC0aMD0vRdqRhx1LnL7p', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibllQVThrR1JvMUNNRDVaNFhpc0ZzMUJPWDZKT0xFa1kySnNBSkJNNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794917577),
('W800InohyyzvJPtrvespJTMwjuPhujkSKN7ncNWO', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTDA1ZkJDYzV3Zk95dlJrejZiMDEyYVJFQmk4MEdsVGJpWXlJb2ppZSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794918268),
('WqD5BrApDUSdjiTxLpdD6bzjSbuvEq0AA5kHHcy5', NULL, '102.185.17.230', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/445.5.1006576801 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNnRCWDlrSnVDdUhzZ3N6aDlCc0k2MzhKRkFwc1ZXNUVQYzg2azFncCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795361580),
('wylC2vAigrNAWXJ7eKsRCk15l7xkjsNbe1HsEwKM', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1NyUEN4SGVqS0Faa3BWTjlnZTNrRkdnb0dBMGJqOGlLa3hvTE13biI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794918250),
('Xs5yFXkNRtYvJuqsaAzZpUmv8P132YEkPYTjA1HQ', NULL, '54.210.45.111', 'axios/1.16.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTWtDbGdWRXRNeDJIcWNrdGdOa2ZETnVMWHdSV1Q0bzd0dTg2Y1VPMSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795325106),
('XskVUkFRfyRxpYz7eN1G3ZiS6ysZc1RPVsbxvFGj', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN003RGltVTBxZ0RQVTJuOVQ0Y1AzSmRFbnFTZEpuTjBjNE1VYzZOYiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794916952),
('YITzviRgIRJDjwyzJmyOYW4gsG0wEwxpTkhsFFyx', NULL, '49.12.126.247', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.1195.1307 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU21EVkx2SUNUblRSUU5ITTl6bjE1WU5vMjZNTFpsZXBRVjdtSWlsVCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1793478599),
('yV5Y1vhEPn93jhpIUBxZZMHIBPknIx9iak7hwHjY', NULL, '83.168.122.51', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicFY0NUxEWWxHQnhZamdBQ05TcUlRWUdVWWprVnhqYng3VVZxbFVERSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795325245),
('YW8ngPqvS1xN77ZVBK5ovHDV8KMmbcKyyYD0PLbE', NULL, '172.241.168.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOFlsamhySVN0dDhNRVJEWDRtVXJ3TzlvRnJnb2xYVllld2dVUmZLZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794942925),
('Z8d2GaZUx9HGGdY4hdAAu0vFLgE4ZraUu4ILNjl6', NULL, '57.141.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 (compatible; meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler))', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYjlzc25CRlA2d3lpY0FObzhmZVl3Mzk4c0t5Nm9hRGlvZlNBVWZBNyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792493613),
('ZF6u8zxZbIYFxMtMjP1mWiYlZokRw9KcYPMHqgh1', NULL, '103.4.248.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicXI2NDJ0eHBBZ3lhYVg1TVlWTnpKZWxVNWpWOWdpcDhHS1A4Ulp4cCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795328542),
('zKNCzCuJUs3OlHYddxCaRov1550u16R79fzzOM3f', NULL, '156.206.155.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) OpenCode/2.3.0 Chrome/152.0.7977.167 Electron/44.9.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibFpIZEFlWGJVZmFoVEJyWjR2SGlUaXJzcW1uWW5pVUJiUzRmaXUzciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1794918258),
('zP3AqVEWDsXKN6NFGtgou4bxORLBBUbm4TgTDNMG', NULL, '54.167.244.208', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0tTWFdDMjNGR1RIOUJpYm5vcnFLYWt2NGI0OWRWWDJiMDdnMVRUOSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795325428),
('ZSuW4AW5vf1LS6O2j6ZBwMK6Ez1OWiswGKJAutlw', NULL, '156.197.74.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibllJcDZDTjRXQmV0UE40ZDdwZWt6N1ViV3RwMVlwcXBxc1FsNEdnZyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795324543),
('zV3X8laCXfHaouPDSOgzzJpyDPWQOECBK1ZuoYo8', NULL, '74.50.123.17', 'RootEvidence/1.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTE1zQ2tkWmZVVUgyUjAzTm9MeGcxU3M2R3U5V1pEQTdvVGo4ZkFsMSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vYXBpLmFsYWhybS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1795155148);

-- --------------------------------------------------------

--
-- بنية الجدول `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `free_shipping_limit` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `vat` decimal(5,2) NOT NULL DEFAULT '0.00',
  `instapay_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vodafone_cash_number` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `settings`
--

INSERT INTO `settings` (`id`, `free_shipping_limit`, `created_at`, `updated_at`, `vat`, `instapay_id`, `vodafone_cash_number`) VALUES
(1, 10.00, '2025-12-30 16:26:39', '2026-11-19 12:13:14', 10.00, 'yourname@instapay', '01000000000');

-- --------------------------------------------------------

--
-- بنية الجدول `shipping_info`
--

CREATE TABLE `shipping_info` (
  `id` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `shipping_info`
--

INSERT INTO `shipping_info` (`id`, `description`, `description_en`, `created_at`, `updated_at`) VALUES
(1, '1', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `store_info`
--

CREATE TABLE `store_info` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `footer_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Shipping_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `seo_keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `social_media` json DEFAULT NULL,
  `phone_eg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stats` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `store_info`
--

INSERT INTO `store_info` (`id`, `name`, `description`, `logo`, `footer_text`, `phone_ar`, `Shipping_number`, `email`, `address`, `seo_description`, `seo_keywords`, `created_at`, `updated_at`, `social_media`, `phone_eg`, `stats`) VALUES
(1, 'شركه الاهرام', 'وصف قصير عن المتجر', 'store_logos/1795091197_20b26914425776ce943a9b1269fca4f445a5dd00.png', 'نص حقوق الملكية', '+966 54 176 8792', '01234564789', 'Sales@alahrm.com', 'العنوان', '1', '1', NULL, '2026-11-19 12:26:37', '[{\"icon\": \"social_icons/1765370045_Screenshot_2025-11-02_143244.png\", \"link\": \"http://localhost:5173/profile\", \"name\": \"Facebook\", \"status\": \"1\"}]', '01100248094', 1);

-- --------------------------------------------------------

--
-- بنية الجدول `testimonials`
--

CREATE TABLE `testimonials` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp_expires_at` timestamp NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `accepts_emails` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `users`
--

INSERT INTO `users` (`id`, `name`, `name_en`, `profile_picture`, `address`, `phone`, `otp`, `otp_expires_at`, `email`, `role`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `accepts_emails`) VALUES
(1, 'alahram-admin', NULL, NULL, NULL, '2012807399060', '116378', '2025-12-28 11:24:14', 'alahram-admin@example.com', 'director', NULL, '$2y$12$rlUN7y0pt3e.IpUzlXVw/uQNUhI6etjwyCz91BvPIVuUUmoJzfxI2', NULL, '2025-12-10 12:06:40', '2025-12-28 11:19:14', 0),
(2, 'test', NULL, NULL, NULL, NULL, NULL, NULL, 'test@example.com', 'user', NULL, '$2y$12$FSZ6qGJRVJpcmI.im11pweBUSw.pxcaCn98E50u4704bNeZSGsu1a', NULL, '2025-12-25 12:03:42', '2025-12-25 12:03:42', 0),
(5, 'أحمد', 'mohamed', 'profile_pictures/695391e4e35d0.png', 'الاسماعيلية', '201280739906', NULL, NULL, 'test@mail.com', 'user', NULL, '$2y$12$AgG2rKKEPICqEQD16ra1WOodWxifvdR6z7BAHkKCDgtCdmti/2M56', NULL, '2025-12-28 13:26:58', '2026-01-12 09:28:04', 0),
(6, 'mohamed', NULL, NULL, NULL, '2012807399062', '930212', '2025-12-28 14:06:24', NULL, 'user', NULL, '$2y$12$gnfkgzLm9m5Q0sj2L1ruJOZlL2XIkKWmzSdqcW0yDT0DVtM3HbV..', NULL, '2025-12-28 13:59:39', '2025-12-28 14:01:24', 0),
(7, 'mohamed', 'mohamed', NULL, NULL, '201023402756', NULL, NULL, NULL, 'user', NULL, '$2y$12$9NSBQpMO.assGo1nUlouk.81ZEON3gDt19s0FT0mtuwBo640/yDD.', NULL, '2025-12-28 14:16:16', '2026-01-12 09:22:21', 0),
(8, 'Ahmed Eid', NULL, NULL, NULL, '01019324725', '835001', '2025-12-28 15:26:33', NULL, 'user', NULL, '$2y$12$6E4OYY3dMFzRW6YvyWvXMOeZN6O3b6Lznntv3tDgXZ95VorbM/E/a', NULL, '2025-12-28 14:50:56', '2025-12-28 15:21:33', 0),
(9, 'Ahmed Eid', NULL, NULL, NULL, '201019324725+', '256406', '2025-12-28 15:18:02', NULL, 'user', NULL, '$2y$12$lXpGpEGsMA.t0ZpjRwpPVOn0dTQHyOZQ.W7A8/D1tcHWhNWoEd1.O', NULL, '2025-12-28 15:13:02', '2025-12-28 15:13:02', 0),
(10, 'undefined', NULL, NULL, NULL, '+201019324725', '804259', '2025-12-28 15:20:03', NULL, 'user', NULL, '$2y$12$V4HLJMA/17iWagZBL6D0eORnKqbvJ.TrLj8HbCJk/.NxkSXg5qCgy', NULL, '2025-12-28 15:15:03', '2025-12-28 15:15:03', 0),
(11, 'Ahmed Eid', NULL, NULL, NULL, '201019324725', NULL, NULL, NULL, 'user', NULL, '$2y$12$Wh9Eepzz3V.031v7lyO5VefQe7Cnb9IdBpV4qf/qCKVikCeMJ3ttq', NULL, '2025-12-28 15:17:21', '2025-12-30 13:03:00', 0),
(12, 'احمد محمود احمد محمد الغبوشي', NULL, NULL, NULL, '01007152465', '577116', '2025-12-29 01:11:11', NULL, 'user', NULL, '$2y$12$ZKxvqL5tzL2okY2VyAeVH.QECNOJ52OaKNV0cgZKmM7yEwegZmTry', NULL, '2025-12-29 01:06:11', '2025-12-29 01:06:11', 0),
(13, 'undefined', NULL, NULL, NULL, '966213', '893603', '2025-12-29 08:56:48', NULL, 'user', NULL, '$2y$12$1KL7PNcexPX8ACUeKHPop.h2Z8Sa3zP9Z5Vky5iCkomNgIwlaH276', NULL, '2025-12-29 08:51:48', '2025-12-29 08:51:48', 0),
(14, 'undefined', NULL, NULL, NULL, '204123', '581155', '2025-12-29 08:57:00', NULL, 'user', NULL, '$2y$12$4AL8XTjIQeoyYbKnDZBomOe4ii03asq9UEQ.73AcAeQrvfY1Wm4lC', NULL, '2025-12-29 08:52:00', '2025-12-29 08:52:00', 0),
(15, 'undefined', NULL, NULL, NULL, '20undefined', '934136', '2025-12-29 09:08:13', NULL, 'user', NULL, '$2y$12$jT11mB17CTP3H0Wg76XVfOMJ1r1mnczj04eXMtVNKPrkbrRo0XpZO', NULL, '2025-12-29 09:03:13', '2025-12-29 09:03:13', 0),
(16, 'تست', 'test', NULL, NULL, '01000000545454', '681441', '2025-12-29 11:51:30', NULL, 'user', NULL, '$2y$12$0muOOt6IKMJEJgERhvFdguvjBRWHKk1l8CVAm3QHvR3IVqG9v9t4q', NULL, '2025-12-29 11:46:30', '2025-12-29 11:46:30', 0),
(17, 'محمد', 'mohamed', NULL, NULL, '2012346589', '471464', '2025-12-29 12:00:07', NULL, 'user', NULL, '$2y$12$Pdr/AjUaY31bF9r0ca8KQOzwr8u82NmlulpL3Vl0KKhn2LVFElKL.', NULL, '2025-12-29 11:55:07', '2025-12-29 11:55:07', 0),
(18, 'احمد', 'ahmed', NULL, NULL, '2001019324725', '543011', '2026-11-22 15:37:18', NULL, 'user', NULL, '$2y$12$DwSePXtGzbiaWZjmmmFgoeTU/BdJT6THKFTHKtJrrim2NHCrGqsxK', NULL, '2025-12-29 12:31:29', '2026-11-22 15:32:18', 0),
(19, 'احمد', 'ahmed', NULL, NULL, '201016988296', NULL, NULL, NULL, 'user', NULL, '$2y$12$rU4Yb975XOjDhFR4bHrb7exKNGcvk8Zjf34KfLiuoROXu1QDc5Wt6', NULL, '2025-12-29 12:40:16', '2025-12-29 12:40:43', 0),
(20, 'test', 'undefined', NULL, NULL, '202016516854786', '549848', '2025-12-29 13:01:09', NULL, 'user', NULL, '$2y$12$MeNfXoZqG2nJdFs5Qj3QXehpcBB1UltlJd0bRNyCflsJJDpKdfYhi', NULL, '2025-12-29 12:56:09', '2025-12-29 12:56:09', 0),
(21, 'احمد', 'Bosha', NULL, NULL, '201007152465', '801562', '2026-01-05 21:51:56', NULL, 'user', NULL, '$2y$12$7NE7uVLjkfwh..znYwi.hO2Hjqo2IOPjgk.0b8esV67Vb1XkKWmr6', NULL, '2025-12-29 19:23:43', '2026-01-05 21:46:56', 0),
(22, 'AHMEF', 'undefined', NULL, NULL, '2001040701880', '813933', '2026-02-09 11:43:53', NULL, 'user', NULL, '$2y$12$eWOOA1SID7YvmwPYAhpSp.x1sxbsDmD9lYX4JImZ45o8i/oMWp1VS', NULL, '2026-01-06 20:38:02', '2026-02-09 11:38:53', 0),
(23, 'JGIH', 'undefined', NULL, NULL, '201040701880', '583094', '2026-02-09 11:55:24', NULL, 'user', NULL, '$2y$12$XMD5vFJRkXsLXuf2J56bqurvEPRl7.Yo696gv9nzAqZWE0ypRv54u', NULL, '2026-01-06 20:39:00', '2026-02-09 11:50:24', 0),
(24, 'Doha Zakaria', 'undefined', NULL, NULL, '201014040516', NULL, NULL, NULL, 'user', NULL, '$2y$12$bOgmRfZTuX4G/9KHd8cpg.sKy9rD0HBF46SdN1mDH/ZsA8iGOq8V6', NULL, '2026-01-06 23:48:47', '2026-01-06 23:49:34', 0),
(25, 'Mahmoud', 'undefined', NULL, NULL, '201021937864', NULL, NULL, NULL, 'user', NULL, '$2y$12$U4IBg0ZT6FXuGYnwrNLuz.AUOVDvdtbQs.CVoyV7u/GDJHTlwz.YS', NULL, '2026-01-07 13:07:52', '2026-01-07 13:08:40', 0),
(26, 'Mohsen Eltaweel', 'undefined', NULL, NULL, '2020 011 12087090', '811341', '2026-01-21 04:26:22', NULL, 'user', NULL, '$2y$12$J/BiE63QnmyOnoR1Icj0MOw5/qoQtMgsOEtP1f/xhq2SSjF3e5sUa', NULL, '2026-01-21 04:21:22', '2026-01-21 04:21:22', 0),
(27, 'Mohsen Eltaweel', 'undefined', NULL, NULL, '201112087090', NULL, NULL, NULL, 'user', NULL, '$2y$12$QsaMNBUkCCm1xACbHQaHVevjrMC5EIdHvHCr.zTstSlSBLwlBqgYe', NULL, '2026-01-21 04:23:36', '2026-01-21 04:24:21', 0),
(28, 'Sayam khan', 'undefined', NULL, NULL, '2003267275062', '471681', '2026-01-29 16:55:28', NULL, 'user', NULL, '$2y$12$XoRryKf6lZM2MxOrxJly6.8CIxhIihwEAYSdMYcFeGaheDCkS8hGu', NULL, '2026-01-29 16:49:56', '2026-01-29 16:50:28', 0),
(29, 'Ebrahim Alsadig Hamed Adam', 'undefined', NULL, NULL, '249123622104', '691331', '2026-04-06 21:29:39', NULL, 'user', NULL, '$2y$12$nYgn0Vexi7uk3ehkT0WureD3T8Qv7qNlyjWU3rsnVpTYS.SW2jqKS', NULL, '2026-04-06 21:24:39', '2026-04-06 21:24:39', 0),
(30, 'Ebrahim Alsadig Hamed Adam', 'undefined', NULL, NULL, '249915595977', '427262', '2026-04-06 21:34:47', NULL, 'user', NULL, '$2y$12$yp.Xoe28LlJ9xIw7irPYW.IVfxZe5byBtYTY1d9fT/ojOnUxkYTia', NULL, '2026-04-06 21:29:47', '2026-04-06 21:29:47', 0),
(31, 'Permission Test Director', NULL, NULL, NULL, NULL, NULL, NULL, 'permission-test-director@example.com', 'user', NULL, '$2y$12$Sb4cvseI3/.LGKIi96d8NOLM4AO4dvs9sSfZTDZffmOGXZX9oGGCO', NULL, '2026-11-17 12:53:19', '2026-11-17 12:53:19', 0),
(32, 'محمد أحمد', 'Mohamed Ahmed', NULL, NULL, '201000000000', '172701', '2026-11-22 14:56:10', NULL, 'user', NULL, '$2y$12$87qRWTEzXEsv11VUD/ge3ef8HVgzqcSzgVFfJ1iv4MNgq.kh6uitq', NULL, '2026-11-22 14:51:10', '2026-11-22 14:51:10', 0),
(33, 'محمد أحمد', 'Mohamed Ahmed', NULL, NULL, '20100000000', '488398', '2026-11-22 14:57:10', NULL, 'user', NULL, '$2y$12$Jd5Oo1GkR8fNeDHmEEWi4OgmMFjN7NTD1vnhPrS5LhQdCkhjLBzSS', NULL, '2026-11-22 14:52:10', '2026-11-22 14:52:10', 0);

-- --------------------------------------------------------

--
-- بنية الجدول `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` json DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `user_notifications`
--

INSERT INTO `user_notifications` (`id`, `user_id`, `title`, `message`, `type`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 1، بإجمالي 20 ر.س. سنقوم بمعالجته قريبًا.', 'order_created', '{\"total\": 20, \"status\": \"pending\", \"order_id\": 1}', NULL, '2025-12-25 11:18:37', '2025-12-25 11:18:37'),
(2, 1, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 4، بإجمالي 20 ر.س. سنقوم بمعالجته قريبًا.', 'order_created', '{\"total\": 20, \"status\": \"pending\", \"order_id\": 4}', NULL, '2025-12-25 11:32:29', '2025-12-25 11:32:29'),
(3, 1, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 5، بإجمالي 420 ر.س. سنقوم بمعالجته قريبًا.', 'order_created', '{\"total\": 420, \"status\": \"pending\", \"order_id\": 5}', NULL, '2025-12-25 11:43:24', '2025-12-25 11:43:24'),
(4, 1, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 6، بإجمالي 420 ر.س. سنقوم بمعالجته قريبًا.', 'order_created', '{\"total\": 420, \"status\": \"pending\", \"order_id\": 6}', NULL, '2025-12-25 11:54:24', '2025-12-25 11:54:24'),
(5, 1, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 7، بإجمالي 420 ر.س. سنقوم بمعالجته قريبًا.', 'order_created', '{\"total\": 420, \"status\": \"pending\", \"order_id\": 7}', NULL, '2025-12-25 11:55:33', '2025-12-25 11:55:33'),
(6, 1, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 8، بإجمالي 420 ر.س. سنقوم بمعالجته قريبًا.', 'order_created', '{\"total\": 420, \"status\": \"pending\", \"order_id\": 8}', NULL, '2025-12-25 11:55:48', '2025-12-25 11:55:48'),
(7, 2, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 9، بإجمالي 1210 ر.س. سنقوم بمعالجته قريبًا.', 'order_created', '{\"total\": 1210, \"status\": \"pending\", \"order_id\": 9}', NULL, '2025-12-25 12:04:04', '2025-12-25 12:04:04'),
(8, 1, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 10، بإجمالي 220 ر.س. سنقوم بمعالجته قريبًا.', 'order_created', '{\"total\": 220, \"status\": \"pending\", \"order_id\": 10}', NULL, '2025-12-25 12:55:11', '2025-12-25 12:55:11'),
(9, 7, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 11 بنجاح. سنقوم بمعالجته قريبًا.', 'order_created', '{\"order_id\": 11}', NULL, '2025-12-29 11:28:24', '2025-12-29 11:28:24'),
(10, 7, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 12 بنجاح. سنقوم بمعالجته قريبًا.', 'order_created', '{\"order_id\": 12}', NULL, '2025-12-29 11:33:59', '2025-12-29 11:33:59'),
(11, 7, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 13 بنجاح. سنقوم بمعالجته قريبًا.', 'order_created', '{\"order_id\": 13}', NULL, '2025-12-29 11:35:29', '2025-12-29 11:35:29'),
(12, 7, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 14 بنجاح. سنقوم بمعالجته قريبًا.', 'order_created', '{\"order_id\": 14}', NULL, '2025-12-29 11:36:04', '2025-12-29 11:36:04'),
(13, 21, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 15 بنجاح. سنقوم بمعالجته قريبًا.', 'order_created', '{\"order_id\": 15}', NULL, '2025-12-29 19:25:57', '2025-12-29 19:25:57'),
(14, 21, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 16 بنجاح. سنقوم بمعالجته قريبًا.', 'order_created', '{\"order_id\": 16}', NULL, '2025-12-29 19:31:11', '2025-12-29 19:31:11'),
(15, 23, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 17 بنجاح. سنقوم بمعالجته قريبًا.', 'order_created', '{\"order_id\": 17}', NULL, '2026-01-06 20:41:17', '2026-01-06 20:41:17'),
(16, 24, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 18 بنجاح. سنقوم بمعالجته قريبًا.', 'order_created', '{\"order_id\": 18}', NULL, '2026-01-06 23:50:20', '2026-01-06 23:50:20'),
(17, 25, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 19 بنجاح. سنقوم بمعالجته قريبًا.', 'order_created', '{\"order_id\": 19}', NULL, '2026-01-07 13:09:11', '2026-01-07 13:09:11'),
(18, 7, 'تم استلام طلبك بنجاح', 'تم إنشاء طلبك رقم 20 بنجاح. سنقوم بمعالجته قريبًا.', 'order_created', '{\"order_id\": 20}', NULL, '2026-01-12 09:22:47', '2026-01-12 09:22:47');

--
-- Indexes for dumped tables
--

--
-- فهارس للجدول `about_us`
--
ALTER TABLE `about_us`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- فهارس للجدول `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- فهارس للجدول `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- فهارس للجدول `contact_us`
--
ALTER TABLE `contact_us`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `delivery_areas`
--
ALTER TABLE `delivery_areas`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `discount_coupons`
--
ALTER TABLE `discount_coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `discount_coupons_code_unique` (`code`);

--
-- فهارس للجدول `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- فهارس للجدول `iframe_settings`
--
ALTER TABLE `iframe_settings`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- فهارس للجدول `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- فهارس للجدول `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  ADD KEY `idx_mhr_role_model` (`role_id`,`model_type`,`model_id`);

--
-- فهارس للجدول `offer_banners`
--
ALTER TABLE `offer_banners`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_discount_coupon_id_foreign` (`discount_coupon_id`),
  ADD KEY `orders_delivery_area_id_foreign` (`delivery_area_id`);

--
-- فهارس للجدول `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- فهارس للجدول `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- فهارس للجدول `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_order_id_foreign` (`order_id`),
  ADD KEY `payments_reviewed_by_foreign` (`reviewed_by`),
  ADD KEY `payments_status_index` (`status`);

--
-- فهارس للجدول `payments_legacy`
--
ALTER TABLE `payments_legacy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_user_id_foreign` (`user_id`);

--
-- فهارس للجدول `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`),
  ADD KEY `idx_permissions_name` (`name`);

--
-- فهارس للجدول `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- فهارس للجدول `privacy_policy`
--
ALTER TABLE `privacy_policy`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_code_unique` (`code`),
  ADD KEY `products_type_id_foreign` (`type_id`);

--
-- فهارس للجدول `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `product_steps`
--
ALTER TABLE `product_steps`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_steps_product_id_step_number_unique` (`product_id`,`step_number`);

--
-- فهارس للجدول `product_types`
--
ALTER TABLE `product_types`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `returns_policy`
--
ALTER TABLE `returns_policy`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- فهارس للجدول `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `idx_rhp_role` (`role_id`),
  ADD KEY `idx_rhp_perm` (`permission_id`);

--
-- فهارس للجدول `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- فهارس للجدول `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `shipping_info`
--
ALTER TABLE `shipping_info`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `store_info`
--
ALTER TABLE `store_info`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- فهارس للجدول `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_notifications_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `about_us`
--
ALTER TABLE `about_us`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `contact_us`
--
ALTER TABLE `contact_us`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `delivery_areas`
--
ALTER TABLE `delivery_areas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `discount_coupons`
--
ALTER TABLE `discount_coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `iframe_settings`
--
ALTER TABLE `iframe_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `offer_banners`
--
ALTER TABLE `offer_banners`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payments_legacy`
--
ALTER TABLE `payments_legacy`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT for table `privacy_policy`
--
ALTER TABLE `privacy_policy`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_steps`
--
ALTER TABLE `product_steps`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product_types`
--
ALTER TABLE `product_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `returns_policy`
--
ALTER TABLE `returns_policy`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `shipping_info`
--
ALTER TABLE `shipping_info`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `store_info`
--
ALTER TABLE `store_info`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- القيود المفروضة على الجداول الملقاة
--

--
-- قيود الجداول `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_delivery_area_id_foreign` FOREIGN KEY (`delivery_area_id`) REFERENCES `delivery_areas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_discount_coupon_id_foreign` FOREIGN KEY (`discount_coupon_id`) REFERENCES `discount_coupons` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `payments_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- قيود الجداول `payments_legacy`
--
ALTER TABLE `payments_legacy`
  ADD CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- قيود الجداول `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `product_types` (`id`) ON DELETE SET NULL;

--
-- قيود الجداول `product_steps`
--
ALTER TABLE `product_steps`
  ADD CONSTRAINT `product_steps_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD CONSTRAINT `user_notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
