# Codex Execution Manual

## Objective

Implement the complete AI Business Concierge exactly from the repository specifications, gate by gate, while preserving architecture, security, evidence, and traceability.

## Method

1. Read the required documents in the gate's `Read First` section.
2. Inspect the current repository and working tree; preserve unrelated changes.
3. Restate the gate objective, dependencies, and acceptance checks internally before editing.
4. Implement only the gate scope. If a prerequisite is absent, stop and report it.
5. Add or update contracts before implementations that depend on them.
6. Implement vertical slices where the gate permits, behind a disabled flag until complete.
7. Run focused tests after each coherent change; fix failures before continuing.
8. Run every command named by the gate and `pnpm verify` at the end.
9. Update docs, manifest, migrations, seeds, decisions, and changelog when behavior changes.
10. Produce the exact completion report and stop at the gate boundary.

Do not ask permission for ordinary in-scope implementation choices already locked by the blueprint. Do stop for a scope contradiction, missing business credential/configuration, destructive production operation, security boundary change, or architecture change requiring an ADR.

## Canonical command surface

After G0, only these root commands are assumed: `pnpm dev`, `build`, `lint`, `format:check`, `typecheck`, `test`, `test:unit`, `test:integration`, `test:contract`, `test:e2e`, `test:evals`, `test:security`, `test:a11y`, `test:load`, `db:generate`, `db:migrate`, `db:seed`, `db:check`, `openapi:check`, and `verify`. A gate may define a narrower command. If a needed command is missing, add it in the appropriate foundation gate and document it.

## Gate protocol

- A gate starts only when all dependencies are `COMPLETE` with evidence.
- `COMPLETE_LOCAL` is allowed only where the gate explicitly awaits external credentials; it does not authorize the dependent production gate.
- Failed acceptance criterion means `BLOCKED` or `INCOMPLETE`, never a qualified pass.
- Store machine-readable gate evidence under `artifacts/gates/Gxx/` in CI; do not commit secrets or bulky recordings.
- Update `docs/codex/STATUS.md` with status, commit, date, evidence links, and known risk.

## Completion report

```text
STATUS: COMPLETE | COMPLETE_LOCAL | INCOMPLETE | BLOCKED

FILES CREATED
- path — purpose

FILES MODIFIED
- path — change

MIGRATIONS
- id — forward behavior — rollback/compatibility note

TESTS
- suite/case — what it proves

COMMANDS RUN
- exact command

TEST RESULTS
- exact passed/failed/skipped counts and duration

ACCEPTANCE CHECKLIST
- [x] criterion with evidence
- [ ] unmet criterion and reason

OPEN RISKS
- risk — impact — owner/next action

BLOCKERS
- blocker — required decision/access

NEXT GATE READINESS
- READY/NOT READY — dependencies and recommended next action
```

Vague summaries such as “everything looks good” are invalid. Report skipped checks, degraded providers, fake adapters, unverified migrations, and absent production evidence explicitly.

## First action

Run `node scripts/verify-blueprint.mjs`, read the required order in `README.md`, then execute `docs/codex/G0-repository-foundation.md`.
