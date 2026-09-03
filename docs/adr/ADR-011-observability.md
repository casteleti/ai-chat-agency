# ADR-011 — OpenTelemetry and Langfuse

Status: Accepted — 2026-09-02

## Context

Operators must explain latency, cost, retrieval, prompt/model/tool behavior and business conversion while limiting sensitive data exposure.

## Decision

Instrument with OpenTelemetry; structured Pino logs; Prometheus-compatible metrics/Grafana; Langfuse for privacy-filtered AI traces/datasets/evals; Sentry for sanitized exceptions; PostHog plus first-party events for product analytics.

## Alternatives

Vendor-only APM; logs only; self-host the entire stack on the application host.

## Consequences

Correlated operational and AI visibility with portable telemetry. Multiple sinks require a common redaction/sampling policy.

## Risks

PII leakage and telemetry cost. Mitigate with classification, processors, sampling, retention, access control, deletion propagation and no raw secrets/content by default.
