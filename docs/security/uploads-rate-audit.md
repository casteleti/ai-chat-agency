# Upload, Rate Limit and Audit Policies

## File uploads (V1; disabled MVP)

Allowed: PDF, DOCX, XLSX/CSV, PNG, JPEG, WebP, plain text/Markdown; no archives, executables, macros, SVG/HTML, audio/video until separately designed. Default max 10 MB/file, 5 files/conversation, PDF ≤100 pages, spreadsheet ≤20 sheets/100k cells, image ≤25 MP. Verify declared MIME, magic bytes and extension; normalize filename; compute SHA-256.

Flow: presigned single-purpose upload → private quarantine prefix → verify size/checksum/MIME → malware scan/parser safety checks → mark CLEAN → move/logical promote → short signed read URL to authorized server/user. Model/parser access only after CLEAN. URLs expire ≤5 minutes. Delete quarantine failures within 24 hours; default conversation retention governs clean files. Parser runs with CPU/memory/time limits, no network, no macros/external links.

## Rate limits baseline

| Scope | Limit |
|---|---|
| conversation start | 10/IP/hour, 5/visitor/hour |
| messages | 30/visitor/hour, burst 5/min; authenticated 120/hour |
| concurrent AI runs | 1/conversation, 2/visitor, 5/auth user; global breakers |
| SSE | 2/conversation, 5/IP; idle heartbeat 20 s, max run 120 s |
| website analysis | 3/visitor/day, 20/day global |
| identity challenge | 5/IP/hour, 3/address/hour with uniform response |
| meeting slot reads | 20/visitor/hour; booking 5/day |
| support/handoff writes | 5/visitor/day plus dedupe |
| upload | 50 MB/day visitor, 250 MB/day authenticated, plus file limits |
| admin API | 300/user/5 min; exports stricter/asynchronous |

Use Cloudflare coarse IP/bot controls and Redis sliding/token buckets keyed by actor+route; hash IP with rotating salt. If Redis is down, use conservative in-process/IP edge limit and emit degraded metric. `Retry-After` required.

## Audit

Audit meaningful writes, auth/session/security events, consent, private/privileged reads, tool policy/confirmation/execution, prompt/agent/knowledge publish, flags/settings, integrations/secrets, staff takeover, export/deletion. Record timestamp, actor type/ID, action, resource, request/correlation, redacted before/after, tool/agent/model/version, result and IP hash. Never record secret values, full tokens, payment data or duplicate full conversation unnecessarily.

App role can insert but not update/delete audit rows. Security exports append to off-host protected storage; daily integrity/checksum job alerts gaps. Retain security/admin audit 24 months unless legal policy changes; access is OWNER/authorized security only and itself audited.
