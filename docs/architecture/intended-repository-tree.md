# Intended Implementation Repository Tree

G0 creates executable scaffolding; later gates populate it. Planning files already present remain the source of truth.

```text
/
├── apps/
│   ├── web/                 # public site integration + Concierge workspace
│   ├── admin/               # protected operations console
│   ├── api/                 # Fastify REST/SSE and application composition
│   └── worker/              # pg-boss consumers and scheduled work
├── packages/
│   ├── ai/                  # gateway, routing, context, prompts, orchestrator
│   ├── config/              # typed process configuration and flags
│   ├── contracts/           # Zod/TS/OpenAPI/JSON/event/UI contracts
│   ├── database/            # Drizzle schema, migrations, repositories, tests
│   ├── domain-identity/
│   ├── domain-conversation/
│   ├── domain-commercial/
│   ├── domain-knowledge/
│   ├── domain-meetings/
│   ├── domain-support/
│   ├── domain-handoff/
│   ├── integrations/        # CRM/calendar/support/email/channel adapters
│   ├── observability/
│   ├── security/
│   ├── ui/                  # tokens, primitives, registered GenUI renderer
│   └── testing/
├── docs/
│   ├── adr/ agents/ analytics/ api/ architecture/ codex/
│   ├── database/ infrastructure/ integrations/ knowledge/
│   ├── matrices/ operations/ product/ research/ runbooks/
│   ├── security/ testing/ tools/ ux/
│   ├── FILE_MANIFEST.md
│   └── PRE_DEVELOPMENT_AUDIT.md
├── infrastructure/
│   ├── caddy/ cloudflare/ compose/ monitoring/ provisioning/
│   └── README.md
├── openapi/openapi.yaml
├── scripts/                # verify, migrate, seed, smoke, backup checks
├── tests/
│   ├── contract/ integration/ e2e/ evals/ security/ a11y/ load/
│   └── fixtures/
├── .github/
│   ├── workflows/ ISSUE_TEMPLATE/ pull_request_template.md CODEOWNERS
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

Hierarchical instructions created in G0: `/apps/web/AGENTS.md` for accessibility/performance/client boundaries; `/packages/ai/AGENTS.md` for trust/evals/prompts/tools; `/packages/database/AGENTS.md` for tenant/migration/SQL rules.
