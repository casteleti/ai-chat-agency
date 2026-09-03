# AI Business Concierge — Implementation Blueprint

This repository is the implementation-ready blueprint for an AI-powered commercial concierge embedded in a B2B Marketing + AI agency website. It defines the product, architecture, contracts, safeguards, delivery gates, and evidence required to build the application. It intentionally contains no production application implementation.

## Product in one sentence

An adaptive conversational workspace that gives a visitor a clearer view of their business, progressively creates a brief and opportunity map, qualifies fit, and moves the right conversation to a meeting or a context-preserving human handoff.

## Locked architecture

- Modular monolith in a pnpm/Turborepo TypeScript monorepo.
- `apps/web`: Next.js 16.3.3, React 19.2, Tailwind CSS 4.3, Radix UI, Motion, AI SDK 7 UI streaming.
- `apps/api`: Fastify 5 REST API and SSE orchestration endpoint.
- `apps/worker`: pg-boss jobs for integrations, ingestion, summaries, and retries.
- `apps/admin`: protected Next.js internal console, deployed separately from public web.
- PostgreSQL 18.6 + pgvector; Redis 8.2 Extended for ephemeral coordination only; Cloudflare R2 for objects.
- Better Auth for staff/client sessions; signed anonymous visitor sessions for public chat.
- OpenAI Responses API primary, provider abstraction, model routing by task.
- OpenTelemetry + Langfuse for AI traces; PostHog plus first-party events for product analytics.
- Docker on Hetzner behind Cloudflare; Caddy as origin reverse proxy.

See [PROJECT.md](PROJECT.md) for WHAT, [ARCHITECTURE.md](ARCHITECTURE.md) for HOW, and [CODEX.md](CODEX.md) for execution.

## Blueprint map

| Area | Canonical source |
|---|---|
| Product scope and releases | `PROJECT.md` |
| Technical architecture | `ARCHITECTURE.md` |
| Decisions | `DECISIONS.md`, `docs/adr/` |
| API | `docs/api/api-contract.md`, `openapi/openapi.yaml` |
| Data | `docs/database/` |
| AI, prompts, tools | `docs/ai/`, `docs/agents/`, `packages/ai/prompts/`, `packages/contracts/` |
| UX and Generative UI | `docs/ux/` |
| Security and LGPD | `SECURITY.md`, `docs/security/` |
| Tests and evals | `docs/testing/`, `tests/fixtures/` |
| Infrastructure and operations | `docs/infrastructure/`, `docs/runbooks/` |
| Implementation gates | `docs/codex/` |
| Full file inventory | `docs/FILE_MANIFEST.md` |

## Start implementation

1. Read `AGENTS.md`, `PROJECT.md`, `ARCHITECTURE.md`, `DECISIONS.md`, and `CODEX.md`.
2. Run `node scripts/verify-blueprint.mjs`.
3. Execute `docs/codex/G0-repository-foundation.md` only.
4. Stop at the gate boundary and return the completion report required by `CODEX.md`.

## Expected commands after G0

```bash
corepack enable
pnpm install --frozen-lockfile
pnpm dev
pnpm lint
pnpm typecheck
pnpm test
pnpm test:integration
pnpm test:e2e
pnpm test:evals
pnpm build
pnpm db:migrate
pnpm db:seed
pnpm verify
```

The G0 implementer creates the executable root `package.json`, lockfile, workspace configuration, apps, and packages. Until then, this is a specification repository.

## Research baseline

The stack was verified on 2026-09-02 against official sources. Version policy and links are in `docs/research/technology-baseline-2026-09.md`. Patch versions are pinned at build time and updated through a tested dependency PR; architectural majors require an ADR.

## Status

Planning status: **READY FOR G0**. Product implementation status: **NOT STARTED**.
