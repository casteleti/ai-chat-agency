# Canonical Technical Architecture

Status: Accepted  
Source of truth for: **HOW the system is built**

## Style

A **modular monolith with asynchronous jobs and an internal event outbox**. One monorepo and one primary PostgreSQL database serve separately deployable web, API, worker, and admin processes. Bounded-context packages enforce boundaries in code. This gives independent scaling where it matters without distributed transactions or microservice operations.

Microservices become eligible only after measured need: independent team ownership, isolation/regulatory boundary, or a component needing a materially different scaling/runtime profile. A new service requires an ADR and an outbox/inbox integration contract.

## Deployable components

| Component | Responsibility | May access |
|---|---|---|
| `web` | Public website integration, conversation workspace, SSE client, approved UI renderer | Public API only |
| `admin` | Protected operational UI | Staff API only |
| `api` | REST/SSE, auth/session, orchestration, policies, domain commands/queries | PostgreSQL, Redis, R2, provider ports |
| `worker` | pg-boss jobs: knowledge ingestion, summaries, integrations, notifications, retries | PostgreSQL, R2, provider ports |

The API is the only public origin application. The worker never exposes a public port. Web and admin never connect directly to databases or vendors.

## Bounded contexts

- Identity: visitor sessions, users, memberships, roles, consents.
- Conversation: conversations, participants, messages, state, summaries, channel.
- AI orchestration: context assembly, router, model gateway, prompt/agent versions, runs.
- Policy and tools: capability registry, authorization, confirmations, idempotent execution, audit.
- Knowledge: documents, versions, chunks, embeddings, retrieval, citations, publication.
- Commercial: contacts, companies, leads, opportunities, briefing, insights, qualification, meetings.
- Support: support requests, severity, tickets, SLA, escalation.
- Integrations: provider interfaces, mappings, webhook inbox, sync jobs.
- Experience: Generative UI schema, renderer registry, website context.
- Analytics/quality: domain outbox, product events, feedback, evaluations, cost and performance.
- Administration/configuration: tenant settings, feature flags, prompt publishing, audit views.

Contexts call exported application services or ports; they do not import another context's repository implementation or tables. Cross-context side effects use a transactionally written outbox event.

## Request lifecycle

1. Cloudflare applies TLS, WAF, bot controls, Turnstile where challenged, and coarse IP limits.
2. Fastify resolves request ID, tenant, signed anonymous or authenticated identity, consent, locale, and rate bucket.
3. Conversation service stores the user message and an outbox event in one transaction.
4. Policy engine builds allowed capabilities for this identity/resource/state.
5. Context engine assembles ordered, budgeted, provenance-tagged context.
6. Model router selects a pinned task tier. Prompt composer loads published immutable prompt and agent versions.
7. Model gateway streams text/structured proposals. All structured output is Zod-validated.
8. Tool proposals pass schema, tenant, identity, resource, policy, risk, confirmation, idempotency, timeout, and audit checks before execution.
9. Approved UI descriptors pass the Generative UI schema and renderer allowlist.
10. The assistant message, state patch, usage, citations, tool results, and outbox events persist before completion.
11. SSE resumes from a server event cursor after transient disconnects.

## API and streaming

Externally, use versioned REST JSON under `/v1` plus `text/event-stream` for message execution. REST fits resource operations and OpenAPI contracts; SSE is simpler than WebSockets for one-way token/progress streaming and works through the chosen infrastructure. Commands require `Idempotency-Key`; all responses include `X-Request-Id`. Webhooks use signed provider-specific endpoints and inbox deduplication.

## Data

PostgreSQL 18.6 is the source of truth. Every tenant-owned row has non-null `tenant_id`; repositories require a `TenantContext`; composite tenant indexes and foreign keys prevent accidental cross-tenant joins. Row-level security is defense-in-depth for the most sensitive tables, not a substitute for repository scoping.

Use UUIDv7 identifiers, `timestamptz` UTC timestamps, money as integer minor units plus ISO currency, JSONB only for versioned flexible payloads, and optimistic version columns for user-editable aggregates. Drizzle owns schema and forward migrations. Raw SQL is allowed for pgvector, FTS, RLS, constraints, views, and performance-critical queries with tests.

Redis 8.2 Extended stores only disposable rate-limit counters, short locks, and ephemeral stream coordination. The product remains correct after Redis loss. pg-boss stores durable jobs in PostgreSQL. R2 stores attachments and source documents; database rows store metadata, checksums, ownership, scan state, and retention.

## AI architecture

There is one Conversation Orchestrator with logical roles (`CONCIERGE`, `NEW_BUSINESS`, `SUPPORT`), not a swarm. Specialized capabilities are deterministic services or prompt modules. Model tasks are `FAST`, `STANDARD`, `REASONING`, `VISION`, and later `VOICE`. OpenAI Responses API is primary through AI SDK 7; providers implement a narrow `ModelProvider` interface. Production records a pinned model snapshot/config where available.

The model can interpret, extract, summarize, retrieve, propose questions, diagnose, and propose tools/UI. Software decides identity, authorization, score calculations, state transitions requiring invariants, writes, retries, and side effects.

## Knowledge and memory

Knowledge uses versioned documents, semantic chunks, PostgreSQL FTS, pgvector cosine HNSW, Reciprocal Rank Fusion, optional reranking, mandatory tenant/visibility/effective-date filters, and returned citations. A retrieval result is untrusted content and never becomes instruction text.

Memory layers are working context, conversation summary, visitor/contact/company memory, client/account/project memory, and published knowledge. Stored memories are typed claims with source, confidence, sensitivity, timestamps, and expiry. Context assembly retrieves only intent-relevant authorized records.

## Auth and authorization

Anonymous public chat uses an HttpOnly, Secure, SameSite=Lax signed session cookie bound to a server-side visitor session; it is not an authenticated person. Better Auth provides staff and V1 client magic-link/OTP sessions. Roles are `CLIENT_USER`, `SALES`, `SUPPORT`, `KNOWLEDGE_EDITOR`, `ADMIN`, `OWNER`, with resource ownership/tenant policies. Service-to-service calls use workload credentials, not user tokens.

## Providers

Domain logic depends on `CRMProvider`, `CalendarProvider`, `SupportProvider`, `EmailProvider`, `ObjectStorageProvider`, `ModelProvider`, and future `ChannelAdapter` ports. Adapters translate internal canonical models and keep external IDs in mapping tables. Outages create durable pending sync jobs when safe.

## Observability

OpenTelemetry propagates traces across HTTP, model, retrieval, tools, jobs, and providers. Langfuse receives privacy-filtered AI traces, prompt/agent versions, token/cost and eval scores. Pino emits structured logs. Metrics feed a Prometheus-compatible collector/Grafana; Sentry captures sanitized application exceptions; PostHog receives consent-aware product events. Raw secrets, auth tokens, full attachments, and unnecessary message content are forbidden in logs.

## Deployment

Cloudflare DNS/CDN/WAF → Hetzner origin firewall → Caddy → web/admin/api containers. Private Docker networks isolate API, worker, PostgreSQL, Redis, and optional observability. R2 and AI providers are external HTTPS dependencies. Production begins on one appropriately sized host only if database backup/restore and off-host copies are proven; recommended reliable topology is two application nodes plus a dedicated database node. `docs/infrastructure/production-topology.md` defines both launch and scale profiles.

## Non-negotiable invariants

1. No tenant-owned query without tenant scope.
2. No private client data before authenticated resource authorization.
3. No side-effecting tool executes solely because a model requested it.
4. No case, price, meeting, ticket, or integration success is claimed without a persisted tool result.
5. No arbitrary model-generated frontend code.
6. No important write without idempotency and audit.
7. No production prompt or agent configuration without an immutable published version.
8. No gate completes with failing required checks.

Deeper specifications are authoritative for their concern but may not contradict this file. Resolve conflicts in favor of `PROJECT.md` for scope and this file for architecture, then record a decision.
