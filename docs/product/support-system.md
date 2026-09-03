# Support System

## MVP boundary

MVP supports public answers, safe issue collection, deterministic triage, internal request creation and human handoff. It cannot authenticate clients or retrieve private projects, billing, campaigns, files, tickets, credentials or account status. V1 adds those only after G3-style resource authorization is extended and tested.

## Categories

`PROJECT`, `WEBSITE`, `MEDIA`, `AI`, `AUTOMATION`, `SEO`, `CONTENT`, `DESIGN`, `HOSTING`, `BILLING`, `ACCOUNT`, `GENERAL`, `SECURITY_PRIVACY`.

## Severity rules

| Severity | Deterministic triggers | Initial response target |
|---|---|---|
| SEV-1 Critical | production site/system unavailable for most users; active severe financial spend risk; confirmed security/data incident; irreversible deadline-critical outage | acknowledge 15 min, route immediately 24/7 only if contract says so |
| SEV-2 High | major feature unavailable, campaign/automation materially wrong, deadline within 1 business day, many users affected, no workaround | 1 business hour |
| SEV-3 Normal | limited defect/request with workaround, ordinary project/account question | 1 business day |
| SEV-4 Low | cosmetic, idea, informational, no operational impact | 2 business days |

AI extracts impact, scope, onset, workaround, deadline and financial/security signals. Code applies rules; any hard signal takes the maximum severity. AI cannot downgrade. Staff override requires reason and audit. SLA calendars/timezones are tenant-configured; do not promise 24/7 unless configured.

## Resolution boundary

AI may answer only from currently published knowledge visible to the actor and may suggest reversible troubleshooting that does not request secrets or destructive actions. It cannot change DNS, campaigns, billing, credentials, deployments or project status. Uncertain, private, high-severity, angry/relationship-sensitive, security/privacy, repeated-failure and human-request cases escalate.

## Routing

Category maps to a team; SEV-1 additionally pages the configured incident destination; client/account owner is considered only after V1 authorization. If no assignee/provider, persist to fallback queue and alert admin. Handoff message gives reference, severity as preliminary when evidence incomplete, response expectation from configured SLA, and emergency alternative if available.

## Ticket lifecycle

`NEW → TRIAGED → ASSIGNED → IN_PROGRESS → WAITING_CLIENT | WAITING_INTERNAL → RESOLVED → CLOSED`, with `REOPENED`. Every transition is permissioned/audited; SLA pause rules are explicit. Internal canonical ticket exists before provider sync.
