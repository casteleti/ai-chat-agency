# Containers and Deployment Specification

## Dockerfiles

G0/G17 create multi-stage `Dockerfile.web`, `.admin`, `.api`, `.worker` using pinned Node 24 LTS slim digest. Stages: base/Corepack → dependencies from lockfile → package-scoped build → minimal runtime. Runtime is non-root, read-only root FS, production dependencies/output only, init process, explicit `NODE_ENV`, labels with commit/build time/SBOM, no secrets or source maps publicly exposed. BuildKit cache is allowed; output must be reproducible.

## Compose

- `compose.dev.yml`: PostgreSQL 18.6+pgvector, Redis 8.2, Mailpit/fake adapters, API/worker/web/admin with source mounts and health dependencies; loopback ports only; deterministic named volumes.
- `compose.test.yml`: isolated ephemeral containers, fixed resources, no external vendor calls.
- `compose.production.yml`: images by immutable digest, external secret/env files created on host, private `frontend/backend/data` networks, restart policies, resource limits, health checks, log rotation, read-only/tmpfs/cap drops, no database/Redis public ports.

Compose must not contain secret values. Environment interpolation validates required variables before deployment. Database migration is a one-shot image command with advisory lock, not API startup magic.

## Delivery

GitHub Actions builds once, scans/tests, signs image/SBOM, pushes registry, deploys exact digests to staging, runs migration then smoke, requires approval, deploys production with rolling API/web replacement where two nodes exist, and verifies smoke/metrics. If one node, use short maintenance-safe replacement; never run incompatible app before migration.

Rollback: redeploy prior image digests if schema remains backward compatible. Destructive/schema contract migrations are never in the same release that removes compatibility. Flags can disable AI/tools/writes independently. Production deployment record includes commit, images, migration ledger, config revision, smoke results and operator.

## Caddy/Cloudflare

Caddy routes `/v1/*`, `/health`, `/ready` to API; admin on separate hostname with access policy; public site/web elsewhere. Preserve SSE (no buffering, adequate idle timeout), request IDs and only trusted proxy IP headers. Cloudflare caches immutable assets/site pages but never auth/API/SSE/private responses. CSP/reporting, HSTS, `nosniff`, referrer and permissions policies are set at origin/edge consistently.
