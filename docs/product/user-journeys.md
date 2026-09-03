# User Journeys

Each journey is non-linear: the user may correct data, ask a side question, switch intent, pause, resume, or request a human. Lifecycle state and business stage are stored separately.

## Anonymous visitor

- Trigger: opens Concierge from a page/launcher.
- Steps: consent notice → entry choice or free text → receives immediate contextual response → optionally continues.
- System: create signed visitor/session/conversation; capture only consented page/UTM/referrer; detect language/intent; never infer authenticated client identity.
- Data: visitor session, consent version, conversation, messages, product events.
- Tools: public knowledge only until context warrants others.
- Failures: cookies blocked uses non-resumable in-memory client ID; rate/AI outage offers static contact path.
- Exit: abandoned, resumed, converted to identified lead, support handoff, completed.

## New-business lead

- Trigger: commercial/project/AI/business challenge intent.
- Steps: problem-first dialogue → initial insight → business context → evolving brief → opportunity map → relevant evidence → qualification → next action.
- System: apply question budget; extract typed fields with confidence; show corrections; avoid contact request until value or operational need.
- Data: company hypothesis, briefing versions, insights, qualification inputs/result, lead after identification.
- Tools: knowledge/cases/services, website audit with consent, update briefing, qualification, CRM only after identity/confirmation policy.
- Failures: low context produces explicit open questions; website fetch failure does not block conversation.
- Exit: meeting, handoff, nurture/DIY next step, poor-fit guidance, resume later.

## Qualified lead

- Trigger: deterministic score and confidence meet threshold or a human-request override.
- Steps: view preliminary recommendation → choose meeting/handoff → provide verified contact identity → select slot.
- System: show why fit is assessed, not hidden score manipulation; create canonical lead/opportunity; sync asynchronously; prepare meeting pack.
- Data: qualification snapshot, contact verification, opportunity, meeting intent/booking, audit.
- Failures: CRM pending sync is transparent internally; calendar outage captures preferred times.
- Exit: scheduled, human pending, nurture.

## Returning lead

- Trigger: signed visitor resumes or verified email links prior public conversation.
- Steps: see concise resume summary → confirm/correct stale facts → continue current intent.
- System: do not merge identities solely on a typed email; verified link transaction required across devices.
- Data: resume event, superseding corrections, new summary.
- Failures: expired/deleted session starts fresh and explains privacy retention, without pretending memory.
- Exit: same as new-business.

## Existing client (MVP)

- Trigger: selects “already a client” or support intent.
- Steps: explain public/basic boundary → collect issue and safe identifiers/contact → public grounded answer or handoff.
- System: never reveal whether an email/company is a client; no private project/account lookup in MVP.
- Data: support request, public conversation, severity, contact route.
- Tools: public knowledge, create support request, handoff.
- Failures: urgent SEV-1 shows immediate emergency path while persisting request.
- Exit: public resolution, human pending.

## Existing client (V1 authenticated)

- Trigger: private question requires account data.
- Steps: magic link/OTP → resolve membership/resource → retrieve authorized project/ticket/knowledge → answer or create/update ticket.
- System: uniform auth messages, short TTL, resource-scoped checks per tool, re-auth for high-risk changes.
- Data: session, membership access audit, ticket/actions.
- Failure: authentication failure collects no private details; membership ambiguity routes to human.
- Exit: resolved, ticketed, human takeover.

## Support request

- Trigger: classified support intent.
- Steps: categorize → collect impact/scope/timing → severity rules → knowledge resolution attempt → request/ticket → handoff as needed.
- System: severity is deterministic; AI extracts evidence and drafts summary but cannot downgrade hard signals.
- Data: classification, evidence, SLA timestamps, owner route, resolution.
- Failure: provider unavailable uses internal canonical ticket and pending sync.
- Exit: resolved, awaiting user, queued, escalated.

## Human agent

- Trigger: explicit user request, policy decision, low confidence, failure, sentiment/urgency, or high-value opportunity.
- Steps: receive handoff package → acknowledge context → take ownership → reply externally or contact → close/return to AI.
- System: lock active speaker mode, preserve audit, display AI suggestions as drafts only.
- Data: assignment, takeover, messages, resolution and feedback.
- Failure: no assignee triggers fallback team/alert and honest user status.
- Exit: completed, waiting, returned to AI with user-visible disclosure.

## Administrator

- Trigger: staff login with authorized role.
- Steps: inspect dashboard/conversation/quality → manage draft knowledge/config → review/publish → observe index/evals/audit.
- System: admin actions use the same APIs/policies; production publishing requires immutable version and audit.
- Data: drafts, approvals, versions, audit, eval runs.
- Failure: failed publish/index keeps prior active version and shows recovery.
- Exit: saved draft, published, reverted via new version.

## Sales team

- Trigger: qualified lead, meeting or handoff notification.
- Steps: inspect company/brief/opportunity/evidence/open questions → accept assignment → add note/outcome.
- System: show source/confidence and CRM sync status; no raw hidden reasoning.
- Exit: meeting held, opportunity advanced, disqualified with reason, nurture.

## Support team

- Trigger: routed support request/ticket.
- Steps: inspect severity/evidence/history/files(V1) → accept → communicate → resolve/close.
- System: SLA clock, priority override with reason, audit, knowledge-gap capture.
- Exit: resolved, waiting customer, escalated internally.
