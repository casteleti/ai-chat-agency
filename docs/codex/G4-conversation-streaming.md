# G4 — Conversation Core and Streaming

## Objective

Deliver a provider-independent persistent conversation engine with resumable, idempotent SSE runs.

## Read First

G3 evidence, conversation journeys/state diagrams, API/OpenAPI, event/resilience, UX chat.

## Scope

Conversation/message/state/participant repositories and services; start/get/message/run/confirmation endpoint shells; lifecycle versus journey state machine; persisted SSE event stream with cursor/heartbeat/reconnect; one active run/conversation; cancel/retry; summaries job interface stub; page/UTM allowlist; public web workspace skeleton with offline/draft/resume/error handling using deterministic fake responder.

## Files

Conversation domain/application/repositories; API routes/SSE; web conversation store/hooks/shell; fake run engine; state/event tests and E2E.

## Constraints

No real model/RAG/tool. User message persists before run. Deltas are ephemeral/persisted events as specified; final message authoritative. Client message ID/idempotency prevents duplicate. Auto-scroll/focus follows UX spec.

## Tests/Commands

State transitions/property tests, duplicate message/run, concurrent send, disconnect/replay cursor, cancellation/failure/retry, owner/tenant access, slow client/backpressure, mobile offline draft E2E. `pnpm test:integration test:e2e test:a11y verify`.

## Acceptance Criteria

No lost/duplicate final messages on reconnect; one active run invariant; API matches OpenAPI; conversation resumes in same browser; provider-independent fake vertical slice works at 320/1440 px.

## Completion Report

Report SSE event ordering/reconnect evidence and concurrency tests; stop before real AI.
