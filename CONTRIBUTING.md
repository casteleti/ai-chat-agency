# Contributing

## Workflow

Use short-lived branches from protected `main`: `feat/Gxx-description`, `fix/Gxx-description`, or `docs/description`. Open a PR; direct pushes to `main` and production deploys from unreviewed commits are forbidden.

Before coding, identify requirement and gate, read the referenced contracts, and confirm dependencies are complete. Keep PRs within one coherent gate outcome. Update code, tests, docs, contracts, and migration evidence together.

## Pull request requirements

- Clear problem/outcome and requirement/gate references.
- Architecture/security/data/UX impact.
- Files and migrations summarized.
- Exact test commands and results.
- Screenshots/video for UI states including mobile, error, loading, reduced motion.
- Rollout flag, observability, rollback, and compatibility notes.
- No secrets, personal production data, generated build output, or unexplained dependency.

Required approvals: one code owner; security owner for auth/authorization/tools/uploads/secrets; data owner for destructive migrations; product/UX owner for journey changes. CODEOWNERS is created in G0.

## Branch and commit policy

Squash merge by default with conventional title. `main` must remain releasable. Required checks: format, lint, typecheck, unit, integration, contract, build, migration validation, security scan; E2E/evals/a11y/load as affected. Release tags use SemVer after MVP baseline.

## Database changes

Use forward-only migrations. Destructive changes require expand/migrate/contract, verified backup/restore and staged rollout. Never manually alter production outside an incident runbook; reconcile any emergency change into a migration immediately.

## AI changes

Prompt/agent/model/router changes require immutable version, golden/eval comparison, cost/latency report, and rollback target. Never edit a published version in place.
