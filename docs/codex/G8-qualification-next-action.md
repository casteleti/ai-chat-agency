# G8 — Qualification and Next Best Action

## Objective

Implement transparent deterministic lead qualification and safe eligible next-action selection.

## Read First

G7 evidence, qualification/opportunity spec, qualification agent, tool catalog, structured schema.

## Scope

Versioned weight/rule configuration; evidence extraction; pure exact calculation for score/coverage/confidence/band/hard disqualifier; snapshots; user/staff explanation; deterministic candidate eligibility and model ranking of eligible candidates; poor-fit/nurture/priority paths; qualification events/evals.

## Files

Qualification domain/config/calculator/repository, `calculateQualification`, next-action policy/ranker, prompt/config versions, fixtures/tests/read models.

## Constraints

Unknown is not zero; no score when coverage <60%; protected/sensitive traits excluded; model cannot alter formula/eligibility; human request always eligible without changing score; result stores algorithm/input hash.

## Tests/Commands

Table/property/boundary tests for formula, exact weights/unknown/coverage/threshold/hard rules; evidence eval; eligibility denies; configuration version; replay snapshot; fairness/protected-field assertions; E2E poor/qualified. `test:unit test:evals test:e2e verify`.

## Acceptance Criteria

Formula and unknown handling 100%; labeled band ≥95%; disallowed action 0; explanations match stored evidence/config; all bands have useful non-manipulative exit.

## Completion Report

Include algorithm version, threshold fixtures and candidate eligibility coverage.
