# Health, SLOs and Operations Dashboard

## Health endpoints

`GET /health`: 200 if process/event loop is alive; no dependency calls and no sensitive details. `GET /ready`: 200 only if typed critical config loaded, PostgreSQL query succeeds within 500 ms, migration version is compatible and process can accept work; 503 with coarse component codes. Redis/AI/CRM/calendar/R2/analytics are optional/degraded unless the current route requires them and never expose credentials/URLs. Endpoints are rate limited and cache disabled.

Worker heartbeat updates every 30 s with instance/version/queue claims; alert after 2 minutes. Readiness does not wait synchronously on AI vendor health.

## SLOs (monthly, MVP)

- Public site/launcher availability 99.9%.
- Conversation API availability 99.5%, excluding third-party model failure only when graceful fallback/static path remains.
- Non-AI API p95 <500 ms; message acceptance p95 <400 ms.
- First meaningful stream event p95 <2 s during healthy provider.
- Important job completion 99% within 5 min; handoff persistence 99.9%.
- Meeting duplicate/timezone correctness 100%.
- RPO ≤15 min, RTO ≤4 h.

Error budget burn alerts at 2× over 1 h and 1× over 6 h; feature rollout pauses on fast burn.

## Dashboard panels

Traffic/request/error/latency/SSE; app CPU/memory/event loop; DB connections/locks/replication/backups/slow queries; Redis health; queue depth/age/retries/dead letters; provider health/fallback; AI TTFT/latency/tokens/cost/schema; RAG latency/zero-results/citation; tool confirmations/denials/failures; funnel/MBC/meetings/handoffs/support; security limits/auth/SSRF/upload canary. Every panel filters environment/version without exposing content.
