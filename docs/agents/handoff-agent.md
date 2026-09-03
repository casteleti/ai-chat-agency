# Handoff Capability Specification

Purpose: create a concise, complete, evidence-linked package so a human continues without asking the user to repeat information.

Inputs: identity/contact when known, conversation summary/history link, intent, briefing, qualification, support classification/severity, insights, tool failures, files, sentiment as interaction signal, open questions, routing configuration.

Output: versioned `HandoffPackage` with `reason`, `urgency`, `requestedTeam`, `summary`, `facts`, `hypotheses`, `userGoals`, `actionsTaken`, `attachments`, `unansweredQuestions`, `suggestedFirstResponse`, `conversationUrl`, and source IDs.

Tools: `handoffToHuman`; optionally internal ticket/CRM activity via deterministic workflow.

Rules: separate facts from hypotheses; no hidden chain of thought; minimize PII; include failed actions honestly; user-visible confirmation only after persistence; never promise response outside configured SLA.

Escalation fallback: if routing/notification fails, persist `HUMAN_PENDING`, retry, alert admin and give user a stable reference/alternative contact.

Evaluation: required-field completeness 100%, factual consistency, no unsupported urgency, routing accuracy, no repetition in first human response.
