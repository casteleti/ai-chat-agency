# Decision Register

ADRs are authoritative; this is the quick index.

| ID | Decision | Status |
|---|---|---|
| ADR-001 | Modular monolith with outbox and separate deployable processes | Accepted |
| ADR-002 | Next.js 16.3.3 + React 19.2 public/admin web | Accepted |
| ADR-003 | Fastify 5 REST/SSE API; TypeScript-only backend | Accepted |
| ADR-004 | PostgreSQL 18.6, Drizzle, pgvector, FTS | Accepted |
| ADR-005 | AI SDK 7 provider layer; OpenAI Responses primary | Accepted |
| ADR-006 | Hybrid RAG in PostgreSQL; no vector service in MVP | Accepted |
| ADR-007 | One orchestrator with logical roles; deterministic workflows | Accepted |
| ADR-008 | Better Auth for users; signed server-side anonymous sessions | Accepted |
| ADR-009 | Docker/Hetzner behind Cloudflare and Caddy | Accepted |
| ADR-010 | pg-boss durable jobs; Redis ephemeral only | Accepted |
| ADR-011 | OpenTelemetry + Langfuse + Pino + metrics/Sentry | Accepted |
| ADR-012 | Schema-driven registered Generative UI | Accepted |
| ADR-013 | Internal CRM model and `CRMProvider` adapters | Accepted |
| ADR-014 | MVP support public-only; authenticated support in V1 | Accepted |
| ADR-015 | Tenant-ready shared schema without SaaS operations | Accepted |
| ADR-016 | Postgres contention mitigation (OLTP + vector + FTS + jobs) | Accepted |

## Product decisions

| Topic | Locked decision |
|---|---|
| Primary MVP journey | New-business consultative discovery |
| Support MVP | Public knowledge + collection + handoff only |
| First interaction | Dedicated progressive workspace; launcher may exist but no tiny bubble UI |
| Data collection | Value before contact fields; progressive and correctable |
| AI authority | Propose/interpret; deterministic software authorizes and writes |
| Voice | Excluded MVP; speech-to-text V1; realtime later only with evidence |
| WhatsApp | Not primary CTA; continuity/handoff in V1 |
| Website audit | URL-only, SSRF-safe, preliminary, bounded |
| Pricing/cases | Only from approved knowledge/tool records |
| Productization | Generic core and tenant IDs now; provisioning/billing/white-label later |

## Change rule

Any change to a locked decision requires: proposed ADR, impact on scope/security/data/tests/operations, migration path, and explicit acceptance. An implementation shortcut does not change architecture.
