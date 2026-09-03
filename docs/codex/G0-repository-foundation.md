# G0 — Repository Foundation

## Objective

Create the executable monorepo skeleton and deterministic developer/CI command surface without implementing product behavior.

## Read First

`AGENTS.md`, `PROJECT.md`, `ARCHITECTURE.md`, ADR-001/002/003/009, technology baseline, CI/CD specification.

## Scope

Initialize pnpm/Turborepo on Node 24 LTS; strict shared TypeScript/ESLint/Prettier; apps `web`, `admin`, `api`, `worker`; packages `config`, `contracts`, `database`, `ui`, `ai`, domain placeholders, observability, security, testing; exact dependency boundaries; Vitest/Playwright/Testcontainers harness; local Compose services; GitHub templates/CODEOWNERS/workflows; canonical root commands.

## Files To Create/Modify

Root `package.json`, `pnpm-workspace.yaml`, `pnpm-lock.yaml`, `turbo.json`, `.nvmrc`, TS/lint/format configs, `.gitignore`; minimal health-capable app entry points; package manifests/exports; `compose.dev.yml`, `compose.test.yml`; `.github/workflows/ci.yml`, CODEOWNERS/templates; hierarchical `apps/web/AGENTS.md`, `packages/ai/AGENTS.md`, `packages/database/AGENTS.md`; boundary config; tests proving app/package build graph.

## Constraints

No business endpoint, database table, model call or vendor integration. No Vercel-only runtime assumption. Pin versions from baseline/lockfile and action/container digests. No `any`; no secrets. Apps import only published package exports.

## Tests/Commands

`corepack enable`; frozen install; `pnpm format:check lint typecheck test:unit test:contract build`; dependency-boundary check; Compose config lint; secret scan; `pnpm verify`.

## Acceptance Criteria

- Clean clone on Node 24 executes frozen install and all canonical commands.
- All four apps build/start minimal health shell; no app imports another app.
- Boundary violation fixture/test fails as expected.
- CI uses same commands and pinned dependencies.
- No product implementation or secret.

## Completion Report

Use `CODEX.md`; include exact dependency versions, build outputs, test counts and any intentionally empty package. Update `STATUS.md`; stop before G1.
