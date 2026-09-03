# E2E, Load and Resilience Scenarios

## Required E2E

1. Industrial B2B visitor → useful reframing → corrected brief → opportunity map → qualification → identity verification → slot → meeting; verify CRM pending/success, events, audit and pack.
2. Poor-fit small request → useful guidance → no manipulative meeting push → graceful close.
3. Returning signed visitor → resume summary → correct stale field → no repeated question.
4. Existing client MVP → public answer; private project question → no enumeration/data → support request/handoff.
5. SEV-1 outage/security signal → deterministic critical severity → immediate route; AI cannot downgrade.
6. Prompt injection via user/RAG/website → no policy/tool/private disclosure; safe answer/decline.
7. CRM down after canonical lead → saved + `PENDING_SYNC`, retry/reconcile, no duplicate.
8. Calendar slot race/expiry → one booking, other receives unavailable; timezone/DST exact.
9. Model fails mid-stream → persisted failed run, stable transcript, retry/human, no duplicate message/action.
10. SSE reconnect with `Last-Event-ID` → no lost/duplicate persisted final output.
11. Tenant B IDs injected into tenant A routes, RAG and action tokens → consistent not-found/forbidden and audit.
12. Mobile iOS keyboard/orientation/scroll/reduced motion; desktop keyboard/screen-reader flow.

## Load profiles

Baseline launch: 50 concurrent active conversations, 100 SSE connections, 10 new messages/s burst, 5 AI generations/s bounded, 20 RAG qps, 5 job/s, 2 uploads/s V1. Soak 4 hours at 25 active conversations. Spike 3× for 5 minutes. Test with provider latency distribution/faults, not unlimited real API spend.

Pass: error <1% excluding injected/provider-defined failures; no duplicate important writes; API p95/stream/RAG budgets met; DB CPU <70% sustained and connections <80%; queue lag <60 s normal/<5 min after spike; memory stable (<10% growth after warmup); graceful limit responses; no cross-tenant/result corruption.

## Faults

Inject model 429/5xx/timeout/malformed schema, PostgreSQL connection interruption (staging only), Redis loss, R2 failure, CRM success-with-local-timeout, calendar slot conflict, notification outage, worker crash after external success, duplicate/out-of-order webhook, stale RAG index. Assert exact fallback and reconciliation.
