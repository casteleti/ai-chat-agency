# G7 — Discovery, Briefing, Insights and Website Audit

## Objective

Create the memorable commercial experience: adaptive problem-first discovery that produces correctable value artifacts.

## Read First

G6 evidence, new-business flow, briefing/opportunity spec, new-business/knowledge agent specs, structured outputs, website security.

## Scope

Intent/role switch, question/value budget and open threads; briefing aggregate/version/patch/source/confidence/correction UI read model; insight and opportunity-map validation/persistence; case/service matching; preliminary website analyzer with SSRF-safe fetcher; dynamic context from page/UTM; pt/en behavior; product events.

## Files

Commercial discovery domain/services/repositories; new-business prompt version; tools `updateBriefing`, `generateOpportunityMap`, cases/services/website analysis; analyzer worker; API routes; tests/evals. UI uses placeholder/basic render until G9.

## Constraints

One primary question; value before identity; no invented metrics/cases/prices; max five opportunities; evidence/preliminary/confidence required; URL HTTPS/public-only with redirect/DNS/time/size policies.

## Tests/Commands

Intent switch/correction/repetition/question budget; brief extraction/source/version conflict; map evidence; cases canonical; SSRF IPv4/6/DNS/redirect/size/content; website failure graceful; golden conversations. `test:evals test:security test:e2e verify`.

## Acceptance Criteria

Intent ≥95%; fabricated cases/prices 0; value-before-identity ≥95%; briefing corrections exact; SSRF suite 100%; artifact useful/correct on human-reviewed release sample.

## Completion Report

Report eval dataset size/subgroup metrics and analyzer attack cases; no visual polish claim before G9.
