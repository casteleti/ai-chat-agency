# G10 — Commercial Persistence and CRM

## Objective

Persist verified commercial records internally and synchronize them safely through a provider abstraction.

## Read First

G8 evidence, ADR-013, provider interfaces, tool catalog, idempotency/resilience, LGPD.

## Scope

Contact/company/lead/opportunity/activity services and APIs; identity/consent prerequisites; normalization/deduplication; `CRMProvider`, fake adapter and selected production adapter; external mappings, outbox sync/retry/dead-letter/reconciliation/webhooks; sync statuses/admin read model; tools create/update lead/opportunity.

## Files

Commercial domain/repositories/API/tools; integrations CRM port/adapters/jobs/webhooks/reconciliation; migrations/tests/runbook additions.

## Constraints

Internal commit first; model never calls CRM. Provider credentials encrypted/scoped. No create before verified/confirmed identity and follow-up consent. Idempotency and external lookup prevent duplicates. `CRM_WRITES_ENABLED` gates dispatch server-side.

## Tests/Commands

Normalize/dedupe, consent/authorization, duplicate idempotency, internal success/provider fail/retry, provider success/local timeout/reconcile, webhook signature/replay/out-of-order, external ID mapping, flag off, token redaction; production sandbox/read/write smoke only with authorization. Run integration/security/E2E/verify.

## Acceptance Criteria

Duplicate canonical/external lead/deal 0 in fault suite; pending sync survives restart; no credential/model exposure; all writes audited; local fake vertical slice complete; live evidence explicitly labeled.

## Completion Report

Name adapter/provider/version/scopes without secret; report fake/live tests and reconciliation evidence.
