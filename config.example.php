<?php
// ================================================
//  KuruAi — Konfigurasi Utama v4.0
//  Salin file ini menjadi config.php dan isi nilainya
// ================================================

define('SITE_NAME',    'KuruAi');
define('SITE_TAGLINE', 'Asisten AI · Your Name');
define('SITE_VERSION', '4.0.0');
define('SITE_RELEASE', '2025-01-01');

// ── Admin Accounts ────────────────────────────────
define('ADMIN_ACCOUNTS', [
    [
        'key'      => 'admin1',
        'name'     => 'Admin Name',
        'password' => 'your_secure_password_here',
    ],
]);

// ── Groq API ──────────────────────────────────────
define('GROK_API_KEY',      'gsk_YOUR_GROQ_API_KEY_HERE');
define('GROK_API_URL',      'https://api.groq.com/openai/v1/chat/completions');
define('GROK_MODEL_CHAT',   'llama-3.3-70b-versatile');
define('GROK_MODEL_VISION', 'meta-llama/llama-4-scout-17b-16e-instruct');

// ── Image Generation — Pollinations.ai ──────────
define('IMG_GEN_BASE', 'https://image.pollinations.ai/prompt/');

// ── Database MySQL ────────────────────────────────
define('DB_HOST', 'localhost');
define('DB_PORT', '3306');
define('DB_NAME', 'kurulai');
define('DB_USER', 'root');
define('DB_PASS', 'your_db_password');

// ── Brevo SMTP (OTP Email) ────────────────────────
define('BREVO_API_KEY',    'xkeysib-YOUR_BREVO_API_KEY_HERE');
define('BREVO_FROM_EMAIL', 'yourmail@example.com');
define('BREVO_FROM_NAME',  'KuruAi');

// ── Sosial & Link ─────────────────────────────────
define('PROMO_INSTAGRAM', 'your_instagram_handle');
define('PROMO_LYNK',      'https://lynk.id/your_profile');
define('PROMO_WHATSAPP',  'https://wa.me/62XXXXXXXXXX?text=Halo+KuruAi!');

// ── Duitku Payment Gateway ────────────────────────
define('DUITKU_MERCHANT_CODE', 'YOUR_MERCHANT_CODE');
define('DUITKU_API_KEY',       'YOUR_DUITKU_API_KEY');
define('DUITKU_IS_PRODUCTION', false); // false = Sandbox, true = Production

// ── Harga Langganan (dalam Rupiah) ────────────────
define('PRICE_PREMIUM', 12000);  // Rp 12.000/bulan
define('PRICE_VIP',     35000);  // Rp 35.000/bulan

// ── Batas Penggunaan per Tier ─────────────────────
define('LIMIT_FREE_CHAT',    60);
define('LIMIT_PREMIUM_CHAT', 120);
define('LIMIT_FREE_IMG',     5);
define('LIMIT_PREMIUM_IMG',  20);
define('LIMIT_VIP_IMG',      999);
