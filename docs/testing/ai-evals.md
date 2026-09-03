# AI Evaluation Suites

Dataset record schema is `tests/fixtures/golden-conversation.schema.json`. Every record has locale, initial context, turns, expected intents/state/extractions, allowed/forbidden tools, expected evidence/citations, safety assertions and rubric. Dataset versions are immutable; annotations require two reviewers for high-risk labels.

## Suites

1. Intent/routing: new business, support, general, human, mixed/switch/ambiguous. Exact primary plus confidence/calibration.
2. Briefing extraction: field precision/recall, status/confidence/source, correction/supersession, no invented budget/authority.
3. Qualification: evidence proposal quality; deterministic engine tested separately; unknown/coverage/hard disqualifier.
4. Discovery quality: value-before-question, one-primary-question, no repetition, problem reframing grounded in evidence, stop budget.
5. Opportunity map: evidence, fact/hypothesis distinction, relevance, preliminary label, no invented metrics/ROI.
6. RAG: retrieval recall/precision, answer groundedness, citation correctness, stale/conflict/abstention, pt-BR/en-US.
7. Support: category, severity signals, public/private boundary, safe troubleshooting, escalation.
8. Tool selection/arguments: eligibility, schema, confirmation, idempotency; forbidden tools/actions 0.
9. Prompt injection/security: direct, indirect RAG/web/file, encoded/multilingual, multi-turn, tool-result injection, exfiltration.
10. Handoff: factual package, required fields, routing/urgency, first-response usefulness, PII minimization.
11. Model fallback: same schemas/safety/quality for approved alternative routes.
12. Tone/UX: concise, non-generic, no chatbot cliché, language consistency, no false human identity.

## Evaluation methods

Use deterministic assertions first. Add rule-based text/schema checks, reference matching, retrieval metrics and curated human rubrics. LLM-as-judge may score subjective usefulness only with a pinned judge, blinded candidates, calibrated examples and periodic human agreement; it never determines security pass alone.

Each run stores dataset/model/prompt/agent/router/tool/knowledge versions, config hash, seed where supported, latency/tokens/cost, per-case outcome and artifact. Compare candidate to the last production baseline. Release fails if a hard assertion fails, required threshold misses, p95 cost/latency exceeds budget without decision, or a subgroup/language regresses materially.
