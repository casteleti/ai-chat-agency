# ADR-001 — Modular Monolith

Status: Accepted — 2026-09-02

## Context

The product has several domains and asynchronous integrations but begins with one team, one tenant, modest traffic, and shared transactional workflows. Microservices would add distributed state, deployments, tracing, and failure modes before independent scaling or ownership exists.

## Decision

Use a TypeScript modular monolith in one monorepo with separately deployable web, admin, API, and worker processes; one PostgreSQL source of truth; bounded-context packages; transactional outbox; versioned jobs/events.

## Alternatives

Microservices; Next.js-only application; serverless functions; service-oriented hybrid from day one.

## Consequences

Fast local development, atomic writes, simple operations, and enforceable domain boundaries. API/worker can scale independently. Internal discipline and dependency checks are required to prevent a “big ball of mud.”

## Risks

One database can become a coupling/scaling point. Mitigate with ownership rules, explicit ports, query metrics, outbox, and extraction only after measured/organizational need.
