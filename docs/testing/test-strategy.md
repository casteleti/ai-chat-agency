# Test Strategy

## Pyramid and ownership

- Unit: pure qualification/severity/state/policy/context budget/error/redaction/UI reducers; fast, no network.
- Integration: real PostgreSQL/pgvector/Redis via Testcontainers; repositories, transactions/outbox, RLS, migrations, queue, auth adapters, fake/recorded provider contracts.
- Contract: Zod↔JSON Schema/OpenAPI snapshots, provider adapters, events/jobs/UI descriptors, backwards fixtures.
- E2E: Playwright across public/mobile/admin journeys with deterministic fake AI/provider, plus small live-provider smoke in non-PR protected environment.
- AI evals: probabilistic behavior against versioned golden datasets; compare baseline, threshold and cost/latency.
- Security: authz/tenant/property tests, injection corpus, SSRF/upload/webhook/session/CSRF/XSS, scanners.
- Accessibility: component axe plus manual and browser E2E.
- Load/resilience: k6 API/SSE, DB/RAG/queue and controlled provider fault injection.

Tests are colocated for package units/integration where useful; cross-system suites live under `tests/{contract,e2e,evals,security,load,a11y}`. Fixtures contain no real PII. Test clock, UUID and provider responses are injectable.

## Required thresholds

| Suite | MVP gate |
|---|---|
| deterministic unit/contract | 100% pass; critical policy branches covered |
| intent | macro accuracy ≥95%; support/new-business recall ≥97% |
| structured output | valid ≥99%; invalid never persists/executes |
| tool authorization | 100%; forbidden execution 0 |
| tenant isolation | 0 cross-tenant results across API/repository/RAG/cache |
| fabricated case/price/booking/ticket | 0 |
| qualification | formula exact 100%; labeled band ≥95%; unknown handling 100% |
| support | SEV-1 recall 100%, severity/category macro F1 ≥0.93 |
| RAG | recall@8 ≥0.90, citation precision ≥0.95, groundedness ≥0.95 |
| handoff required fields/factuality | 100% / ≥0.98 |
| accessibility | axe critical/serious 0 + manual checklist |
| performance | SLO/load budgets in defined profile |

Statistical evals report confidence interval and regression vs baseline; minimum 100 scenarios before release, growing to 200+. Human review samples all failures and 10% of passes in high-risk suites.

## CI tiers

PR: format/lint/type/unit/contract/integration/build/migration/security static and deterministic eval smoke. Main/staging: full E2E/evals/a11y and container scan. Release: full security/load/cross-browser, live integration smoke, backup/restore evidence. Scheduled: nightly eval/regression and dependency scan; weekly restore smoke; monthly full restore.

Flaky tests are defects. Quarantine requires owner, issue, expiry ≤7 days and cannot cover release/security acceptance.
