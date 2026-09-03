# Roadmap and Gate Map

Release labels describe product value; implementation gates describe dependency order.

## MVP

G0–G17 deliver the public commercial concierge, public/basic support handoff, admin review, secure production foundation, and measurement. Launch is intentionally narrow: Portuguese/English web, one CRM adapter, one calendar adapter, internal support/handoff, and curated knowledge.

## V1

Authenticated clients, private project/ticket knowledge, secure uploads, ticket lifecycle, WhatsApp continuity, cross-device memory, voice-to-text, richer admin/evals. V1 begins only after MVP funnel and support demand are measured.

## V2

Governed business intelligence: ads/analytics/search/CRM read adapters, cross-source diagnostics, reporting, and explicitly subscribed proactive signals.

## Gates

| Gate | Outcome | Depends on |
|---|---|---|
| G0 | Repository foundation | Blueprint |
| G1 | Contracts and configuration | G0 |
| G2 | Database and outbox | G1 |
| G3 | Identity, consent, resource policy | G2 |
| G4 | Conversation API and streaming | G3 |
| G5 | AI gateway, prompts, context, policies | G4 |
| G6 | Knowledge ingestion and RAG | G5 |
| G7 | Discovery, briefing, insights | G5,G6 |
| G8 | Qualification and next action | G7 |
| G9 | Generative UI and mobile workspace | G4,G7,G8 |
| G10 | CRM integration | G2,G8 |
| G11 | Calendar booking | G3,G8 |
| G12 | Support collection and triage | G4,G5,G6 |
| G13 | Human handoff and notifications | G7,G10,G12 |
| G14 | Admin, knowledge workflow, quality | G6–G13 |
| G15 | Analytics, observability, evals | G5–G14 |
| G16 | Security, accessibility, resilience, load | G0–G15 |
| G17 | Production deployment and release | G16 |

Parallel work is allowed only where dependencies show independence and contracts are already frozen. G10 and G11 may proceed in parallel after G8. G12 can proceed after G6. G9 should not finalize visual behavior until G7/G8 schemas are stable.
