# Implementation Matrix

| Gate | Capability | Dependencies | Main files/packages | Tests | Completion evidence |
|---|---|---|---|---|---|
| G0 | monorepo/tooling/CI skeleton | blueprint | root, apps, packages, `.github` | build/unit/boundary | clean frozen build/CI |
| G1 | executable contracts/config | G0 | contracts/config/OpenAPI | contract/property/drift | generated specs/hash |
| G2 | DB/outbox/jobs | G1 | database/events/worker | migration/idempotency/repository-RLS | migration ledger/query plans |
| G3 | session/auth/consent/authz | G2 | identity/security/API | auth/security/matrix/IDOR | zero unauthorized access |
| G4 | messages/state/SSE/resume | G3 | conversation/API/web | state/concurrency/reconnect/E2E | no lost/duplicate messages |
| G5 | model/context/orchestrator/tools | G4 | AI/policy/observability | schema/tool/injection/eval | versions/traces/thresholds |
| G6 | knowledge lifecycle/RAG | G5 | knowledge/worker/pgvector | retrieval/permission/citation/load | recall/grounding/query plans |
| G7 | discovery/brief/opportunity/audit | G5,G6 | commercial/analyzer/tools | golden/SSRF/correction | intent/value/artifact metrics |
| G8 | qualification/next action | G7 | qualification/policy | exact/property/eval/E2E | algorithm/version thresholds |
| G9 | Generative UI/workspace | G4,G7,G8 | UI/web | a11y/visual/mobile/bundle | browser matrix/artifacts |
| G10 | lead/opportunity/CRM | G2,G8 | commercial/integration | fault/idempotency/webhook | no duplicates/reconciliation |
| G11 | calendar/meeting | G3,G8 | meeting/integration/UI | timezone/race/fault/E2E | exact one booking |
| G12 | public support/triage | G4,G5,G6 | support/tools | severity/private/eval/E2E | SEV-1 recall/private 0 |
| G13 | handoff/notifications | G7,G10,G12 | handoff/notifications | package/routing/retry/E2E | no repetition/durable ref |
| G14 | admin/publishing/quality | G6–G13 | admin/staff API/views | role/publish/a11y/E2E | safe operations console |
| G15 | analytics/AI observability/evals | G5–G14 | telemetry/events/evals | privacy/trace/full eval | dashboards/baseline report |
| G16 | hardening/recovery/load | G0–G15 | security/infra/runbooks | full matrix/load/restore | signed hardening report |
| G17 | production MVP | G16 | deployment/config/content | live smoke/rollback/monitor | release record/healthy window |
