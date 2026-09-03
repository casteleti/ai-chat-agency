# New Business Flow

## Stages

`ENTRY → INTENT → DISCOVERY → CONTEXT → DIAGNOSIS → BRIEFING → QUALIFICATION → RECOMMENDATION → NEXT_BEST_ACTION → MEETING/HANDOFF/CONTINUE`

Stages are evidence labels, not a rigid funnel. The orchestrator maintains `primaryIntent`, `secondaryIntents`, `journeyStage`, `conversationLifecycle`, `openThreads`, and `lastValueArtifactAt`. A user correction or changed intent may move backward. Every move stores reason/confidence; only deterministic services commit consequential state.

## Value-before-question policy

For each assistant turn choose at most one primary question unless the user explicitly requests a form/checklist. Before a personal/contact question, the conversation must have produced a value event or explain why identity is necessary (booking, delivery, cross-device resume). Question budget defaults: two consecutive question-only turns maximum; after two, provide synthesis/insight. Never ask for a field already confirmed or available through authorized context.

## Stage behaviors

| Stage | Required behavior | Exit evidence |
|---|---|---|
| Entry | Relevant opening from page/UTM without pretending certainty; choices + free text | user input |
| Intent | classify with confidence and allow correction | primary intent ≥0.75 or clarify |
| Discovery | reflect/reframe the stated problem and ask the highest-information question | problem statement + evidence |
| Context | model acquisition, conversion, operation, goals and constraints progressively | enough fields for preliminary hypothesis |
| Diagnosis | identify hypothesis, evidence, impact, confidence and missing proof | user-consumed insight/diagnostic |
| Briefing | create/update editable artifact; do not dump all fields | brief completeness and open questions |
| Qualification | extract inputs; deterministic score with reasons/confidence | saved snapshot |
| Recommendation | compose initiatives/cases from approved records; label preliminary | one useful option/next step |
| Next action | choose meeting, human, follow-up, resource or continue based on fit/readiness | explicit user selection |
| Meeting/handoff | verify identity, execute deterministic tool, show persisted result | booking/handoff reference |

## Intent changes

If a prospect switches to support, preserve commercial context but activate support permissions and never expose private data. If support becomes new business, keep issue context and enter discovery without re-asking. Side questions are answered then the orchestrator offers to resume the open thread. A user can say “skip,” “I don't know,” “go back,” or correct any field.

## Stop conditions

Stop discovery and offer a useful exit when: user requests it; meeting/human is clearly preferred; question budget is exhausted; enough evidence exists; prospect is poor fit; safety/abuse boundary is reached; or the system cannot add grounded value. Do not prolong conversation solely to maximize captured fields.

## Website mini-audit

Require user-provided public URL and explicit action. Fetch through SSRF-safe service with redirect/DNS revalidation, 10-second/3 MB limits, HTML/text only, robots/legal policy, no login/cookies. Output observations with page evidence and `preliminary=true`; do not claim SEO/performance facts that require unavailable tooling.
