# G1 — Contracts and Configuration

## Objective

Make every external/AI/domain boundary executable and validated before persistence or orchestration.

## Read First

G0 evidence, API contract/OpenAPI, tool catalog, structured/event/UI schemas, error taxonomy, configuration/flags, ADR-012.

## Scope

Implement canonical Zod schemas and derived TS types for API payloads, events/jobs, AI outputs, tool specs, Generative UI, errors, provider context/results and IDs. Generate/check JSON Schema/OpenAPI. Implement typed config split by process, safe flags and canonical error mapper. Create contract fixture compatibility tests.

## Files

`packages/contracts/src/{api,events,ai,tools,ui,errors,providers,ids}.ts`, generators/exports; `packages/config/src/{schema,server,public,flags}.ts`; generated specs; contract tests/fixtures. Modify root commands for `openapi:check` and schema drift.

## Constraints

Zod is canonical; generated files are not hand-edited. Strict unknown-key rejection at boundaries. No database or business behavior. Browser config allowlist only. Error messages do not enumerate private resources.

## Tests/Commands

Schema valid/invalid/property tests, JSON/OpenAPI generation deterministic, previous-version fixture decoding, config fail-fast/redaction/public exposure, `pnpm test:contract openapi:check verify`.

## Acceptance Criteria

All blueprint contracts have executable schemas; spec drift fails CI; malformed/oversized/unknown fields reject; secrets cannot enter browser config or validation errors; event/UI versions explicit.

## Completion Report

List every implemented contract and generated artifact hash; stop before G2.
