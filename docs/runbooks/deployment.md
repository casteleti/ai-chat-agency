# Runbook — Deployment

Preconditions: approved commit/images, all release gates green, staging exact images healthy, migration reviewed, backup freshness/restore drill valid, rollback digests known, flags safe-off, change owner/on-call present.

1. Record current versions/config/migration and metrics baseline.
2. Create/verify pre-deploy database backup when migration policy requires.
3. Deploy migration job with advisory lock; stop on error and preserve logs.
4. Deploy API/worker/web/admin exact signed digests with flags disabled for new risk.
5. Run `/health`/`/ready`, anonymous conversation, deterministic fake/limited live model, RAG citation, CRM/calendar read, queue and admin smoke.
6. Enable flags in planned increments; watch 5xx, latency, schema/tool failures, queue, DB, cost, funnel for 30 minutes.
7. Record release evidence and announce completion.

Abort/rollback on readiness failure, migration error, security/tenant anomaly, >2% 5xx, sustained SLO burn, duplicate write, schema failure >1%, or cost breaker. Use rollback runbook; never improvise destructive DB rollback.
