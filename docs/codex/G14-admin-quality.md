# G14 — Admin, Knowledge Publishing and Quality Operations

## Objective

Provide the minimal protected console required to operate, review and improve MVP safely.

## Read First

G6–G13 evidence, admin/productization, knowledge workflow, prompt/agent versioning, authorization/audit.

## Scope

Admin dashboard; conversations/detail/traces/tools/citations; leads/opportunities/meetings/sync; support/handoffs; knowledge draft-review-publish-index/test/archive; prompt/agent version list/import/review/publish with eval gate; integrations health/dead letters; audit/settings/flags; cursor/filter/export boundaries. No visual agent builder or SaaS control plane.

## Files

`apps/admin` routes/components; staff API queries/commands; publication workflows; admin read models/materialized views; authorization/audit/E2E/a11y tests.

## Constraints

Same API/policies as other clients; no direct DB/vendor; private/privileged reads audited; secrets never displayed; prior active versions survive failure; dangerous settings require confirmation/re-auth as specified.

## Tests/Commands

Role/resource matrix each page/action, tenant/filter/export, publish failure/rollback/new version, concurrent review, index status, prompt eval gate, audit, pagination/large transcript, a11y/responsive. `test:integration test:e2e test:a11y verify`.

## Acceptance Criteria

Staff can diagnose a failed conversation and safely publish/revert knowledge/config; unauthorized screens/APIs 0; audit complete; no secret fields; admin does not bypass domain logic.

## Completion Report

List role/page/action matrix and publication lifecycle evidence.
