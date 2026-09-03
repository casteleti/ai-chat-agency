# ADR-005 — AI Provider Strategy

Status: Accepted — 2026-09-02

## Context

The system needs streaming, structured output, tools, reasoning tiers, vision later, cost control, and reproducibility without locking domain logic to one SDK.

## Decision

Use AI SDK 7 as the application abstraction and OpenAI Responses API as primary. Route FAST/STANDARD/REASONING to approved GPT-5.6 tiers. Define a narrow `ModelProvider`; alternative adapters are enabled only after contract/eval parity. Record provider/model/config/prompt/agent versions.

## Alternatives

Direct OpenAI SDK everywhere; Anthropic primary; custom gateway; self-hosted models.

## Consequences

Rapid access to current capabilities with portability at the boundary. Fallback is task-specific and never automatic without eval approval.

## Risks

Provider semantics and structured behavior differ. Mitigate with canonical schemas, adapter tests, golden evals, pinned configs and honest degradation.
