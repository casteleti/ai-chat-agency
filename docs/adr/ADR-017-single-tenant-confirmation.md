# ADR-017 — Single-Tenant by Decision, Not by Omission

Status: Accepted — 2026-09-03
Supersedes: ADR-015

## Context

ADR-015 built a tenant-ready shared schema on the premise that "the core may become a sellable concierge." That premise has been checked directly with the product owner: Daksa confirmed there is no intention, present or future, to sell this system to third parties. The AI Business Concierge is single-use internal software for Daksa's own institutional website. There is one agency, one brand, one set of services, and no plan to onboard other client companies as tenants of this system.

Multi-tenancy is only cheap insurance if the risk it insures against is real. Here it is not: it added a `tenant_id` column and composite `(tenant_id, id)` key to 45 of 49 tables, a mandatory `TenantContext` on every repository call, tenant-isolation acceptance criteria on the first two implementation gates (G2, G3), and a recurring "cross-tenant leak" test/alert category across security, testing, and operations docs — all defending a boundary that will never be crossed.

## Decision

Remove multi-tenancy from the blueprint. Specifically:

- Drop the `tenants` and `tenant_settings` tables and the `tenant_id` column from every table in `docs/database/schema.sql`; revert composite `(tenant_id, x)` foreign keys and unique constraints to simple `(x)` forms.
- Replace `tenant_settings` with `app_settings`, a single-row global configuration table (`id boolean PRIMARY KEY DEFAULT true CHECK (id)`), so agency-wide configuration (e.g. qualification thresholds) keeps the same `settings jsonb` shape it had under `tenant_settings.settings`, only without a tenant key.
- Remove the mandatory `TenantContext` repository parameter and the "no tenant-agnostic code" rule from `ARCHITECTURE.md`.
- Remove the tenant dimension from `docs/security/authorization-matrix.md`; keep role × resource × state.
- Remove tenant-scoped RLS policies and tenant-isolation acceptance criteria from G2/G3 and the RLS guidance in `docs/database/migrations-and-seeds.md`. Where RLS still has a purpose unrelated to tenancy (see Consequences), keep only that part.
- Remove `tenantId` and other tenant-shaped fields from the event envelope, idempotency keys, circuit breakers, RAG filters, and the other ~50 secondary references catalogued in the pre-decision diagnostic.
- Deprecate `docs/product/admin-and-productization.md`'s productization section, since the three-external-clients threshold it defined no longer applies to any live roadmap.

## Alternatives considered

- **Keep tenant-ready schema as cheap future insurance.** Rejected: the product owner explicitly ruled out the scenario it insures against, so the "cheap" premium is being paid against a closed risk, not a live one.
- **Leave it half-removed (schema simplified, docs untouched).** Rejected: inconsistent docs would mislead whoever implements G2/G3 next; the diagnostic exists precisely so the removal can be complete and traceable.

## Consequences

- Every table loses its `tenant_id` column and composite key; queries, indexes, and FKs simplify to single-column forms.
- G2/G3 lose an entire acceptance-test category (tenant A/B isolation); their remaining criteria (transactional integrity, outbox atomicity, deny-by-default resource authorization) are unaffected and are rewritten to stand alone.
- RLS is kept only where it defends a boundary that still exists (e.g. separating staff-authenticated queries from anonymous-visitor queries on sensitive tables), not as a tenant boundary. If no such use survives review during G2, RLS may be dropped entirely from the MVP without violating this ADR.
- `docs/product/admin-and-productization.md` no longer describes a live path; it is marked deprecated rather than deleted, so the reasoning is preserved if circumstances change.
- If Daksa's plans change later and the system is ever offered to other companies, tenancy must be reintroduced deliberately via a new ADR — this is a structural migration (see the retrofit-cost analysis in the pre-decision diagnostic), not a config flag, and should be scoped as its own project phase rather than assumed as "already built in."

## Risks

Reintroducing multi-tenancy later, if it ever becomes necessary, costs materially more once application code exists (schema migration, repository rewrites, auth middleware rewrite) than it would have cost to keep now. This ADR accepts that risk as smaller than the ongoing cost of building and testing tenant isolation for a boundary that does not exist, given the product owner's explicit confirmation that productization is not planned.
