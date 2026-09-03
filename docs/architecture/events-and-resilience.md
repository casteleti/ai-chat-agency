# Event Model, Jobs, Idempotency and Resilience

## Envelope

Every internal event has `id` (UUIDv7), `type`, `schemaVersion`, `tenantId`, `aggregateType`, `aggregateId`, `occurredAt`, `actor`, `requestId`, `correlationId`, `causationId`, `payload`, and `sensitivity`. Events are inserted into `outbox_events` in the same transaction as the business change. Worker claims, delivers, and records attempts; consumers store `(consumer,event_id)` uniqueness.

## Canonical events

| Event | Producer | Consumers | Retention/audit |
|---|---|---|---|
| `conversation.started.v1` | Conversation | analytics, summary scheduler | 24 months, anonymizable |
| `conversation.message_created.v1` | Conversation | orchestration, analytics | per conversation retention |
| `conversation.intent_changed.v1` | Orchestrator | analytics, state | 24 months |
| `briefing.updated.v1` | Commercial | analytics, CRM sync | version history 24 months |
| `diagnostic.generated.v1` | Commercial | UI, analytics | conversation retention |
| `lead.identified.v1` | Commercial | CRM sync | business/legal retention |
| `lead.qualified.v1` | Qualification | CRM, analytics | 24 months |
| `meeting.requested.v1` | Commercial | calendar sync | 24 months |
| `meeting.scheduled.v1` | Commercial | CRM, notifications | business/legal retention |
| `support.request_created.v1` | Support | routing, notifications | support retention |
| `ticket.created.v1` | Support | analytics, notifications | SLA/legal retention |
| `handoff.requested.v1` | Support | routing, notifications | 24 months |
| `handoff.completed.v1` | Support | analytics | 24 months |
| `knowledge.published.v1` | Knowledge | ingestion/index | document lifetime |
| `knowledge.indexed.v1` | Worker | admin/quality | document lifetime |
| `integration.sync_failed.v1` | Adapter job | alerting, retry | 90 days + audit pointer |
| `tool.execution_failed.v1` | Tool executor | alerting, eval sampling | 90 days |

## Job contract

Jobs carry `jobVersion`, tenant, request/correlation, idempotency key, payload reference (not secrets), attempt policy, and expiry. Defaults: exponential backoff with jitter, max 5 attempts for transient providers, dead-letter after exhaustion, no retry for validation/auth/policy denial. Handlers re-read authoritative records and are safe after crash between external success and local acknowledgment through provider idempotency or reconciliation lookup.

## Critical idempotency keys

- Message: tenant + conversation + client message ID.
- Lead/contact/company: tenant + normalized email/domain + operation purpose.
- CRM deal: internal opportunity ID + provider.
- Meeting: scheduling intent ID + selected slot + provider.
- Ticket: support request ID + provider.
- Notification: handoff/event ID + destination + template version.
- Knowledge indexing: document version + embedding config hash.

Idempotency records store request hash, status, result reference, expiry, and conflict when the same key carries a different body.

## Fallback matrix

Provider failure must never be hidden through a fabricated success. Retry only operations documented as safe. Circuit breakers are per tenant/provider/operation and open on sustained failure. Optional providers do not fail `/ready`; PostgreSQL and critical config do. Detailed operator actions are in runbooks.
