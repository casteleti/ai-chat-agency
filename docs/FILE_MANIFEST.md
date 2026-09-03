# Complete File Manifest

This manifest covers every blueprint file and the implementation file groups Codex must create. “Dependency” means the authoritative input; “Phase” is planning or the first gate that consumes/creates it. All files must contain concrete content and may not contradict `PROJECT.md`/`ARCHITECTURE.md`.

## Root files

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `README.md` | entry, stack summary, setup/commands, document links, first action | project/architecture | planning/G0 |
| `PROJECT.md` | canonical vision, audiences, scope MVP/V1/V2, exclusions, success | owner concept | planning |
| `ARCHITECTURE.md` | canonical style, components, data, AI, auth, providers, deployment, invariants | project/research | planning |
| `AGENTS.md` | repository-wide coding agent constraints and verification | architecture/security/DoD | planning/G0 |
| `CODEX.md` | gate methodology, commands, stop/report protocol | roadmap/DoD | planning |
| `DEFINITION_OF_DONE.md` | product/engineering/security/quality/ops completion rules | all quality specs | planning |
| `DECISIONS.md` | ADR/product decision index and change rule | ADRs | planning |
| `ROADMAP.md` | release and G0–G17 dependency sequence | project/gates | planning |
| `SECURITY.md` | reporting, trust baseline, controls and response severity | threat model | planning |
| `CONTRIBUTING.md` | branches, PRs, checks, DB/AI change policy | AGENTS/CI | planning/G0 |
| `CHANGELOG.md` | notable blueprint/product changes | repository state | planning onward |
| `.env.example` | complete grouped environment names with safe defaults/no secrets | config/flags | planning/G1 |

## Planning control and architecture

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `docs/PRE_DEVELOPMENT_AUDIT.md` | contradiction/completeness audit and readiness | complete blueprint | planning final |
| `docs/FILE_MANIFEST.md` | path/purpose/content/dependency/phase inventory | complete tree | planning final |
| `docs/BLUEPRINT_TREE.md` | complete delivered blueprint tree and link to intended implementation tree | manifest/tree | planning final |
| `docs/research/technology-baseline-2026-09.md` | evaluated stack, locked versions, official evidence, rejected options | 2026 research | planning/G0 |
| `docs/architecture/system-architecture.md` | topology, contracts, scaling and failure domains | ARCHITECTURE | planning/G0 |
| `docs/architecture/diagrams.md` | system/deploy/AI/agent/journey/handoff/RAG/CRM/state/data Mermaid | architecture/product | planning |
| `docs/architecture/bounded-contexts.md` | ownership, exports, forbidden knowledge/dependency direction | architecture | planning/G0 |
| `docs/architecture/events-and-resilience.md` | event/job envelope, catalog, idempotency, fallbacks | API/data/providers | planning/G2 |
| `docs/architecture/context-memory-model-routing.md` | context order/budget, memory/retention, task tiers | AI/product/privacy | planning/G5 |
| `docs/architecture/intended-repository-tree.md` | full implementation tree and directory responsibilities | gates/architecture | planning/G0 |

## ADR files

Every ADR contains status, context, decision, alternatives, consequences and risks; all depend on project/research and are planning inputs to named gates.

| Path | Decision | Phase |
|---|---|---|
| `docs/adr/ADR-001-architecture-style.md` | modular monolith/outbox/processes | G0 |
| `docs/adr/ADR-002-frontend.md` | Next/React/Tailwind/Radix/Motion | G0/G9 |
| `docs/adr/ADR-003-backend.md` | Fastify REST/SSE TypeScript | G0/G4 |
| `docs/adr/ADR-004-database.md` | PostgreSQL/Drizzle/pgvector | G2 |
| `docs/adr/ADR-005-ai-provider-strategy.md` | AI SDK/OpenAI/provider abstraction | G5 |
| `docs/adr/ADR-006-rag.md` | PostgreSQL hybrid retrieval | G6 |
| `docs/adr/ADR-007-agent-orchestration.md` | one orchestrator/logical roles | G5 |
| `docs/adr/ADR-008-authentication.md` | anonymous sessions/Better Auth | G3 |
| `docs/adr/ADR-009-deployment.md` | Hetzner/Docker/Cloudflare/Caddy | G0/G17 |
| `docs/adr/ADR-010-jobs.md` | pg-boss durable/Redis ephemeral | G2 |
| `docs/adr/ADR-011-observability.md` | OTel/Langfuse/logs/metrics | G5/G15 |
| `docs/adr/ADR-012-generative-ui.md` | schema/registry/action IDs | G1/G9 |
| `docs/adr/ADR-013-crm-abstraction.md` | canonical CRM/provider adapter | G10 |
| `docs/adr/ADR-014-support-boundary.md` | public MVP/private V1 | G12 |
| `docs/adr/ADR-015-multitenancy.md` | tenant-ready shared schema | G2/G3 |
| `docs/adr/ADR-016-postgres-contention-mitigation.md` | pooling/autovacuum/extraction triggers for OLTP+vector+FTS+jobs on one instance | G2/G6/G10/G16 |

## Product files

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `docs/product/user-journeys.md` | anonymous/lead/client/support/human/admin/sales/support steps, data, tools, failure, exits | PROJECT | G3–G14 |
| `docs/product/new-business-flow.md` | non-linear stages, value/question rules, stop/audit behavior | journeys | G7 |
| `docs/product/briefing-qualification-opportunity.md` | field provenance, formula/weights/coverage, map/NBA schema rules | commercial scope | G7/G8 |
| `docs/product/support-system.md` | categories, deterministic severity/SLA/routing/ticket lifecycle | support boundary | G12 |
| `docs/product/admin-and-productization.md` | minimal admin, publish lifecycle, code classification | productization | G14 |

## Agent and prompt files

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `docs/agents/concierge-agent.md` | orchestrator purpose/input/output/tools/limits/evals | ADR-007 | G5 |
| `docs/agents/new-business-agent.md` | commercial capability/permissions/escalation/evals | new-business | G7 |
| `docs/agents/qualification-agent.md` | AI extraction versus deterministic scoring | qualification | G8 |
| `docs/agents/support-agent.md` | public/private/severity/support limits | support | G12 |
| `docs/agents/knowledge-agent.md` | grounded retrieval/citation/abstention | RAG | G6 |
| `docs/agents/handoff-agent.md` | package/facts/hypotheses/routing/evals | handoff | G13 |
| `packages/ai/prompts/README.md` | composition/version/publish/eval architecture | AI security | G5 |
| `packages/ai/prompts/global-system.md` | global purpose/trust/non-fabrication/output rules | prompt architecture | G5 |
| `packages/ai/prompts/brand-personality.md` | concise strategic tenant voice baseline | brand principles | G5 |
| `packages/ai/prompts/concierge.md` | role routing/open-thread/clarification behavior | concierge spec | G5 |
| `packages/ai/prompts/new-business.md` | problem-first adaptive discovery | new-business spec | G7 |
| `packages/ai/prompts/support.md` | support classification/private boundary | support spec | G12 |
| `packages/ai/prompts/qualification.md` | evidence-only qualification extraction | qualification spec | G8 |
| `packages/ai/prompts/knowledge.md` | grounded citation/abstention/injection | knowledge spec | G6 |
| `packages/ai/prompts/handoff.md` | structured evidence-linked summary | handoff spec | G13 |
| `packages/ai/prompts/tool-policy.md` | capability/precondition/confirmation/result rules | tool catalog | G5 |
| `packages/ai/prompts/security-policy.md` | trust zones/privacy/unauthorized behavior | AI security | G5 |

## API, tool, integration and contract files

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `docs/api/api-contract.md` | REST/SSE endpoints, auth, rates, errors, compatibility | architecture/journeys | G1/G4 |
| `openapi/openapi.yaml` | machine-readable public MVP paths/schemas/security | API contract | G1 |
| `docs/api/error-taxonomy.yaml` | HTTP/user/retry/log mapping | failure model | G1 |
| `docs/tools/tool-catalog.yaml` | every tool caller/auth/confirm/input/output/idempotency/error/audit | domains/security | G1/G5–G13 |
| `docs/integrations/provider-interfaces.md` | CRM/calendar/support/channel ports and adapter rules | ADRs | G1/G10–G12 |
| `packages/contracts/structured-output.schema.json` | intent/state/brief/qualification/map/support/NBA/handoff JSON schemas | product/agents | G1 |
| `packages/contracts/generative-ui.schema.json` | approved versioned UI descriptor union | GenUI spec | G1/G9 |
| `packages/contracts/event-envelope.schema.json` | canonical internal event envelope | events | G1/G2 |

## Database and knowledge files

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `docs/database/schema.sql` | conceptual complete tables/constraints/indexes/vector | domains/contracts | G2 |
| `docs/database/erd.md` | major cardinalities and authority note | schema | G2 |
| `docs/database/migrations-and-seeds.md` | naming/forward/expand-contract/roles/seeds/embedding model | schema/ops | G2/G6 |
| `docs/database/data-retention.md` | classification, retention, deletion/export/backup tombstone | LGPD/data | G2/G16 |
| `docs/knowledge/knowledge-and-rag.md` | taxonomy, ingestion/chunks/retrieval/citations/stale/threshold | ADR-006 | G6 |

## UX files

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `docs/ux/generative-ui.md` | registered component semantics/renderer/action/version rules | UI schema | G9 |
| `docs/ux/chat-experience.md` | desktop/tablet/mobile states, streaming/composer/scroll/error/privacy | journeys | G4/G9 |
| `docs/ux/mobile-design-motion.md` | viewport/keyboard/safe area/touch/tokens/motion/reduced motion | design | G9 |
| `docs/ux/accessibility-browser-performance.md` | WCAG checklist, browser/device matrix, CWV/bundle/API budgets | UX/ops | G9/G16 |

## Security files

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `docs/security/threat-model.md` | assets/boundaries/threat/control/test and update triggers | architecture | G3/G5/G16 |
| `docs/security/ai-security.md` | trust hierarchy, output/tool controls and red-team families | AI/tool architecture | G5/G16 |
| `docs/security/uploads-rate-audit.md` | V1 upload pipeline/limits, route limits, audit fields/immutability | security/data | G3/G16/V1 |
| `docs/security/lgpd.md` | purposes/bases/minimization/rights/processors/consent/incidents | privacy/legal review | G3/G16/G17 |
| `docs/security/authorization-matrix.md` | roles/resources/actions plus tenant/state/consent constraints | identity/domains | G3/G14 |

## Testing, analytics and matrices

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `docs/testing/test-strategy.md` | pyramid, layout, thresholds, CI tiers/flaky policy | DoD | G0 onward |
| `docs/testing/ai-evals.md` | 12 suites, methods, version/evidence/release policy | agents/AI | G5/G15 |
| `docs/testing/e2e-load-resilience.md` | exact journeys, load profiles/pass/faults | product/SLO | G4 onward/G16 |
| `tests/fixtures/golden-conversation.schema.json` | versioned eval record contract | eval strategy | G5 |
| `tests/fixtures/golden-conversations.jsonl` | initial 10 representative scenarios/assertions | journeys/security | G5 onward |
| `docs/analytics/analytics-observability.md` | events/MBC/funnel/intelligence/AI telemetry/dashboards/alerts | metrics/privacy | G15 |
| `docs/matrices/implementation-matrix.md` | gate capability/dependency/files/tests/evidence | gates | planning/final |
| `docs/matrices/traceability-matrix.md` | requirement→component→gate→test→acceptance | all specs | planning/final |
| `docs/matrices/risk-register.md` | probability/impact/mitigation/owner layer | audit | planning/every gate |

## Infrastructure, operations and runbooks

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `docs/infrastructure/production-topology.md` | launch/scale nodes, containers, networks, backups/RPO/RTO | ADR-009 | G16/G17 |
| `docs/infrastructure/containers-and-deployment.md` | Dockerfile/Compose/Caddy/Cloudflare/deploy/rollback spec | topology/CI | G0/G17 |
| `docs/infrastructure/configuration-feature-flags.md` | config precedence/validation, flag dependencies, secrets lifecycle | env/security | G1/G17 |
| `docs/infrastructure/ci-cd-github.md` | pipeline gates, repository protection/actions/secrets | contributing/DoD | G0/G17 |
| `docs/operations/health-slos-dashboard.md` | health/readiness, worker heartbeat, SLO/error budget/panels | operations | G4/G15/G17 |
| `docs/runbooks/deployment.md` | preconditions, deploy/smoke/observe/abort | infrastructure | G17 |
| `docs/runbooks/database-restore.md` | isolated restore/WAL/integrity/reconcile/cutover | backups/data | G16/G17 |
| `docs/runbooks/ai-provider-outage.md` | circuit/fallback/degrade/recover | model routing | G15/G16 |
| `docs/runbooks/crm-outage.md` | canonical pending/retry/reconcile | CRM | G10/G16 |
| `docs/runbooks/security-incident.md` | declare/preserve/contain/notify/recover/postmortem | threat/LGPD | G16 |
| `docs/runbooks/rollback.md` | flag/code/schema/job-compatible rollback | deployment/migrations | G16/G17 |
| `docs/runbooks/secrets-rotation.md` | current/previous/revoke/compromise lifecycle | secrets | G16/G17 |

## Codex execution files

All gate files contain objective, read-first, scope, exact file groups, constraints, tests/commands, acceptance and report. Dependency is prior gate evidence; phase equals gate.

| Path | Gate outcome |
|---|---|
| `docs/codex/STATUS.md` | authoritative gate/evidence state |
| `docs/codex/COMPLETION_REPORT_TEMPLATE.md` | exact non-vague report format |
| `docs/codex/G0-repository-foundation.md` | monorepo/tooling/CI skeleton |
| `docs/codex/G1-contracts-configuration.md` | executable schemas/config/errors |
| `docs/codex/G2-database-outbox.md` | data/migrations/tenant/jobs |
| `docs/codex/G3-identity-consent-policy.md` | sessions/auth/consent/authz |
| `docs/codex/G4-conversation-streaming.md` | message/state/SSE/resume |
| `docs/codex/G5-ai-orchestration.md` | model/context/prompts/policy/tools |
| `docs/codex/G6-knowledge-rag.md` | publication/ingestion/hybrid retrieval |
| `docs/codex/G7-discovery-briefing.md` | discovery/brief/insight/map/audit |
| `docs/codex/G8-qualification-next-action.md` | deterministic qualification/NBA |
| `docs/codex/G9-generative-ui-workspace.md` | responsive registered workspace |
| `docs/codex/G10-crm-integration.md` | canonical commercial/CRM sync |
| `docs/codex/G11-calendar-booking.md` | slots/timezone/exact booking |
| `docs/codex/G12-support-triage.md` | public support/severity/request |
| `docs/codex/G13-human-handoff.md` | package/routing/takeover/notification |
| `docs/codex/G14-admin-quality.md` | minimal operations/publishing console |
| `docs/codex/G15-analytics-observability-evals.md` | telemetry/funnel/full eval baseline |
| `docs/codex/G16-hardening.md` | security/a11y/load/resilience/restore |
| `docs/codex/G17-production-release.md` | live infrastructure/providers/release |

## Validation

| Path | Purpose / required contents | Dependency | Phase |
|---|---|---|---|
| `scripts/verify-blueprint.mjs` | required/non-empty/JSON/JSONL/ADR/gate/scenario validation and counts | manifest/tree | planning/G0 |

## Implementation files Codex creates

Exact domain internals may split only within these locked groups; exported contracts/names stay stable.

| Gate | Required file groups |
|---|---|
| G0 | root pnpm/Turbo/TS/lint/format configs and lock; manifests/entrypoints for `apps/{web,admin,api,worker}` and every package in intended tree; `.github`; dev/test Compose; hierarchical AGENTS |
| G1 | `packages/contracts/src/{api,events,ai,tools,ui,errors,providers,ids}.ts`; config schemas/loaders/flags; generators/tests |
| G2 | database `schema/*`, `migrations/*`, repositories/transaction/tenant context/seeds; events/outbox/pg-boss handlers/tests |
| G3 | identity domain/repos; security session/authz/CSRF/rate/redaction; API plugins/routes and auth UI/tests |
| G4 | conversation domain/repos/services/state; API routes/SSE; web workspace store/shell; fake run engine/tests |
| G5 | AI gateway/providers/router/context/prompt/orchestrator; policy registry/executor; telemetry/eval harness |
| G6 | knowledge domain/repos/parsers/chunker/embedding/retrieval; ingestion jobs; migrations/fixtures/evals |
| G7 | commercial discovery/brief/insight/map; tool handlers; analyzer worker/API/tests |
| G8 | qualification config/calculator/snapshots/NBA policy and tests |
| G9 | UI tokens/primitives/registry/components/stories; web workspace implementation and visual/a11y tests |
| G10 | commercial contact/company/lead/opportunity; CRM ports/adapters/sync/webhooks/reconcile/tests |
| G11 | meetings/calendar ports/adapters/slot token/UI/webhooks/tests |
| G12 | support category/severity/SLA/request/routing/tool/API/UI/evals |
| G13 | handoff package/domain/notification ports/adapters/takeover/UI/evals |
| G14 | admin routes/components/staff APIs/read views/publication workflows/tests |
| G15 | OTel/log/metrics/Langfuse/Sentry/PostHog adapters; event views; dashboards/alerts; full datasets/runner |
| G16 | security/a11y/load/fault/recovery suites, reports and hardening config |
| G17 | production Compose/Caddy/Cloudflare/provisioning/monitoring/smoke/release records; no secrets |

No application source exists in this planning package; G0 is the authorized start.
