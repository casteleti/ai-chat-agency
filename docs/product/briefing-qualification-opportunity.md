# Briefing, Qualification and Opportunity Map

## Progressive briefing

The canonical briefing is versioned and correctable. Every field stores `value`, `status` (`UNKNOWN|INFERRED|CONFIRMED|REJECTED`), `confidence` 0–1, `sourceMessageIds`, and `updatedAt`.

Field groups: company (name/domain/industry/size/geography/business model); audience/market; offer/sales cycle; acquisition and channels; sales process/CRM/follow-up; technology/data/AI maturity; primary challenge/evidence/impact; objectives and success metrics; constraints; timing; budget range/readiness (optional and never forced early); authority/stakeholders; current initiatives; opportunities; relevant services/cases; risks; unanswered questions; user corrections.

Completeness is informational, not a progress dark pattern. Weighted requiredness depends on intent. The UI may say “enough for a preliminary view” rather than “65% complete.”

## Deterministic qualification

AI extracts evidence; software computes. Each dimension receives 0–5, evidence IDs, confidence and `unknown` state. Unknown is not zero.

| Dimension | Weight | Example 5 |
|---|---:|---|
| ICP fit | 20 | B2B organization/need within served market |
| Challenge severity/impact | 15 | material revenue/cost/risk with evidence |
| Strategic/service fit | 20 | agency can credibly solve with approved capability |
| Timing/readiness | 10 | decision/action within 90 days |
| Budget readiness | 10 | realistic range or explicit funding path |
| Authority/access | 10 | decision maker or clear stakeholder access |
| Engagement/evidence quality | 5 | responsive, coherent, correctable evidence |
| Operational/data maturity | 10 | enough foundation to achieve value |

`weightedScore = Σ(score/5 × weight)` over known dimensions. `coverage = knownWeight/100`. `confidence = weighted evidence confidence / knownWeight`. Displayed score requires coverage ≥60%; otherwise show “insufficient context.” Thresholds: 75–100 `PRIORITY`; 55–74 `QUALIFIED`; 35–54 `NURTURE`; <35 `LOW_FIT`. A hard disqualifier overrides and is evaluable as a single fact as soon as it is stated (it does not require dimension coverage). Each of the three categories is a config-backed, deterministic check, not a free-form judgment call:

- **Illegal/unethical request**: matches a configured denylist of request categories (`app_settings.settings.qualification.disallowedRequestCategories`), not open-ended model discretion.
- **Unavailable geography/capability**: company geography is outside `app_settings.settings.qualification.servedGeographies`, or the stated need has no matching entry in the approved services catalog (the same canonical record set `relatedServiceIds` references) -- i.e. "unavailable capability" means "no approved service fits," reusing the existing services catalog rather than a second list.
- **Incompatible minimum**: the captured `budget range/readiness` field falls below `app_settings.settings.qualification.minimumBudgetBand`, when one has been configured.

`servedGeographies`, `disallowedRequestCategories` and `minimumBudgetBand` are business decisions the agency sets, versioned the same way as the dimension weights below; this document does not hardcode their values -- if unconfigured, there is no geography/budget hard disqualifier (illegal/unethical requests still deny by the request-category denylist default, not an empty list). A human request is always honored but does not change the score.

Recommendations combine band, confidence, urgency and user preference: priority → meeting/handoff; qualified → meeting; nurture → useful resource/follow-up; low fit → honest alternative. Scores/weights are tenant-configured and versioned; every result stores algorithm version.

## Opportunity map

Each item: `id`, `problem`, `evidence[]`, `businessImpact`, `hypothesis`, `opportunity`, `priority` (`NOW|NEXT|LATER`), `confidence`, `missingEvidence[]`, `suggestedAction`, `relatedServiceIds[]`, `risk`, and `preliminary=true`. The map also stores an optional funnel stage (`ATTENTION|DEMAND|LEAD|QUALIFICATION|SALES|REVENUE|OPERATIONS`) and contradictions.

Rules: no invented metrics, case, price or ROI; distinguish observation from inference; maximum five items in MVP; at least one evidence reference per non-generic claim; allow user corrections; never present as a final strategy/audit.

## Next best action

Deterministic candidate eligibility comes first (permissions, feature flag, fit, identity, provider state). AI may rank eligible candidates and draft rationale. Candidates: ask one clarifier, show/edit brief, show opportunity map, show approved case/service, run website audit, schedule, handoff, send secure summary, continue later, or close with guidance.
