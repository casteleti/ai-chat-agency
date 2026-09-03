# Runbook — Secrets Rotation

Inventory secret, owner, consumers, scope, environment, provider and revocation capability. Create least-privilege replacement; never print it to logs/chat/tickets. For application encryption/signing, deploy current+previous key support, write with new key, re-encrypt/reissue as needed, verify, then revoke old after session/grace window. For provider credentials, update secret store, restart/roll processes, health/read smoke, revoke old immediately after validation.

On compromise, disable affected integration/tool, revoke old first when risk demands, invalidate sessions/webhooks, search audit for use, rotate downstream secrets and follow incident runbook. Record secret metadata/fingerprint and dates, not value. Quarterly test rotation in staging.
