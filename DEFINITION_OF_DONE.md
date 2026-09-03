# Definition of Done

A feature or gate is complete only when all applicable items are evidenced.

## Product and contract

- Behavior maps to an approved requirement and acceptance criterion.
- API, event, data, UI, prompt, tool, and error contracts are updated before/with code.
- Empty, error, loading, retry, cancellation, correction, and fallback states are defined.
- `pt-BR` and `en-US` user-facing content exists where exposed.

## Engineering

- Strict types and runtime validation at every external/AI boundary.
- Domain boundaries and provider ports are respected.
- Important writes are transactional, idempotent, auditable, and retry-safe.
- Migrations work from clean and previous schema; seeds rerun safely.
- Feature flag defaults are safe and disabled capabilities are server-unreachable.

## Security and privacy

- Authentication, tenant/resource authorization, rate limits, input limits, and trust zones are tested.
- Sensitive fields are classified; logs/traces are redacted; retention/deletion behavior is implemented.
- Threat model is updated for new attack surface.
- Dependency/container/secret scans meet policy; critical/high findings are resolved or release-blocked.

## Quality

- Unit, integration, contract, E2E, AI eval, security, accessibility, and performance tests required by the gate pass.
- No hidden skipped tests; flaky tests are fixed or gate-blocking.
- AI changes meet dataset thresholds and show no deterministic safety regression.
- Supported browser/device checks pass.

## Experience

- Responsive behavior verified at 320, 375, 390, 768, 1024, and 1440 CSS px.
- Keyboard-only, screen-reader names, focus order/restore, contrast, reduced motion, zoom 200%, and mobile keyboard behavior pass.
- Performance budgets are not exceeded without an accepted time-bound exception.

## Operations

- Logs, metrics, traces, cost attribution, alerts, and audit records cover the feature.
- Health/readiness behavior and provider degradation are correct.
- Runbook and rollback exist for operationally material changes.
- Staging smoke tests and, at release gates, production smoke/backup/restore evidence exist.

## Documentation and handoff

- README/deeper docs/changelog/ADRs are current.
- Completion report contains exact commands and results.
- No unresolved blocker is represented as a risk.

“Works locally” satisfies only one part of this definition.
