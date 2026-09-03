# Gate Completion Report Template

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
- [x] criterion — evidence
- [ ] unmet criterion — reason

OPEN RISKS
- risk — impact — owner/next action

BLOCKERS
- blocker — required decision/access

NEXT GATE READINESS
- READY/NOT READY — dependencies and next action
```

Attach machine evidence under CI artifacts; never commit secrets, personal production data, large traces or browser recordings to the repository. Update `STATUS.md` only when the report supports the status.
