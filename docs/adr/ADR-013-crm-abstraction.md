# ADR-013 — CRM Abstraction

Status: Accepted — 2026-09-02

## Context

Commercial logic must survive changes between Pipedrive, HubSpot or an internal CRM and remain correct during provider outages.

## Decision

Own canonical Contact, Company, Lead, Opportunity and Activity records. Call a `CRMProvider` port through a sync service; adapters own mapping, provider idempotency and webhooks. Internal records commit first and expose sync state.

## Alternatives

Use CRM as the only database; direct tool-to-vendor API; generic iPaaS as domain layer.

## Consequences

Portability, retryability and auditable product behavior. Mapping/reconciliation logic is required.

## Risks

Duplicate or divergent records. Mitigate with normalized identity keys, mapping uniqueness, provider idempotency, webhook inbox, reconciliation jobs and visible sync status.
