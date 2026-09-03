# G16 — Security, Accessibility, Performance and Resilience Hardening

## Objective

Prove the complete staged system meets deterministic safety, UX, performance, recovery and failure requirements.

## Read First

All prior evidence; threat/AI/upload/rate/LGPD; testing/load; UX/a11y/performance; runbooks/infrastructure.

## Scope

Full threat-model tests and remediation; dependency/container/secret/SAST/IaC scans; CSP/headers/CSRF/SSRF/auth/tool/webhook/rate/cost breakers; cross-browser/mobile/manual WCAG; k6/SSE/DB/RAG/queue load/soak/spike; chaos/fallback/reconciliation; backup+isolated restore drill; runbook exercises; privacy export/delete; final performance optimization.

## Files

Security/load/a11y suites and reports, headers/WAF/config, dashboards/alerts/runbook updates, risk exceptions with expiry, recovery evidence.

## Constraints

No severity waiver hidden as success. Critical/high exploitable findings block. Do not load-test uncontrolled paid providers/production. No destructive production chaos. Maintain function when optional dependencies fail.

## Tests/Commands

`pnpm test:security test:a11y test:load test:e2e test:evals verify`; scanners; restore drill; manual NVDA/VoiceOver/browser matrix; fault suite.

## Acceptance Criteria

Hard AI/security assertions 100%; unauthorized tool 0; axe critical/serious 0 and manual pass; SLO/load budgets; no duplicate writes under faults; RPO/RTO drill; all runbooks executable; release risks accepted with owner/expiry only if non-blocking.

## Completion Report

Include scan findings, matrix, load percentiles/resources, fault outcomes, restore RPO/RTO and unresolved blockers. Only `COMPLETE` permits G17.
