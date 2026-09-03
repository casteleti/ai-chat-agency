# Requirement Traceability Matrix

| Requirement | Architecture/component | Gate | Primary tests | Acceptance |
|---|---|---|---|---|
| dedicated impressive workspace | Experience + registered UI | G9 | mobile/visual/a11y/E2E | native-feeling, budgets, WCAG |
| anonymous public use/resume | Identity + Conversation | G3,G4 | session/reconnect/E2E | owner-safe resume, no auth friction |
| intent and non-linear journeys | Orchestrator/state | G5,G7 | intent/switch/golden | ≥95%, corrections preserved |
| value before personal data | discovery policy | G7 | conversation rubric | ≥95%, no form-like sequence |
| dynamic briefing | Commercial briefing versions | G7 | extraction/version/correction | sourced, editable, exact correction |
| opportunity map/reframing | Insights/map | G7 | evidence/hallucination eval | preliminary, max 5, cited |
| deterministic qualification | Qualification engine | G8 | exact/property/labeled | exact formula, ≥95% band |
| service/case evidence | Knowledge canonical records | G6,G7 | retrieval/fabrication | fabricated cases/prices 0 |
| website mini-audit | constrained analyzer | G7 | SSRF/failure/E2E | safe public URL, limitations |
| meeting scheduling | CalendarProvider | G11 | timezone/race/idempotency | duplicate/timezone error 0 |
| CRM structured data | canonical commercial + adapter | G10 | outage/reconcile/webhook | no duplicate; durable pending |
| support MVP | public RAG + severity/request | G12 | category/SEV/private | SEV-1 100%; private leak 0 |
| authenticated support V1-ready | Identity/resource/ports/schema | G3,G12 architecture | authz schema tests | disabled MVP, contracts preserved |
| human handoff context | Handoff package/routing | G13 | factuality/completeness | required 100%, no repetition |
| Generative UI safety | schema + registry + action IDs | G1,G9 | invalid/unknown/XSS/action | no arbitrary code/action |
| RAG/citations | Knowledge hybrid | G6 | recall/grounding/injection | recall≥.90, grounding≥.95 |
| layered memory | memory claims/context engine | G2,G5,G7 | relevance/retention/correction | source/confidence/authorization |
| model cost routing/fallback | Model router | G5,G15 | route/fallback/cost | approved task matrix, recorded |
| prompt/tool AI security | trust zones/policy executor | G5,G16 | injection/tool auth | unauthorized execution 0 |
| analytics/commercial signals | owned events/views | G15 | schema/dedupe/consent | MBC/funnel reproducible |
| AI observability/reproducibility | OTel/Langfuse/versioning | G5,G15 | trace/redaction/version | each run explainable |
| files secure V1-ready | R2 metadata/policy | architecture; V1 gate later | schema/threat spec | disabled MVP; complete controls |
| LGPD rights/retention | consent/retention/workflows | G3,G16 | delete/export/withdraw | lifecycle and evidence |
| performance/site protection | lazy UI/SSE/budgets | G4,G9,G16 | CWV/load/bundle | defined p75/p95 budgets |
| CI/CD/backups/runbooks | platform/operations | G0,G16,G17 | pipeline/restore/smoke | RPO≤15m/RTO≤4h, deploy proof |
