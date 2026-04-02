<div align="center">

# 🤖 KuruAi
### AI Chat & Image Generation Web App
**v4.0.0** · Built with PHP + Groq API

![PHP](https://img.shields.io/badge/PHP-8.x-777BB4?style=for-the-badge&logo=php)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql)
![Groq](https://img.shields.io/badge/Groq-LLaMA%203-F54B27?style=for-the-badge)
![License](https://img.shields.io/badge/License-Personal-purple?style=for-the-badge)

*A personal AI assistant web platform powered by Groq LLaMA, with image generation, subscription tiers, OTP login, and a full admin dashboard.*

</div>

---

## 📌 About

**KuruAi** is a self-hosted AI chat website built in pure PHP. It uses the Groq API (LLaMA 3.3 / LLaMA 4) as its AI backbone, supports text and image (vision) input, and includes a built-in image generation feature via Pollinations.ai. The site is themed around a virtual AI persona named **Kurumi** with a purple/pink aesthetic.

This project was developed as a solo personal project by **Riel Akuonza**, running locally on Laragon (Windows) with a MySQL database.

---

## ✨ Features

### 💬 AI Chat
- Multi-session chat with persistent history (up to 30 messages context)
- Vision support — upload and analyze images in chat
- Nickname system — users can set a custom nickname recognized by the AI
- AI persona system with different response styles for admin vs regular users

### 🎨 Image Generation
- Generate AI images from text prompts (Pollinations.ai)
- Real-time image gallery with saved history per user
- Lexica.art integration for prompt inspiration

### 👤 User System
- OTP-based email login/registration (via Brevo SMTP)
- Subscription tiers: **Free**, **Premium**, **VIP**
- User profile with customizable display name, border color, and nickname
- Ban system managed by admin

### 🏪 Shop & Promo
- Native product card grid (links to external store)
- WhatsApp CTA, Instagram, and Lynk.id integration

### 🛠 Admin Dashboard
- Full user management (ban, unban, change tier)
- Activity log & audit trail
- Inbox / messaging system to broadcast messages to users
- Changelog management

### 💳 Payment
- Duitku payment gateway integration (supports Sandbox & Production)
- Manual payment via WhatsApp fallback

---

## 🧱 Tech Stack

| Layer | Technology |
|---|---|
| Backend | PHP 8.x (pure, no framework) |
| Database | MySQL 8.0 via PDO |
| Local Dev | Laragon (Windows) |
| AI — Chat | [Groq API](https://console.groq.com) — `llama-3.3-70b-versatile` |
| AI — Vision | Groq API — `meta-llama/llama-4-scout-17b-16e-instruct` |
| Image Gen | [Pollinations.ai](https://pollinations.ai) (free, no key needed) |
| Image Search | [Lexica.art](https://lexica.art) |
| Email / OTP | [Brevo](https://brevo.com) (SMTP API) |
| Payment | [Duitku](https://duitku.com) Payment Gateway |
| Fonts | Sora, DM Sans (Google Fonts) |
| Icons | Flaticon |

---

## 📁 Project Structure

```
KuruAi/
├── config.php             # ⚠️ NOT included — use config.example.php
├── config.example.php     # Template konfigurasi (safe to commit)
├── db.php                 # Database connection & schema init
├── functions.php          # Core helpers (auth, OTP, AI calls)
├── api.php                # AJAX endpoint (chat, image gen, inbox, etc.)
├── index.php              # Landing / redirect
├── login.php              # Login + OTP flow
├── register.php           # Registration + OTP verification
├── chat.php               # Main chat UI
├── imagine.php            # Image generation page
├── profile.php            # User profile settings
├── pricing.php            # Subscription plans page
├── checkout.php           # Payment checkout
├── payment_finish.php     # Payment success handler
├── payment_callback.php   # Duitku webhook
├── payment_error.php      # Payment failure page
├── shop.php               # Product showcase
├── about.php              # About / features page
├── admin.php              # Admin dashboard
├── logout.php             # Session destroy
├── duitku_helper.php      # Duitku API helper
├── test_api.php           # Dev utility (remove in production)
├── kuruai.sql             # Full DB schema + migration
├── new.sql                # Additional migrations
├── assets/
│   ├── kurumi.png         # AI persona avatar
│   ├── kurumi.ico         # Favicon
│   └── benner.png         # Site banner
├── includes/
│   ├── sidebar.php        # Desktop sidebar component
│   ├── mobile_nav.php     # Mobile navigation
│   └── styles.php         # Global CSS (purple/pink theme)
└── data/
    └── images/            # Saved generated images (protected)
```

---

## 🔌 External APIs Used

### 1. Groq API
- **URL:** `https://api.groq.com/openai/v1/chat/completions`
- **Purpose:** Powers the AI chat (text & vision)
- **Models:** `llama-3.3-70b-versatile` (chat), `meta-llama/llama-4-scout-17b-16e-instruct` (vision)
- **Docs:** https://console.groq.com/docs

### 2. Pollinations.ai
- **URL:** `https://image.pollinations.ai/prompt/{prompt}`
- **Purpose:** Free AI image generation, no API key required
- **Docs:** https://pollinations.ai

### 3. Lexica.art
- **URL:** `https://lexica.art`
- **Purpose:** Image prompt search / inspiration gallery
- **Docs:** https://lexica.art/docs

### 4. Brevo (Sendinblue)
- **Purpose:** Transactional email for OTP delivery
- **Method:** REST API (`POST /v3/smtp/email`)
- **Docs:** https://developers.brevo.com

### 5. Duitku
- **Purpose:** Indonesian payment gateway (supports VA, QRIS, etc.)
- **Docs:** https://docs.duitku.com

---

## 🗄 Database Schema (Overview)

| Table | Purpose |
|---|---|
| `users` | User accounts, roles, subscription tier |
| `user_nicknames` | Custom AI nicknames per user |
| `chat_sessions` | Chat session containers per user |
| `chat_messages` | Message history (user + assistant + system) |
| `generated_images` | AI image generation history |
| `admin_accounts` | Admin credentials (synced from config) |
| `inbox_messages` | Admin → User messaging system |
| `activity_log` | Audit trail for all key actions |
| `changelogs` | Version/update history |
| `subscriptions` | Payment & subscription records |
| `otp_codes` | Temporary OTP for login/register |

---

## ⚙️ Installation (Local / Laragon)

### Requirements
- PHP 8.x
- MySQL 8.0
- Laragon (or any local PHP server)
- Composer (optional, not required)

### Steps

**1. Clone / copy project**
```bash
git clone https://github.com/yourusername/KuruAi.git
# Place in Laragon's www folder: C:/laragon/www/KuruAi
```

**2. Import database**
```sql
-- In HeidiSQL or phpMyAdmin:
CREATE DATABASE kurulai;
-- Then import kuruai.sql
```

**3. Configure**
```bash
cp config.example.php config.php
# Edit config.php with your API keys, DB credentials, etc.
```

**4. Set up API keys**

You'll need:
- A [Groq API Key](https://console.groq.com) → set as `GROK_API_KEY`
- A [Brevo API Key](https://brevo.com) → set as `BREVO_API_KEY`
- A [Duitku account](https://duitku.com) → set `DUITKU_MERCHANT_CODE` and `DUITKU_API_KEY`

**5. Done!**
Visit `http://localhost/KuruAi` in your browser.

---

## 🔐 Security Notes

- `config.php` is **gitignored** — never commit it
- The `data/` folder is protected via `.htaccess` (no direct URL access)
- OTP codes expire after 10 minutes
- Passwords are hashed with `password_hash()` (bcrypt)
- All DB queries use PDO prepared statements

---

## 📊 Subscription Tiers

| Feature | Free | Premium | VIP |
|---|---|---|---|
| Chat / day | 60 | 120 | Unlimited |
| Image gen / day | 5 | 20 | Unlimited |
| Vision (image input) | ✅ | ✅ | ✅ |
| Priority support | ❌ | ✅ | ✅ |

---

## 🎨 UI Theme

- **Color scheme:** Purple (`#7C3AED`) + Pink accent
- **Fonts:** Sora (headings), DM Sans (body)
- **Icons:** Flaticon
- **AI Persona:** Kurumi Tokisaki (anime aesthetic)
- **Responsive:** Mobile-friendly with dedicated mobile nav

---

## 📝 Changelog

See [`CHANGELOG.md`](CHANGELOG.md) for version history.

---

## 👤 Author

**Riel Akuonza** — [@rebornstore.id99](https://instagram.com/rebornstore.id99)

> Built as a personal project. Not open for public contributions.

---

<div align="center">
  <sub>Made with 💜 · KuruAi v4.0.0</sub>
</div>
