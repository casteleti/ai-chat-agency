# ADR-007 — Single Orchestrator, Logical Roles

Status: Accepted — 2026-09-02

## Context

The concept spans concierge, new business and support, but an agent swarm would multiply latency, cost, context inconsistency and debugging complexity.

## Decision

Implement one conversation orchestrator with versioned logical role configurations (`CONCIERGE`, `NEW_BUSINESS`, `SUPPORT`). Interpretation and drafting may use models; permissions, calculations, state invariants and side effects remain deterministic services/tools.

## Alternatives

Multi-agent supervisor/swarm; fixed funnel; separate deployed agents.

## Consequences

One trace and authoritative state per turn, easier evals and handoff. Roles may become separate only after measured specialization requires it.

## Risks

An oversized prompt/orchestrator. Mitigate with prompt composition, capability-specific services, token budgets, typed state and task-scoped model calls.
