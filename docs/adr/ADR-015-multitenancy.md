# ADR-015 — Tenant-Ready Shared Schema

Status: Accepted — 2026-09-02

## Context

The agency is the only initial tenant, but the core may become a sellable concierge. Retrofitting tenant boundaries later is dangerous; building a full SaaS control plane now is wasteful.

## Decision

Use non-null `tenant_id` on central domain/config/knowledge/integration rows, tenant-required repositories, composite constraints, tenant-specific prompt/knowledge/config versions and isolation tests. Do not build billing, provisioning, white label, per-tenant databases or infrastructure.

## Alternatives

Single-tenant schema then migrate; schema/database per tenant; full SaaS platform now.

## Consequences

Cheap safety and productization path with modest query/index overhead. One seed creates the agency tenant.

## Risks

Cross-tenant bugs and premature generic abstractions. Mitigate with mandatory context, RLS defense-in-depth, tests, code review and classification of core/agency/integration/config code.
