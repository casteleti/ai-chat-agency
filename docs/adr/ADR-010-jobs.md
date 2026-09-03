# ADR-010 — pg-boss Jobs; Redis Ephemeral

Status: Accepted — 2026-09-02

## Context

Ingestion, summaries, CRM/calendar sync, notifications and retries need durable work. Adding a durable Redis or workflow platform is unnecessary initially.

## Decision

Use pg-boss in PostgreSQL with versioned idempotent job handlers, bounded concurrency, retries/backoff and dead-letter review. Use Redis only for disposable counters/locks/coordination.

## Alternatives

BullMQ, Temporal, Trigger.dev, Inngest, in-process queues.

## Consequences

Transactional enqueue and simpler infrastructure. Database capacity includes job load and cleanup.

## Risks

Long/heavy jobs can affect OLTP. Mitigate with queues, priorities, concurrency, timeouts, archival and later extraction threshold.
