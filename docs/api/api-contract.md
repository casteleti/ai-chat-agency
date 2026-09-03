# API Contract

Canonical machine contract: `/openapi/openapi.yaml`. All routes are under `/v1` except health. JSON uses camelCase, UUIDv7 strings, RFC 3339 UTC timestamps. Auth is anonymous signed cookie or Better Auth cookie; cookie mutations require same-origin/CSRF control. Every request receives `X-Request-Id`; commands accept/require `Idempotency-Key` as specified.

## Public conversation

| Method/path | Purpose | Auth/rate |
|---|---|---|
| `POST /v1/conversations` | start/resume signed anonymous conversation | 10/IP/hour, 5/visitor/hour |
| `GET /v1/conversations/{id}` | owner-safe transcript/state/UI read model | owner session; 60/min |
| `POST /v1/conversations/{id}/messages` | persist message and start run; returns run/stream URL | owner; 30 messages/hour; required idempotency |
| `GET /v1/conversations/{id}/runs/{runId}/events` | SSE progress/text/UI/tool status; `Last-Event-ID` resume | owner; max 2 connections |
| `POST /v1/conversations/{id}/confirmations/{id}` | approve/deny pending action | owner; required idempotency |
| `PATCH /v1/conversations/{id}/briefing` | correct allowed briefing fields | owner; ETag/expected version |
| `POST /v1/conversations/{id}/identity/challenge` | send uniform magic link/OTP for save/booking | strict IP/email limit |
| `POST /v1/conversations/{id}/identity/verify` | verify and link contact with consent | one-time token |

## Knowledge, analysis, meetings and handoff

- `POST /v1/website-analyses`: explicit URL audit request; returns accepted job/read model.
- `GET /v1/website-analyses/{id}`: owner status/result.
- `GET /v1/meeting-types`: public configured types.
- `GET /v1/meeting-types/{id}/slots?from&to&timeZone`: normalized short-lived slots.
- `POST /v1/meetings`: verified contact, slot token, required idempotency.
- `POST /v1/support-requests`: safe public support request, consent, required idempotency.
- `POST /v1/handoffs`: explicit or policy-issued handoff package, required idempotency.

## Authenticated/admin

Better Auth endpoints are mounted under `/v1/auth/*` per generated/locked adapter contract. Staff routes: conversations/leads/opportunities/meetings/support/knowledge/prompt versions/agent versions/evals/integrations/audit/settings. They use cursor pagination, role/resource authorization, filter allowlists, and audit privileged reads/writes. No generic admin “execute tool” endpoint.

## SSE event types

`run.started`, `response.delta`, `response.completed`, `progress.updated`, `ui.component`, `tool.pending_confirmation`, `tool.started`, `tool.completed`, `tool.failed`, `run.failed`, `heartbeat`. Each includes monotonically increasing event ID, run ID, timestamp and schema version. The persisted final message is authoritative; deltas may be discarded after completion.

## Error envelope

```json
{
  "error": {
    "code": "RATE_LIMITED",
    "message": "Too many requests. Try again shortly.",
    "requestId": "019...",
    "retryable": true,
    "retryAfterSeconds": 30,
    "details": []
  }
}
```

Details contain field-safe validation issues only. Never expose stack, SQL, prompt, provider body, token or resource existence where enumeration is possible.

## Compatibility

Within `/v1`, additions are backward compatible. Removing/renaming/changing meaning requires `/v2` or additive deprecation window. Events, jobs, JSONB and UI descriptors carry independent schema versions and parsers support in-flight prior versions.
