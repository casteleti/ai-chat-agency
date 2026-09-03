# Runbook — CRM Outage

Confirm provider/auth/rate issue. Internal canonical contact/lead/opportunity remains authoritative; set mapping/sync `PENDING` or `FAILED_RETRYABLE`, persist outbox, show internal staff status. User may continue/meet; do not say CRM succeeded.

Pause dispatch on auth/permission errors and alert credential owner; use exponential retry for transport/429. After recovery, reconcile by internal idempotency/external lookup before create, drain bounded queue, inspect duplicates/conflicts, and attach activity/note once. Never manually bulk replay without dry-run and approval.
