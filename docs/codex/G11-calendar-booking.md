# G11 — Calendar and Meeting Booking

## Objective

Offer real normalized availability and create exactly one correct meeting with timezone-safe confirmation.

## Read First

G8/G3 evidence, provider interfaces, API/tool catalog, user journeys, resilience.

## Scope

Meeting types/intents/slots/bookings; `CalendarProvider`, fake and selected production adapter; signed expiring slot token bound to tenant/type/timezone; contact verification; booking idempotency/reconciliation/webhooks; meeting picker/confirmation UI; capture preference fallback; meeting intelligence pack link; notifications/events.

## Files

Meeting domain/repositories/API/tools; calendar adapters/jobs/webhooks; UI components; tests/migrations.

## Constraints

UTC persistence + IANA attendee timezone; never model-generated slots; explicit confirmation; no booking success without internal persisted/provider result state; `CALENDAR_WRITES_ENABLED`; provider race/timeout reconciliation.

## Tests/Commands

DST gaps/overlaps, locale formatting, expired/tampered/cross-tenant slot, two-user race, duplicate request, provider success timeout, unavailable fallback, consent/identity, webhook replay, responsive/a11y picker. `test:integration test:e2e test:a11y verify`.

## Acceptance Criteria

Timezone/duplicate errors 0; selected slot/confirmation exact; race yields one booking; outage captures intent honestly; meeting event/CRM activity idempotent.

## Completion Report

Include timezone matrix, race count, adapter evidence and booking references redacted.
