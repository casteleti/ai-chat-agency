# Bounded Contexts and Dependency Rules

| Context | Owns | Exports | Must not know |
|---|---|---|---|
| Identity | visitors, users, sessions, memberships, consent | actor resolution, auth policies | AI provider details |
| Conversation | threads, participants, messages, state, summary | message commands, resume/read models | CRM SDKs, prompt text |
| AI orchestration | runs, context, routing, prompt/agent versions | `executeTurn`, structured proposals | direct DB tables outside repositories |
| Policy/tools | capability registry, confirmations, tool calls | authorized executor | UI internals, vendor SDK leakage |
| Knowledge | documents, versions, chunks, retrieval | publish/ingest/search/cite | conversation writes |
| Commercial | company/contact/lead/opportunity/brief/qualification | commercial commands/read models | external CRM models |
| Meetings | scheduling intent, slots, booking | calendar port/service | provider-specific fields |
| Support | request, classification, severity, ticket, SLA | triage/ticket commands | private data without Identity policy |
| Integrations | adapters, mappings, webhooks, sync state | provider ports/adapters | product decisions |
| Experience | UI descriptors, website context | renderer contract | arbitrary model content |
| Analytics/quality | events, aggregates, feedback, eval results | event/eval queries | primary domain mutation |
| Admin/config | flags, agency settings, publication workflows | governed configuration | bypass of domain policies |

Allowed dependency direction: apps → application services → domain → ports. Infrastructure implements ports. Contracts may be imported by all, but contain no domain behavior. Cycles are forbidden and checked by dependency-cruiser or equivalent in G0.

Cross-context transaction: command service may coordinate repositories through a small application use case only when invariants require atomicity. Cross-context eventual work uses outbox. A domain event is a fact, not an instruction to an AI model.
