# G2 — Database, Migrations and Outbox

## Objective

Create the transactional persistence foundation and durable job/event mechanics.

## Read First

G1 evidence, ADR-004/006/010/017, `docs/database/*`, events/resilience, retention.

## Scope

Implement Drizzle schema for conceptual tables needed through MVP, PostgreSQL extensions/constraints/indexes/RLS defense, repository transaction primitives, migrations, idempotency store, outbox/consumer receipts, pg-boss bootstrap/worker lifecycle, deterministic seeds and DB test factories. Defer V1-only tables only if migrations preserve named contracts and gate documents record them.

## Files

`packages/database/src/schema/*`, repositories/base/transactions, migrations, seed, test helpers; `packages/domain-events`; worker queue/outbox skeleton; DB commands and migration CI.

## Constraints

UUIDv7; timestamptz; JSON schemaVersion; money invariant. App and migrator DB roles separate. Redis not durable. Migration forward-only.

## Tests/Commands

Clean/previous migration, seed rerun, repository/RLS, FK/check/unique, transaction rollback, idempotency body conflict, outbox atomicity, duplicate consumer, worker crash/lease. `pnpm db:migrate db:seed db:check test:integration verify`.

## Acceptance Criteria

Schema matches blueprint or documented accepted decision; important write+outbox atomic; job replay safe; migrations validated clean and upgrade; EXPLAIN evidence for core access paths.

## Completion Report

Include migration IDs, schema deviations/reasons, test DB version/extension and row/isolation evidence.
