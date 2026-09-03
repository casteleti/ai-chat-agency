# ADR-016 — Postgres Contention Mitigation (OLTP + Vector + FTS + Jobs)

Status: Accepted — 2026-09-03

## Context

ADR-004 makes PostgreSQL the sole system of record for transactional business data plus pgvector and FTS. ADR-006 builds hybrid RAG (tsvector + pgvector HNSW + RRF) on that same instance. ADR-010 puts the durable job queue (pg-boss) on that same instance too. Each of those three ADRs independently names its own slice of the resulting contention risk against OLTP ("vector load can compete with OLTP," "long/heavy jobs can affect OLTP"), but none of them -- nor `docs/architecture/system-architecture.md`'s scaling guidance ("scale vertically first") -- reconciles all three running concurrently against the same latency-sensitive path: live conversation writes. None addresses I/O contention or autovacuum pressure from the high-churn `outbox_events`, pg-boss job tables and `product_events` competing with that path, and the extraction thresholds each ADR gestures at ("a documented extraction threshold") were never pinned to an actual number anywhere.

## Decision

Keep the single-instance design (no change to ADR-004/006/010). Add four concrete, numbered mitigations so this stays a monitored, accepted risk instead of a silent one:

1. **Connection pool partitioning.** Separate pooled connection limits per workload class (chat/OLTP write path, vector/FTS read path, pg-boss worker), even though all three share one physical instance, so one class cannot starve another under load.
2. **Autovacuum and retention on high-churn tables.** `outbox_events`, pg-boss's job tables and `product_events` get table-level autovacuum settings tuned more aggressively than the instance default, plus the archival/purge jobs already required by `docs/database/data-retention.md` and the outbox worker's own cleanup, so these tables stay small instead of accumulating bloat that degrades every other query on the instance.
3. **Numbered extraction triggers**, replacing the previously-unpinned "documented extraction threshold" language in ADR-004/006 with actual thresholds: read replica for analytics when OLTP p95 write latency degrades attributably to vector/FTS load; vector extraction to a dedicated store (Qdrant, per `docs/knowledge/knowledge-and-rag.md`'s existing ~5M-active-chunks threshold) when that threshold is hit *or* the retrieval p95 SLO breaches for consecutive monitoring windows, whichever comes first; job processing moves off the primary (separate Postgres role, still pg-boss) once sustained queue depth or table bloat crosses a defined line. Exact numeric values for the p95/queue-depth triggers are set during G2/G6 against real measured baselines, not guessed here.
4. **One consolidated observability panel** (ADR-011's stack) showing OLTP write latency, vector query latency, FTS query latency and pg-boss queue depth/age side by side, so contention between them is visible as a single view before it becomes an incident, not just each subsystem's own isolated metrics.

## Alternatives

Separate managed Postgres per workload from day one (rejected: premature operational cost for the "one team, modest traffic" scale ADR-001 targets at MVP). Move jobs to a Redis-backed queue (rejected already by ADR-010 for durability reasons -- unchanged here). External vector database from day one (rejected already by ADR-006 for operational simplicity -- unchanged here; this ADR only pins the threshold at which that decision should be revisited).

## Consequences

MVP ships on the single-instance design already decided elsewhere in this ADR set, now with explicit numbered triggers for when to split out each workload and a monitoring plan that surfaces the contention risk before it becomes an incident. This is documented, monitored risk acceptance with a plan, not silent risk acceptance.

## Risks

Threshold-based triggers are reactive, not predictive: a large knowledge re-ingestion job running during a peak-traffic window can still degrade OLTP before any automatic extraction trigger fires. Mitigate with a manual runbook lever (pause/deprioritize non-critical vector-indexing and job workloads on detected contention) rather than assuming the numbered triggers alone are sufficient during an active incident.
