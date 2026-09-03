# ADR-004 — PostgreSQL, Drizzle and pgvector

Status: Accepted — 2026-09-02

## Context

The product needs transactional business data, audit/outbox/jobs, full-text and vector retrieval, tenant filters, and flexible but controlled JSON payloads.

## Decision

PostgreSQL 18.6 is the system of record. Use Drizzle schema/queries and reviewed SQL migrations. Enable pgvector and PostgreSQL FTS; use UUIDv7, UTC timestamps, composite tenant constraints and selective RLS defense-in-depth.

## Alternatives

PostgreSQL plus separate Qdrant; Supabase platform; MongoDB; Prisma ORM.

## Consequences

Fewer services and strong consistency. Advanced vector/FTS queries use raw tested SQL. Major upgrades remain deliberate operations.

## Risks

Vector load can compete with OLTP. Mitigate through indexes, budgets, query timeouts, connection pools, metrics and a documented extraction threshold.
