# Production Infrastructure

## Recommended launch topology

For an initial low-volume launch, use three failure boundaries:

- APP-01: 8 vCPU, 16 GB RAM, 160+ GB NVMe; Caddy, web, admin, API, worker. No public Docker ports except Caddy origin ports restricted to Cloudflare and SSH restricted to Tailscale/admin IP.
- DB-01: 4–8 vCPU, 16 GB RAM, 160+ GB NVMe; PostgreSQL and Redis on private network only. Separate encrypted database volume.
- Observability: managed Langfuse/Sentry/PostHog or a separate small host; do not colocate a full observability stack with the launch database.

Single-host developer/demo deployment is allowed but is not highly available and must be labeled. Production may temporarily use one host only when traffic/risk is low, off-host backups and restore are proven, and downtime is accepted in the risk register.

## Scale topology

Add APP-02 behind Cloudflare Load Balancing or an origin load balancer; run stateless web/API on both, workers with bounded concurrency, and keep DB-01 private. Add a PostgreSQL standby/read replica when RTO/read load warrants it. Do not introduce Kubernetes; Compose/Ansible-style deployment remains adequate until more than a handful of nodes or independent services exist.

## Containers

| Container | Network | Persistent volume | Limits/health |
|---|---|---|---|
| caddy | edge + frontend | config/certs | `/health` proxy, 0.5 CPU/256 MB baseline |
| web | frontend | none | HTTP health; 1 CPU/1 GB baseline |
| admin | frontend | none | HTTP health; 0.5 CPU/768 MB |
| api | frontend + backend | none | `/health`,`/ready`; 2 CPU/2 GB |
| worker | backend | none | heartbeat/job lag; 2 CPU/2 GB |
| postgres | data | encrypted DB volume | `pg_isready`; 4 CPU/8+ GB |
| redis | data | optional appendonly disabled unless separately justified | ping; 0.5 CPU/512 MB |

Use read-only root filesystems where compatible, non-root users, dropped capabilities, `no-new-privileges`, tmpfs `/tmp`, pinned image digests, log rotation, and explicit CPU/memory limits. Database is never exposed publicly.

## Backups and recovery

- PostgreSQL: daily encrypted base backup plus continuous WAL to independent object storage; 30 daily, 12 monthly retention. RPO ≤15 minutes, RTO ≤4 hours at MVP.
- R2: object versioning where supported/configured, lifecycle by data class; metadata DB remains necessary for recovery.
- Config: version-controlled non-secret configuration and encrypted off-host secrets recovery procedure.
- Restore: automated monthly restore into isolated environment; quarterly end-to-end recovery exercise; record duration, checksums, row/object counts and smoke tests.

## Networks and firewall

Cloudflare-to-origin only on 443; admin SSH through Tailscale with keys and no root/password login. App private subnet reaches DB. Egress is default-deny where operationally feasible, allow DNS/NTP, R2, approved AI/CRM/calendar/email/observability endpoints. Website analyzer uses a separate constrained fetcher network/policy and never reaches metadata/private ranges.

## Health

`/health` proves process/event loop alive. `/ready` proves validated critical config, database connectivity/migration compatibility, and ability to accept work. Redis/provider outages set degradation metrics but do not fail readiness unless the current deployment has explicitly made them critical. Worker exposes no public endpoint; it writes heartbeat and queue lag metrics.
