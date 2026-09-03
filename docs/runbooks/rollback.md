# Runbook — Rollback

Prefer disabling the affected feature flag. If code rollback is required, confirm prior images support current expanded schema, deploy exact prior digests API/worker then web/admin as compatibility dictates, and run smoke/metrics. Do not reverse an applied destructive migration; use forward repair or restore only under database incident decision.

Stop workers before rollback when job payload compatibility is uncertain; keep consumers capable of current/prior job versions during rolling releases. Record reason, versions, flags, migration state, user impact and follow-up issue. Re-enable only after root cause and full gate checks.
