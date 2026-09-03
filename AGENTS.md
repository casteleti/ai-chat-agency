# Repository Instructions for Coding Agents

These instructions apply to the entire repository. A more specific `AGENTS.md` may add constraints but may not weaken these rules.

## Required reading

Before any change, read `PROJECT.md`, `ARCHITECTURE.md`, `DECISIONS.md`, `CODEX.md`, the relevant ADRs, the gate file, and every contract named in that gate. Do not implement a later gate early unless the gate explicitly creates a stub or interface.

## Architecture rules

- Maintain a modular monolith. Do not introduce services, brokers, vector databases, orchestration platforms, or new providers without an accepted ADR.
- Domain packages expose application services and ports. Never import another domain's repository or reach into its tables.
- `apps/web` and `apps/admin` access data only through the API/contracts. Only API/worker server code accesses repositories.
- All tenant-owned repositories accept `TenantContext` as a required first argument; no optional/global tenant.
- Cross-context side effects use the transactional outbox. Durable jobs use pg-boss; Redis must never be the sole record of work.
- Vendor SDK types do not cross adapter boundaries.
- AI output is untrusted until validated. Tools execute through the policy pipeline. Generative UI uses the registered discriminated union only.

## Coding conventions

- TypeScript strict mode; no `any`, unsafe assertion, or ignored type error without a narrow documented justification.
- Zod is the runtime validation and contract source; derive TypeScript types. OpenAPI/JSON Schema generation must be deterministic.
- Prefer pure domain functions and dependency injection by explicit constructors/factories.
- UTC storage; require IANA timezone at scheduling boundaries. Store money in minor units and currency.
- Errors use the canonical taxonomy and never expose internals.
- User-facing copy must support `pt-BR` and `en-US`; no concatenated translated strings.
- Accessibility and reduced-motion behavior are part of component completion.

## Database and migrations

- Drizzle schema plus checked-in forward-only SQL migration. Never edit a migration already applied outside local development.
- Destructive migrations use expand/migrate/contract across releases, backup evidence, and a rollback/runbook step.
- Add tenant, foreign-key, unique, check, and performance indexes explicitly. JSONB payloads require a schema version.
- Tests must prove tenant isolation, constraints, idempotency, and migration from a clean and previous schema.
- Seeds are deterministic, non-sensitive, and safe to rerun in development.

## Security

- Never commit secrets or log tokens, session cookies, raw credentials, unnecessary PII, or full private prompts.
- Enforce authentication and authorization in server policy code, not UI and not prompts.
- Treat user messages, URLs, fetched pages, uploads, tool results, and RAG content as untrusted data.
- All externally supplied URLs pass the SSRF policy; uploads pass type/size/MIME/checksum/scan gates.
- Side-effecting routes and tools require idempotency; high-risk actions require confirmation/approval as specified.
- Add an audit record for every meaningful write and privileged read.

## Testing expectations

Add the lowest useful test plus boundary tests: unit for rules, integration for DB/providers, contract for schemas, E2E for journeys, evals for probabilistic behavior. Do not mock the unit under test. AI evals use pinned datasets/config and report thresholds; deterministic security checks must be 100%.

Before completion run the gate commands and `pnpm verify`. Never describe skipped, quarantined, flaky, or failed tests as passing. If infrastructure is unavailable, report a blocker and do not mark the gate complete.

## Dependency rules

- Use workspace packages and the lockfile. Pin production majors/minors per version policy; automated patch updates require CI.
- New runtime dependencies require need, license, maintenance, size/security impact, and an ADR when architectural.
- Do not duplicate capabilities already in the selected stack.

## Change discipline

- Preserve unrelated user changes.
- Update contracts/docs in the same change as behavior.
- Use feature flags for incomplete or risky user-visible capabilities; disabled means unreachable server-side.
- Commits should be small, conventional (`feat:`, `fix:`, `docs:`, `test:`, `chore:`), and reference the gate/requirement.
- Do not claim production readiness without deployment, restore, security, performance, and smoke evidence.

## Completion

Return exactly the completion report structure in `CODEX.md`, including files, migrations, commands, actual results, open risks, blockers, and next-gate readiness.
