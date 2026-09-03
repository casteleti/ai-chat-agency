# Runbook — AI Provider Outage

Trigger: error/429/timeout/TTFT threshold or provider notice. Confirm scope by model/region without sending test PII. Open circuit for failing route; reduce retries to avoid amplification.

Use an eval-approved compatible fallback for the same task/schema. If unavailable, keep conversation persistence/RAG/static support operational, disclose temporary limitation, offer retry/save/human contact. Disable website analysis/reasoning tier if cost/latency unsafe. Never claim a generated diagnostic/tool result.

Monitor queue/cost and prevent retry storm. Restore gradually after health window; compare schema/quality/latency. Record affected runs/fallback/config and sample for quality; do not replay user generations automatically unless user consent/idempotent operation makes it safe.
