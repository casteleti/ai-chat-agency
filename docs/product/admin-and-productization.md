# Admin Console and Productization

## V1-shaped MVP admin

Build only operational surfaces necessary to launch safely:

- Overview: starts, meaningful conversations, qualified, meetings, handoffs, errors, cost, queue health.
- Conversations: filters, transcript, structured state, citations, tool calls, versions, feedback, handoff.
- Commercial: leads, companies, opportunities, qualification, meeting/sync state.
- Support: requests, severity, assignment, handoff state.
- Knowledge: documents/versions, draft-review-publish-index status, retrieval tester.
- AI quality: prompt/agent versions read-only in MVP publishing, traces deep links, eval runs, failures/knowledge gaps.
- Integrations: health, last sync, dead letters, test connection; credentials never displayed.
- Audit/settings: flags, tenant configuration, retention, roles.

Do not build a drag-and-drop agent builder, arbitrary tool creator, white-label studio, billing, tenant provisioning or full CRM/helpdesk.

## Knowledge workflow

`DRAFT → IN_REVIEW → PUBLISHED → INDEXING → ACTIVE → ARCHIVED`. Publish creates an immutable document version and event; indexing is idempotent by version + embedding config hash. Prior active version remains active until new indexing and retrieval smoke test succeed. Rollback publishes/re-activates a new pointer/action; history is never mutated.

## Prompt and agent workflow

Every version has ID, semantic version, status (`DRAFT|IN_REVIEW|APPROVED|PUBLISHED|RETIRED`), author/reviewer, content/config hash, created/published timestamps, supported locales, model/task compatibility, eval run and rollback target. Production requests resolve a published immutable version and log it. A change never edits a published row.

## Productization classification

- `packages/domain-*`, contracts, orchestration, policy, knowledge, provider ports and UI schema are CORE_GENERIC.
- agency prompt/content/scoring/support routing under tenant config is AGENCY_SPECIFIC.
- vendor adapters are INTEGRATION_SPECIFIC.
- brand tokens, flags, retention, enabled tools, locales and routing are CLIENT_CONFIGURATION.

Tenant readiness means explicit tenant scope and configuration, not a SaaS control plane. Productization is eligible after the agency MVP proves repeatable value and at least three external clients share ≥80% of core behavior.
