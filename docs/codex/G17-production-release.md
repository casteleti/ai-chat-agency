# G17 — Production Deployment and Release

## Objective

Deploy the outstanding but bounded MVP safely, validate live providers, and produce release/rollback evidence.

## Read First

G16 complete evidence, deployment/topology/CI/CD, all runbooks, DoD, risk/traceability/implementation matrices.

## Scope

Provision/harden Cloudflare/Hetzner/Caddy/networks/volumes/backups; deploy signed exact images; production secrets/roles; migrate/bootstrap agency database; load reviewed public knowledge; configure one CRM/calendar/email/observability; keep flags safe-off; live read/write validation with test records and cleanup policy; smoke; staged flag enable; dashboards/alerts/on-call; privacy/legal artifacts; release tag/changelog/status.

## Files

Production IaC/config references (no secrets), Compose/digests, deployment records, smoke scripts, backup schedules, runbook/operator/on-call docs, release evidence under CI artifacts.

## Constraints

No public DB/Redis/admin bypass. No flag enabled before dependent live evidence. No real client data in test. Do not claim HA on single host. Production model/CRM/calendar writes require explicit owner authorization and scoped credentials.

## Tests/Commands

Pipeline production job; migration/readiness; public pt/en conversation, RAG/citation, opportunity/brief/qualification, identity, CRM sync, calendar booking, support/handoff, admin/audit; rollback rehearsal/flag kill; backup freshness and monitoring alerts. Never expose test contact externally without controlled address.

## Acceptance Criteria

All G0–G16 evidence complete; live smoke passes; backups/alerts/on-call active; privacy/security review signed; flags/config documented; rollback exact; 30-minute observation healthy; release meets DoD and PROJECT thresholds.

## Completion Report

Use CODEX format plus deployed commit/image digests, migration/config revisions, URLs (no secrets), live test entity cleanup/reference, dashboard/backup evidence and final `CODEX IMPLEMENTATION READINESS: PRODUCTION MVP LIVE` only if every criterion passes.
