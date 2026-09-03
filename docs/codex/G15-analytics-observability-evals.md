# G15 — Analytics, Observability and Full Evals

## Objective

Make product, AI, commercial and operational behavior measurable, reproducible and alertable.

## Read First

G14 evidence, ADR-011, analytics/observability, SLO/dashboard, test/eval strategy, privacy.

## Scope

OpenTelemetry propagation/instrumentation; Pino redaction; metrics/Prometheus dashboards/alerts; Langfuse privacy-filtered traces/datasets/evals; Sentry sanitized errors; internal events + consent-aware PostHog; MBC/funnel/commercial views; complete golden dataset 100–200 cases; baseline/candidate eval CI; cost/latency budgets; admin quality links.

## Files

Observability/analytics packages; collectors/config/dashboards/alerts; event consumers/views; eval runner/datasets/reports; redaction/sampling/deletion propagation tests.

## Constraints

No secrets/full private content in generic logs/analytics. LLM judge never sole security criterion. Dataset immutable/versioned/de-identified. Telemetry failure cannot break core request.

## Tests/Commands

Trace correlation HTTP→AI→tool→job, redaction snapshots, metrics/event schema/dedupe, consent off/withdraw/delete, dashboard queries, alerts, full eval thresholds/subgroups/cost, telemetry outage. `test:evals` plus observability/integration/security/verify.

## Acceptance Criteria

Every production run is reproducible by versions/config; required dashboards/alerts exist; MBC computed from authoritative events; full eval thresholds pass; privacy leakage in telemetry 0.

## Completion Report

Provide dashboard/alert inventory, dataset count/subgroups, eval/cost/latency table and redaction evidence.
