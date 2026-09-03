# ADR-003 — Fastify Backend

Status: Accepted — 2026-09-02

## Context

Conversation streaming, domain orchestration, auth, integrations, webhooks, and workers need a stable boundary independent of website rendering.

## Decision

Use Fastify 5 on Node 24 LTS for a versioned REST API plus SSE. Share Zod contracts through packages. Keep all backend domains in TypeScript.

## Alternatives

Next.js route handlers only; NestJS; FastAPI/Python; GraphQL.

## Consequences

Clear BFF/domain boundary, low overhead, unified language and independent API scaling. More deployment surface than Next-only, but materially better lifecycle isolation.

## Risks

Contract drift between Zod, Fastify and OpenAPI. Mitigate with generated specs, contract snapshots, runtime validation, and CI diff checks.
