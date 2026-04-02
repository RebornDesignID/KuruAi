# 🏗 KuruAi — Architecture Overview

## Request Flow

```
Browser
  │
  ├─ GET  *.php              → Page render (chat.php, imagine.php, etc.)
  │
  └─ POST api.php?action=... → JSON API (AJAX)
            │
            ├── chat            → Groq LLaMA API → response
            ├── generate_image  → Pollinations.ai → image URL
            ├── new_session     → MySQL insert
            ├── load_session    → MySQL fetch
            ├── get_inbox       → MySQL fetch (admin messages)
            └── ...
```

## Authentication Flow

```
User visits login.php
  → Enter email
  → OTP sent via Brevo API
  → User enters 6-digit OTP
  → Session created (PHP session)
  → Redirect to chat.php
```

## Chat Message Flow

```
User types message
  → POST api.php?action=chat
    → Check session ownership (MySQL)
    → Check daily usage limit (by tier)
    → Load last 30 messages for context
    → Build system prompt (with nickname & role)
    → Call Groq API (text or vision model)
    → Save user + assistant messages to DB
    → Return JSON response
  → JS appends message to chat UI
```

## Image Generation Flow

```
User types prompt on imagine.php
  → POST api.php?action=generate_image
    → Check image gen limit (by tier)
    → Build Pollinations.ai URL
    → Save URL to generated_images table
    → Return image URL
  → JS renders image in gallery
```

## Subscription Tiers

```
Free    → 60 chats/day,  5 images/day
Premium → 120 chats/day, 20 images/day
VIP     → Unlimited chat & images
```

Upgrades are handled via Duitku payment gateway with webhook callback to `payment_callback.php`.

---

## Key PHP Files

| File | Role |
|---|---|
| `config.php` | All constants (API keys, limits, prices) |
| `db.php` | PDO connection + schema auto-init + admin sync |
| `functions.php` | Auth, OTP, Groq API caller, DB helpers |
| `api.php` | Single AJAX entry point (switch on `action`) |
| `duitku_helper.php` | Duitku payment API wrapper |
