# Risk Register

| Risk | Probability | Impact | Mitigation / trigger | Owner layer |
|---|---|---|---|---|
| feels like generic chatbot | Medium | Critical product | value artifacts/MBC/user tests; stop launch if usefulness low | Product/UX |
| interrogative/too long | High | High | value/question budget, drop-off analytics, eval | Product/AI |
| wrong diagnosis/fake certainty | Medium | High | evidence/confidence/preliminary/correction/human review | AI/Product |
| fabricated case/price/result | Medium | Critical | canonical tools/citations, deterministic assertion 0 | AI/Knowledge |
| qualification bias/false precision | Medium | High | unknown coverage, explained rules, protected fields excluded, human review | Product/Legal |
| prompt/knowledge injection | High | Critical | trust zones, tool policy, injection suite | Security/AI |
| unauthorized/cross-tenant data | Low | Critical | TenantContext/composite FK/RLS/matrix/canary | Security/Data |
| client impersonation | Medium | Critical | uniform verified auth/resource membership | Identity/Security |
| tool side-effect abuse | Medium | Critical | schema/policy/confirmation/idempotency/audit | Security/Domain |
| SSRF/malicious file | Medium | Critical | constrained fetch/quarantine/scan/sandbox; uploads V1 | Security/Infra |
| model outage/latency | High | Medium | router/fallback/circuit/static/human path | AI/Ops |
| CRM/calendar duplicate/divergence | Medium | High | internal authority, idempotency, mapping/reconcile | Integrations |
| mobile keyboard/scroll failure | Medium | High | visualViewport/device E2E/manual matrix | UX/Web |
| site performance regression | Medium | High | lazy/bundle/CWV/load budgets | Web/Ops |
| excessive AI/telemetry cost | Medium | High | task routing/cache/budgets/breakers/sampling | AI/Ops |
| PII in logs/traces | Medium | Critical | classification/redaction/sampling/deletion tests | Privacy/Ops |
| stale knowledge | High | High | effective dates/review/publish/index/rollback | Knowledge |
| overengineering delays launch | High | High | gate scope/modular monolith/MVP exclusions | Architecture/Product |
| single-host outage | Medium | High | separate DB/recommended two app nodes/backups; disclose profile | Infra |
| restore fails | Low | Critical | monthly isolated drill/WAL/checksum/runbook | Data/Ops |
| admin overreach/secrets | Medium | Critical | same APIs/role matrix/no secret readback/audit/re-auth | Security/Admin |
| legal basis/processor gap | Medium | High | counsel/DPA/subprocessor/notice gate before G17 | Privacy/Legal |
| low volume prevents learning | Medium | Medium | qualitative review plus four-week/500-conversation revisit | Product |

Probability/impact are reviewed at each gate. A release blocker cannot be downgraded merely because probability is low. Named individuals and dates are assigned when implementation begins.
