# CI/CD and GitHub Governance

## Pipeline stages

1. Checkout pinned actions; verify lockfile and prohibited files/secrets.
2. Corepack/pnpm frozen install with cache keyed by lockfile/runtime.
3. Format, lint, dependency-boundary and license checks.
4. Typecheck and generate/check OpenAPI/JSON Schema drift.
5. Unit and contract tests with coverage artifact.
6. Testcontainers integration and clean/previous migration tests.
7. Build all apps/packages; enforce bundle/performance budgets.
8. SAST, dependency audit, secret scan, IaC/Compose lint, container scan and SBOM.
9. E2E deterministic browser, axe and eval smoke on PR; full on main/staging.
10. Build/sign/push immutable images once.
11. Deploy staging, migrate, smoke/live adapter read tests.
12. Manual production environment approval; backup freshness check; deploy exact staging images; smoke and observe; record release.

Production gate blocks critical/high exploitable findings, failed migration/restore freshness, missing approvals, eval/security thresholds or absent rollback image. Exceptions require named owner, compensating control and expiry.

## Repository governance

Protected `main`; no force-push/delete; signed commits/tags preferred; squash merge; required up-to-date checks and conversation resolution. CODEOWNERS: architecture/domain owners, security for auth/policy/tools/upload/secrets, data for schema/migrations, UX for design system, AI quality for prompts/router/evals, ops for infrastructure/runbooks.

Templates: feature/bug/security-private link, ADR, PR checklist and incident. Dependabot/Renovate groups safe patch updates; framework/security patches fast-track through full tests. GitHub Actions use least permissions, OIDC where supported, environments for staging/production, no fork secrets, artifacts with retention/classification.

## Canonical verification

`pnpm verify` runs format check, lint/boundaries, typecheck, unit, contract, integration, OpenAPI/schema check, migration check and build. Release adds `test:e2e`, `test:evals`, `test:security`, `test:a11y`, `test:load` and image/deployment checks.
