# Analytics, Commercial Intelligence and Observability

## Product events

`chat.opened`, `conversation.started`, `intent.selected`, `message.sent`, `value.delivered`, `briefing.viewed`, `briefing.corrected`, `briefing.sufficient`, `diagnostic.viewed`, `opportunity_map.viewed`, `case.viewed`, `qualification.completed`, `meeting.offered`, `meeting.scheduled`, `human.requested`, `handoff.routed`, `support.resolved`, `support.escalated`, `conversation.abandoned`, `conversation.resumed`, `feedback.submitted`.

Every event has schema version, timestamp, session/conversation pseudonymous IDs, locale, page/acquisition allowlist, journey state, component/action ID and consent scope. Never send message text, email, phone, company name, URL query strings or private IDs to third-party analytics. Server business events are authoritative for conversion; client events indicate viewing/interaction.

## Funnel and north star

Traffic → opened → started → MBC/value artifact consumed → qualified → meeting/handoff → opportunity → revenue. MBC requires server evidence plus client consumption. Measure messages before value/contact, consecutive question-only turns, drop-off stage/question code, correction rate, case/diagnostic engagement and time to human.

## Commercial intelligence

Nightly/near-real-time materialized views aggregate de-identified: demand by service/industry, pain-point taxonomy, funnel friction, objections, competitor/stack mentions, budget/timing bands, knowledge gaps and opportunity stage. Low-count suppression (<5) protects individual conversations; staff drill-down requires role and audit. AI-generated labels retain taxonomy/model version and confidence.

## AI telemetry

Per run: provider/model/snapshot/config, route reason, prompt/agent/tool/knowledge versions, context block token estimates, input/output/cache/reasoning tokens where exposed, cost, TTFT/latency, retries/fallback, structured validation, retrieval query/results/scores, tool policy/execution, errors and user feedback. Content is redacted/sampled by classification.

## Minimum dashboards/alerts

- Platform: request rate/p50/p95/p99, 4xx/5xx, active SSE, saturation, DB pools/locks/slow queries, Redis status, queue depth/age/dead letters.
- AI: TTFT/latency/error/fallback/schema failure, tokens/cost by task/model, tool denial/failure, RAG latency/zero-result/citation, eval trend.
- Product: starts, MBC, qualification, meeting/handoff, abandonment, support resolution/escalation by locale/device/source.
- Security: auth failures, rate/Turnstile, injection detections, forbidden tool attempts, upload/SSRF blocks.

Alert examples: API 5xx >2% 5 min; p95 ack >800 ms 10 min; model errors >10%; schema invalid >1%; queue oldest >5 min; dead letter >0 important queue; daily AI cost 80/100% budget; any unauthorized tool execution pages immediately.
