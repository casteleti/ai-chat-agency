# G12 — MVP Support Triage

## Objective

Deliver safe public support answers, deterministic severity and structured requests without private account access.

## Read First

G6/G4/G5 evidence, ADR-014, support system/agent, security/LGPD, tool catalog.

## Scope

Support intent/category extraction; deterministic severity engine/SLA config; public-knowledge resolution; support request aggregate/reference; internal ticket-ready schema/status; routing target; create request tool/API/UI; escalation policies; knowledge-gap/feedback events. Keep client/project/ticket private tools disabled/unimplemented for MVP.

## Files

Support domain/repository/severity/routing; API/tool; support prompt; public support UI/read models; tests/evals/migrations.

## Constraints

AI cannot downgrade hard severity. No client enumeration/private lookup. No secrets/destructive troubleshooting. SLA promises only configured. Explicit submission/contact consent.

## Tests/Commands

Category/severity table/property, SEV-1 override, private question boundary, billing/security/angry/human, knowledge grounded/abstain, duplicate issue, provider absent, SLA timezone, golden eval and E2E. `test:unit test:evals test:security test:e2e verify`.

## Acceptance Criteria

SEV-1 recall 100%, macro F1 ≥0.93, private exposure 0, request/reference persisted, escalation triggers exact, user gets useful public path/handoff.

## Completion Report

Report confusion matrix/severity fixtures and explicitly confirm private support absent.
