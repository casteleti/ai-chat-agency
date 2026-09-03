# Context, Memory and Model Routing

## Context engine

Context blocks are assembled in this order, each with source ID, trust label, sensitivity, freshness, and token estimate:

1. Immutable global safety/tool policy and output contract.
2. Published agency brand/role prompt and capability manifest.
3. Identity, consent, locale, channel, current page and journey state.
4. Latest user message and a bounded recent message window.
5. Structured conversation state, briefing fields, corrections, open questions, qualification inputs.
6. Relevant persisted memory claims authorized for the current intent.
7. Retrieved published knowledge/cases/services with citations and visibility.
8. Fresh tool results.
9. Response style and UI budget.

Never concatenate raw blocks into instruction positions. Encode untrusted blocks as delimited data with stable IDs. Token budget default: 10% policies/contracts, 15% state/identity, 25% recent conversation/summary, 35% retrieval/tool evidence, 15% output headroom. If over budget: drop low-ranked retrieval, compress old conversation, exclude unrelated memories, then route to a larger context only if value/cost policy permits.

## Memory types

| Type | Contents | Default retention | Retrieval rule |
|---|---|---|---|
| Working | current turn scratch and tool results | turn only | always current |
| Conversation | messages + versioned summary | anonymous 90 days; identified 24 months | same conversation |
| Visitor | consented preferences/resume pointer | 90 days inactivity | signed visitor only |
| Contact/company | confirmed business facts and sourced hypotheses | 24 months/review | relevant commercial intent |
| Client/account/project | private authorized records | contract + policy | authenticated membership + resource policy |
| Organization | agency configuration/brand/process | while active | staff-only |
| Knowledge | published content | version lifecycle | visibility/effective filters |

Memory claim schema: subject, predicate, typed value, status (`OBSERVED|CONFIRMED|INFERRED|REJECTED`), confidence, source reference, sensitivity, first/last seen, expiry. User corrections supersede rather than erase history. Do not store secret credentials, special-category personal data, or speculative personal traits.

## Model routing

| Tier | Tasks | Default | Constraints |
|---|---|---|---|
| FAST | intent, extraction, language, moderation assist, short summary | GPT-5.6 Luna | structured output, low reasoning, no side effects |
| STANDARD | conversation, RAG answer, briefing question/patch, support response | GPT-5.6 Terra | grounded context, tool proposals allowed |
| REASONING | opportunity map, contradiction/reframing, complex document/strategy | GPT-5.6 Sol | explicit user value, budget/cost gate |
| VISION | V1 uploaded image/document understanding | approved vision-capable model | scan/authorization first |
| VOICE | V1 transcription, later voice | dedicated speech model | separate consent and retention |

Router inputs: task type, risk, context size, modality, language, latency target, provider health, cost budget, and eval-approved model matrix. It cannot route a high-risk action to a model lacking required structured/tool behavior. Provider fallback must pass the same schemas and task eval thresholds. Record route reason, model/provider/config, tokens, cache, latency, cost, prompt and agent version.

Model aliases are allowed locally. Production uses an approved snapshot or recorded immutable config whenever available. A model change is a behavior change requiring evals and a rollback target.
