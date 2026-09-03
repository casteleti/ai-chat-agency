# G13 — Human Handoff and Notifications

## Objective

Create a complete, durable, routed handoff that lets a human continue without repetition.

## Read First

G7/G10/G12 evidence, handoff agent/spec/diagram, tool catalog, provider interfaces, support/qualification.

## Scope

Handoff package generation/validation/version/persistence; facts vs hypotheses/source links; commercial/support routing/urgency; assignment/takeover/speaker mode; email/internal notification provider and retry; user reference/status; staff suggested first response; CRM activity/support linkage; no-assignee fallback; analytics/audit.

## Files

Handoff/escalation within `domain-support` (repository/API/tool); notification port/adapters/jobs/templates; staff/public UI states; prompt/version; tests/evals.

## Constraints

No hidden reasoning/irrelevant PII. Persist before notification/success. Human requested always eligible. AI stops external responses during human-active unless explicit return. Response expectation comes from configuration.

## Tests/Commands

Package completeness/factuality, routing/urgency, duplicate/retry, notification fail, no assignee, takeover concurrency, human/AI speaker lock, consent, cross-tenant, first-response repetition rubric. `test:evals test:integration test:e2e verify`.

## Acceptance Criteria

Required fields 100%, factuality ≥0.98, duplicate handoffs/notifications 0, route accuracy threshold, human first reply acknowledges context, failure leaves durable reference.

## Completion Report

Include handoff fixture/eval metrics, notification fake/live distinction and concurrency evidence.
