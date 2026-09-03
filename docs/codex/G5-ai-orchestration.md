# G5 — AI Orchestration, Prompts, Context and Tools

## Objective

Replace the fake responder with a safe, observable, versioned orchestrator and deterministic tool-policy pipeline.

## Read First

G4 evidence, ADR-005/007/011/012, agent specs, prompt directory, context/model routing, AI security, tool catalog.

## Scope

ModelProvider/AI SDK 7 OpenAI adapter and fake adapter; FAST/STANDARD/REASONING router; immutable prompt/agent import/publish baseline; context block builder/token budget/trust labels; orchestrator logical roles; structured validation/repair limit; tool registry/executor policy, confirmations, timeouts/audit; AI run telemetry/redaction/cost breaker/fallback; only safe internal placeholder/read tools until later gates.

## Files

`packages/ai/src/{gateway,providers,router,context,prompts,orchestrator}.ts`; policy/tool executor; worker summaries; Langfuse/OTel instrumentation adapters; eval harness baseline.

## Constraints

No model direct side effect or identity authority. Maximum bounded tool steps/turn (default 5, writes 1 pending confirmation). Invalid output cannot persist as valid state. Production requires published versions. Do not log raw sensitive context.

## Tests/Commands

Fake deterministic unit/integration; live optional contract smoke; prompt composition/trust ordering; context budget; route/fallback/circuit/cost; malformed schema; allowed/denied/confirm/replay tools; injection eval smoke; trace redaction. `test:contract test:evals test:security verify`.

## Acceptance Criteria

Authorization 100%; schema ≥99% eval and safe handling of rest; prompt/agent/model recorded per run; no raw secrets/private data in log snapshot; fallback preserves contract; budget breaker works.

## Completion Report

Distinguish fake versus live evidence and exact model config/cost; do not mark production model ready without live credential smoke.
