# Complete Blueprint Tree

The future application tree is in `architecture/intended-repository-tree.md`; this is the complete planning package delivered before G0.

```text
ai-business-concierge-blueprint/
├── docs/
│   ├── adr/                    # ADR-001 through ADR-017
│   ├── agents/                 # concierge, new business, qualification, support, knowledge, handoff
│   ├── analytics/
│   │   └── analytics-observability.md
│   ├── api/
│   │   ├── api-contract.md
│   │   └── error-taxonomy.yaml
│   ├── architecture/
│   │   ├── bounded-contexts.md
│   │   ├── context-memory-model-routing.md
│   │   ├── diagrams.md
│   │   ├── events-and-resilience.md
│   │   ├── intended-repository-tree.md
│   │   └── system-architecture.md
│   ├── codex/
│   │   ├── COMPLETION_REPORT_TEMPLATE.md
│   │   ├── G0-repository-foundation.md
│   │   ├── G1-contracts-configuration.md
│   │   ├── G2-database-outbox.md
│   │   ├── G3-identity-consent-policy.md
│   │   ├── G4-conversation-streaming.md
│   │   ├── G5-ai-orchestration.md
│   │   ├── G6-knowledge-rag.md
│   │   ├── G7-discovery-briefing.md
│   │   ├── G8-qualification-next-action.md
│   │   ├── G9-generative-ui-workspace.md
│   │   ├── G10-crm-integration.md
│   │   ├── G11-calendar-booking.md
│   │   ├── G12-support-triage.md
│   │   ├── G13-human-handoff.md
│   │   ├── G14-admin-quality.md
│   │   ├── G15-analytics-observability-evals.md
│   │   ├── G16-hardening.md
│   │   ├── G17-production-release.md
│   │   └── STATUS.md
│   ├── database/               # schema, ERD, migrations/seeds, retention
│   ├── infrastructure/         # topology, containers, config/flags, CI/CD
│   ├── integrations/           # provider interfaces
│   ├── knowledge/              # knowledge taxonomy and RAG
│   ├── matrices/               # implementation, traceability, risk
│   ├── operations/             # health, SLOs, dashboards
│   ├── product/                # journeys, flows, briefing/qualification/support/admin
│   ├── research/               # verified September 2026 stack baseline
│   ├── runbooks/               # 7 operational runbooks
│   ├── security/               # threat, AI, authz, upload/rate/audit, LGPD
│   ├── testing/                # strategy, evals, E2E/load/resilience
│   ├── tools/
│   │   └── tool-catalog.yaml
│   ├── ux/                     # chat, mobile/tokens/motion, GenUI, a11y/performance
│   ├── BLUEPRINT_TREE.md
│   ├── FILE_MANIFEST.md
│   └── PRE_DEVELOPMENT_AUDIT.md
├── openapi/
│   └── openapi.yaml
├── packages/
│   ├── ai/prompts/             # README + 10 versioned prompt modules
│   └── contracts/              # structured output, GenUI and event JSON Schemas
├── scripts/
│   └── verify-blueprint.mjs
├── tests/fixtures/
│   ├── golden-conversation.schema.json
│   └── golden-conversations.jsonl
├── .env.example
├── AGENTS.md
├── ARCHITECTURE.md
├── CHANGELOG.md
├── CODEX.md
├── CONTRIBUTING.md
├── DECISIONS.md
├── DEFINITION_OF_DONE.md
├── PROJECT.md
├── README.md
├── ROADMAP.md
└── SECURITY.md
```

For the non-collapsed inventory of every individual file plus purpose, required contents, dependencies and phase, use `FILE_MANIFEST.md`.
