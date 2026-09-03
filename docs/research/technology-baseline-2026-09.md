# Technology Baseline — 2026-09-02

This record freezes the evidence used to choose the production stack. G0 pins exact compatible patch versions in the lockfile and container digests. Automated patch updates may merge after all checks; majors/minors require review and architectural majors require an ADR.

## Final stack

| Layer | Selected technology | Why | Version strategy |
|---|---|---|---|
| Runtime/language | Node.js + TypeScript | One strict language across UI/API/worker/contracts | Node 24 LTS; TS stable compatible with framework |
| Monorepo | pnpm workspaces + Turborepo | Fast deterministic installs, task graph, package boundaries | Pin pnpm via Corepack and Turbo in lockfile |
| Frontend | Next.js + React | SSR/RSC, routing, streaming, strong AI/UI ecosystem | Next 16.3.3 Active LTS; React 19.2 latest security patch |
| Styling | Tailwind CSS + CSS variables | Token-driven, responsive, small runtime | Tailwind 4.3.x pinned minor |
| UI | Radix primitives + custom components | Accessible behavior without generic visual identity | Pin compatible releases; no full component kit dependency |
| Motion | Motion | Declarative transitions and reduced-motion support | Pin minor |
| Forms | React Hook Form | Performant controlled validation integration | Pin minor |
| Validation | Zod | Canonical runtime schemas, TS derivation, AI/tool contracts | Pin major/minor |
| AI UI/gateway | AI SDK 7 | Provider abstraction, streaming, tools, typed UI | Pin major/minor; do not use experimental RSC API |
| Primary AI | OpenAI Responses API | Structured outputs, tools, streaming, current model tiers | Model aliases in dev; approved snapshots/config in prod |
| Alternative AI | Anthropic/Google adapters | Evaluation/fallback portability | Disabled until contract tests pass |
| API | Fastify 5 | Low overhead, schema/plugin model, TypeScript | Latest compatible 5.x patch |
| API style | REST + OpenAPI + SSE | Explicit contracts; resumable one-way generation stream | `/v1`, additive compatibility policy |
| Database | PostgreSQL | Transactional core, JSONB, FTS, vector extension | 18.6 at baseline; supported 18.x security patches |
| ORM | Drizzle ORM/Kit | Typed SQL-oriented schema and migrations | Pin compatible release; reviewed generated SQL |
| Vector | pgvector | Adequate scale, filters and hybrid search without new service | Extension version pinned in DB image |
| Cache/limits | Redis | Efficient ephemeral counters and coordination | 8.2 Extended, security patches |
| Queue | pg-boss | Durable Postgres-backed jobs and fewer moving parts | Pin major/minor; job contracts versioned |
| Auth | Better Auth | TypeScript, self-hosted sessions, magic links/plugins | Pin minor; adapter schema migration tests |
| Objects | Cloudflare R2 via S3 API | Private scalable objects, no egress charge, provider-portable | AWS SDK S3 client pinned; bucket policies IaC |
| Telemetry | OpenTelemetry | Vendor-neutral end-to-end traces/metrics | Stable semantic conventions; privacy processor |
| AI observability | Langfuse | AI traces, datasets, evals, prompt/cost analysis | Managed initially or separately self-hosted after capacity review |
| App errors | Sentry | Sanitized exception workflow | SaaS behind consent/data-processing review |
| Product analytics | PostHog + internal events | Funnel analysis plus owned event record | Consent-aware; self-host optional later |
| Unit/integration | Vitest + Testcontainers | Fast TS tests and real Postgres/Redis contracts | Pin major; containers by digest |
| E2E/a11y | Playwright + axe-core | Browser/mobile/cross-browser and automated WCAG | Pin browsers in CI image |
| Load | k6 | Scriptable HTTP/SSE load tests | Pinned container digest |
| Edge | Cloudflare | DNS, TLS, CDN, WAF, Turnstile | Configuration as code/manual export |
| Origin proxy | Caddy | Automatic TLS/origin routing, small config | Pinned container digest |
| Hosting | Hetzner + Docker Compose | Cost/control and operational simplicity | Ubuntu LTS, Docker stable; no Kubernetes |
| CI/CD | GitHub Actions | Checks, images, staged SSH/registry deployment | Actions pinned to commit SHA |
| Secrets | GitHub environment secrets + SOPS/age for encrypted config; runtime env | Least privilege and rotation without committing plaintext | Never store plaintext secrets in repo |

## Primary evidence

- Next.js 16.3 and 16.3.3 Active LTS/security release: https://nextjs.org/blog/next-16-3 and https://nextjs.org/blog
- React 19.2: https://react.dev/blog/2025/10/01/react-19-2
- Tailwind CSS 4.3: https://tailwindcss.com/blog/tailwindcss-v4-3
- AI SDK 7 migration/versioning and production AI SDK UI: https://ai-sdk.dev/docs/migration-guides/migration-guide-7-0 and https://ai-sdk.dev/docs/ai-sdk-ui/generative-user-interfaces
- Node 24 LTS: https://nodejs.org/en/about/previous-releases
- Fastify latest 5.x and Node support: https://fastify.dev/docs/latest/Guides/Migration-Guide-V5/
- PostgreSQL 18.6 stable while 19 is beta: https://www.postgresql.org/about/news/postgresql-186-1711-1615-1519-1424-and-19-beta-3-released-3365/
- Redis 8.2 Extended lifecycle: https://redis.io/docs/latest/operate/oss_and_stack/install/version-mgmt/
- pgvector HNSW and hybrid FTS: https://github.com/pgvector/pgvector
- Better Auth capabilities: https://better-auth.com/docs/introduction
- R2 S3 compatibility/consistency/egress: https://developers.cloudflare.com/r2/how-r2-works/
- OpenAI model tiers: https://developers.openai.com/api/docs/models/gpt-5.6-sol, `/terra`, `/luna`
- Langfuse observability/evals: https://langfuse.com/docs/observability/overview and https://langfuse.com/docs/evaluation/overview

## Rejected initial choices

- Next.js-only backend: mixes public rendering lifecycle with long-lived orchestration and worker concerns; Fastify gives clearer BFF/domain boundary.
- NestJS: useful at larger organizational scale but redundant DI/decorator complexity for this team.
- Python/FastAPI hybrid: adds language/contract/operations surface without a Python-only requirement.
- Clerk/Supabase Auth: good products, but unnecessary identity vendor dependency for the self-hosted architecture.
- BullMQ: Redis would become durable infrastructure; pg-boss keeps the source-of-work in PostgreSQL.
- Temporal/Trigger.dev/Inngest: premature for bounded jobs and short orchestration; revisit when workflows span days with complex compensations.
- Qdrant/Pinecone: no scale or feature need beyond PostgreSQL hybrid retrieval.
- Vercel: strong Next.js experience but conflicts with cost/control and separate API/worker topology; can remain a preview option only if no production coupling is introduced.
- Self-hosted Langfuse on the primary launch host: operationally heavy; use managed or a dedicated observability host, with privacy controls.
- React canary ViewTransition: production relies on stable web/Next primitives and Motion, not canary React APIs.
