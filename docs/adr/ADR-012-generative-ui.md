# ADR-012 — Schema-Driven Generative UI

Status: Accepted — 2026-09-02

## Context

Rich progressive cards are a core differentiator, but arbitrary model-generated code creates XSS, broken layouts and unauthorized actions.

## Decision

The model emits a versioned discriminated JSON union. Zod validates it; the server applies policy/data references; the client registry renders only approved React components. Actions reference server-issued action IDs, never URLs or arbitrary handlers.

## Alternatives

Text bubbles only; model-generated JSX/HTML; remote micro-frontends.

## Consequences

Safe, testable and accessible UI with bounded creativity. New component types require schema, renderer, analytics, accessibility and E2E changes.

## Risks

Schema bloat or repetitive design. Mitigate with composable data contracts, presentation variants controlled by design tokens, component budget and version migration.
