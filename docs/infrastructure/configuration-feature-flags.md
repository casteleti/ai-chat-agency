# Typed Configuration, Secrets and Feature Flags

One `packages/config` module defines Zod schemas for `webPublic`, `api`, `worker`, `admin`, and test config. It reads environment once at process start, trims/normalizes, rejects unknown critical enum values, validates URLs/origins/timezones/key lengths and fails fast with variable names but never values. Browser exposure requires explicit `NEXT_PUBLIC_*` mapping and build-time review.

Precedence: hard-coded safe defaults (non-secret) < checked-in environment profile < runtime environment/secrets < tenant database settings/flags for allowed keys. A tenant flag cannot enable a capability whose global operational flag is off. Secrets never reside in tenant JSON.

## Flags

| Flag | MVP default | Dependency/kill behavior |
|---|---:|---|
| `AI_CHAT_ENABLED` | false until G17 | false shows static/human contact; no generation route |
| `NEW_BUSINESS_ENABLED` | false | no commercial role/tools |
| `SUPPORT_ENABLED` | false | no support submission route |
| `GENERATIVE_UI_ENABLED` | false | text-only safe descriptors |
| `WEBSITE_ANALYSIS_ENABLED` | false | analyzer route/tool denied |
| `HUMAN_HANDOFF_ENABLED` | false | persist static contact path only |
| `CRM_WRITES_ENABLED` | false | canonical writes allowed, sync jobs not dispatched |
| `CALENDAR_WRITES_ENABLED` | false | availability/booking disabled; capture intent |
| `FILE_UPLOAD_ENABLED` | false MVP | upload routes and signing absent/denied |
| `VOICE_ENABLED` | false | no microphone/media permission/UI |
| `WHATSAPP_ENABLED` | false | no adapter/webhook/send |

Flags have owner, reason, created/expiry review, environment and tenant scope, audit and metrics. Security/authorization is never only a flag. Remove stale flags within two releases after full rollout.

## Secret lifecycle

Generate ≥256-bit application secrets; separate per environment/provider/purpose; encrypt integration credentials with versioned envelope key; least scopes; rotation supports current+previous decrypt/verification windows; revoke old after validation. GitHub environments and host secret files are access-controlled; SOPS/age may store only encrypted configuration. Quarterly rotation and immediate incident rotation; scan repository/history/images/logs.
