# Runbook — Security/Privacy Incident

1. Declare severity, incident commander, security/privacy/legal contacts; use out-of-band channel.
2. Preserve logs/audit/images/config and timeline; restrict access; do not alter evidence unnecessarily.
3. Contain: disable flag/tool/integration, revoke sessions/tokens, isolate host, WAF rule or maintenance mode according to scope.
4. Determine data/actions/time/source; query audit with least exposure. Rotate affected secrets using rotation runbook.
5. Eradicate vulnerability, patch/test auth/tool boundaries, restore from known-good artifacts.
6. Recover in stages with canaries/monitoring; reconcile unauthorized external actions.
7. Counsel assesses ANPD/data-subject/customer/vendor notifications and deadlines; communications are factual.
8. Post-incident within 5 business days: root cause, control/test/runbook changes, owners/dates.

Any unauthorized cross-resource data access, auth bypass, secret exposure or unauthorized privileged tool execution is Critical until disproven.
