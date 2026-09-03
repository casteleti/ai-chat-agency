# Canonical Product Specification

Status: Approved blueprint  
Owner: Product/Agency  
Last reviewed: 2026-09-02  
Source of truth for: **WHAT is being built**

## Vision

The AI Business Concierge is the agency website's principal demonstration of competence. Every meaningful conversation should leave the visitor with a clearer understanding of their business than they had before starting it.

It is not a corner chatbot, a form disguised as chat, an autonomous sales bot, or a generic FAQ interface. It is a progressive conversational workspace that produces useful artifacts: a business context model, preliminary diagnostic, opportunity map, evolving brief, qualification result, next best action, and meeting intelligence package.

## Problem

Traditional agency contact paths lose context and demonstrate little expertise: forms collect fields, WhatsApp starts an unstructured thread, and staff repeat discovery questions. Generic chatbots add friction without insight. Support requests similarly arrive without identity, severity, project context, or a usable handoff package.

## Audiences

1. Primary MVP: anonymous or returning B2B prospects, especially owners and marketing, sales, operations, and technology leaders.
2. Agency sales/strategy staff receiving qualified conversations.
3. MVP support: visitors declaring an existing-client need; public answers and context collection only.
4. V1: authenticated client users and agency support staff.
5. Internal administrators maintaining knowledge, prompts, policies, integrations, and quality.

## Product principles

- Value before identity: do not ask for personal data until useful insight has been delivered or identity is operationally necessary.
- Think together: natural dialogue, not one-question-per-field form behavior.
- Progressive disclosure: contextual panels and cards emerge only when useful.
- Confidence over theatre: label hypotheses, evidence, gaps, and preliminary conclusions.
- AI proposes; software authorizes: permissions, calculations, writes, scheduling, and private data access are deterministic.
- Evidence on demand: cases, services, policies, and claims must resolve to approved records.
- Correctable state: users can inspect and correct the brief and derived facts.
- No repetition on handoff: humans receive the full structured package.
- Mobile is a first-class native-feeling surface.
- Product telemetry must improve usefulness, not create surveillance.

## Business objectives

- Increase meaningful business conversations per qualified site visit.
- Demonstrate the agency's strategic and AI capability before a sales call.
- Reduce manual initial discovery and CRM transcription.
- Improve meeting quality and lead-to-opportunity conversion.
- Create structured demand intelligence from conversations.
- Establish a generic core that can later be sold as a product without turning the MVP into a SaaS platform.

North-star metric: **Meaningful Business Conversations (MBC)** — a conversation with at least one validated business signal and one user-consumed value artifact (insight, diagnostic, opportunity map, brief, relevant case, or booked meeting), excluding spam and internal tests.

## MVP scope

### Public commercial concierge

- Anonymous signed session, consent, resumable conversation on the same browser.
- Entry options plus free text; intent can change at any time.
- Page and consented acquisition context (landing page and UTMs).
- Portuguese and English, determined explicitly or from user language.
- Streaming conversation with real progress states.
- Adaptive discovery with a question budget and value-before-question policy.
- Structured extraction of company context and an editable progressive briefing.
- Preliminary opportunity map and deterministic qualification.
- Retrieval-grounded service, case, FAQ, and methodology suggestions with citations.
- Safe URL-only website mini-audit with SSRF controls and a preliminary-results disclaimer.
- Dynamic next best action, calendar availability, meeting booking, CRM contact/company/opportunity synchronization, and human handoff.
- Admin review of conversations, leads, knowledge, failures, traces, and basic analytics.

### MVP support boundary

- Detect support intent.
- Answer public/general support knowledge.
- Collect issue context, severity signals, and contact path.
- Create an internal support request and human handoff.
- Do not expose project, billing, campaign, account, or client-private data.

## V1 scope

- Better Auth magic link/OTP client authentication and organization membership.
- Private account, project, ticket, and knowledge retrieval with resource-scoped authorization.
- Secure file upload and analysis.
- Internal ticket lifecycle and optional SupportProvider adapter.
- Client portal conversation resume across devices.
- WhatsApp continuity and notifications, not full omnichannel parity.
- Voice-to-text input; no realtime voice agent.
- Knowledge draft/review/publish/index lifecycle, prompt and agent publishing workflows, richer eval console.

## V2 scope

- Governed read integrations for Meta Ads, Google Ads, LinkedIn Ads, GA4, Search Console, and CRM intelligence.
- Cross-source commercial diagnostics and reporting.
- Proactive signals with explicit subscriptions and human-reviewed actions.
- Channel adapters beyond Web and WhatsApp where evidence justifies them.

## Explicitly excluded from MVP

- Multi-agent swarm, microservices, Kubernetes, Temporal, separate vector DB, self-hosted LLMs, fine-tuning.
- Realtime voice avatar, 3D character, webcam emotion detection, co-browsing.
- Arbitrary AI-generated JSX/HTML/CSS/JavaScript.
- Private client data, client authentication, project dashboards, billing resolution, file upload.
- Full WhatsApp/Instagram/email helpdesk synchronization.
- Autonomous CRM, campaign, billing, or project changes.
- Tenant billing, self-service provisioning, white-label studio, per-tenant infrastructure.

## Core use cases

- A B2B visitor explains a vague challenge; the Concierge reframes it, builds evidence, shows a preliminary opportunity map, creates a brief, and books a meeting.
- A poor-fit prospect receives a useful, honest next step without being pushed into a meeting.
- A returning visitor resumes and corrects an earlier brief.
- An existing client receives public guidance or a structured handoff without private account disclosure.
- Staff opens a meeting pack containing context, evidence, unresolved questions, qualification, files, and suggested next discussion.
- An administrator publishes a knowledge revision, observes re-indexing, tests retrieval, and sees which prompt/agent versions produced a response.

## Success criteria

MVP release is blocked unless: intent accuracy ≥95% on the approved golden set; tool authorization pass rate 100%; cross-tenant leaks 0; fabricated case and price rate 0; structured output validity ≥99%; booking timezone error rate 0; WCAG 2.2 AA critical/serious violations 0; and all G0–G17 gates provide completion evidence.

Commercial targets are baselines, not release gates: chat open-to-start ≥35%, MBC/start ≥35%, qualified conversation/MBC ≥20%, meeting/qualified ≥25%. Revisit after four weeks or 500 non-test conversations.

## Product boundaries and ownership

- Core generic: conversations, state, policies, tools, knowledge, briefing, qualification engine, Generative UI contracts, providers, telemetry.
- Agency specific: brand voice, services, cases, lead scoring weights, support categories, SLAs, prompts, knowledge content.
- Integration specific: CRM, calendar, email, support and future channel adapters.
- Client configuration: tenant settings, identity, visual tokens, enabled capabilities, retention, routing.

Any change to MVP/V1/V2 boundaries requires an update here and a decision entry; code or tickets do not override this file.

## Open product decision: qualification hard-disqualifier values

`docs/product/briefing-qualification-opportunity.md` defines hard-disqualifier qualification as a config-driven check against three tenant-level keys: `tenant_settings.settings.qualification.servedGeographies`, `.disallowedRequestCategories`, and `.minimumBudgetBand` (`docs/database/schema.sql`'s `tenant_settings.settings` jsonb column). The mechanism and its wiring are specified and implementable as-is.

**No actual values exist for these three keys anywhere in this repository** (no served-country list, no request-category denylist, no minimum-budget figure, in any doc, seed file, or schema default). This is a **product decision blocker, not a technical one**: the agency owner must define which geographies are served, what request categories are automatically declined, and what the minimum qualifying budget band is (if any) before G8 (qualification) can ship with this check active. Until set, an unconfigured tenant simply has no geography/budget hard disqualifier (the illegal/unethical-request denylist still applies via its own default, per `briefing-qualification-opportunity.md`) — the system remains safe to build and deploy without these values, but qualification accuracy for those two categories is incomplete until they are supplied.
