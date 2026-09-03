# Runbook — Database Restore

Declare incident/owner; isolate target; preserve evidence; choose recovery point from base backup + WAL and verify checksums/encryption access. Never restore over production in place.

1. Provision isolated database matching engine/extensions.
2. Restore base backup and replay WAL to target time; record achieved RPO.
3. Run integrity: migration ledger, tenant/table counts, FK/constraint checks, newest critical records, outbox/job consistency, vector/FTS indexes.
4. Reconcile R2 object metadata/checksums and deletion tombstones.
5. Point a quarantined app version to restored DB; run read-only smoke and security/tenant canaries.
6. Decide controlled cutover with DNS/connections/write freeze; rotate credentials if compromise suspected.
7. Resume workers cautiously; dedupe/reconcile external writes before dispatch.
8. Verify SLOs and record RTO/data loss; post-incident review.

Monthly drills stop before production cutover and store evidence. Never reintroduce data previously deleted under privacy requests.
