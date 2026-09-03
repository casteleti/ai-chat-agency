# Data Classification and Retention

| Class | Examples | Default retention | Disposal |
|---|---|---|---|
| Public | published services/cases/FAQs | version lifetime + archive | archive/delete by owner |
| Internal | prompts/config/evals without user content | active + 24 months | purge versions per policy, retain audit hash |
| Confidential | identified lead conversation, brief, CRM data | 24 months after last meaningful activity or legal basis | delete/anonymize and propagate |
| Restricted | private client/project/ticket content, files, auth/security events | contract/legal schedule; auth logs 12 months; files purpose-based | cryptographic/object deletion, tombstone/audit |
| Anonymous telemetry | consented pseudonymous product events | 13 months | aggregate then delete identifiers |

Anonymous conversations default to 90 days; unconsented abandoned message content may be shortened to 30 days for abuse/security then deleted. Qualified business records may have a legitimate-interest/contract schedule documented per tenant. Never retain data “forever for AI training.” Product training/eval use requires separate de-identification and lawful-purpose approval.

Anonymous telemetry rows (`product_events`) run on their own 13-month clock, fully decoupled from the retention of any conversation they reference: `product_events.conversation_id` is intentionally nullable with no foreign key (`docs/database/schema.sql`), so a telemetry row is never blocked from disposal by a still-live parent conversation, and the reverse never applies either -- purging a conversation at 24 months never needs to touch or wait on its telemetry rows. At 13 months, "aggregate then delete identifiers" means nulling `user_id`, `conversation_id` and `anonymous_subject_hash` and stripping any PII from `properties`, in place, keeping only the aggregate-safe fields (`name`, `schema_version`, `occurred_at`, scrubbed `properties`); the row is not deleted outright unless the aggregate has no further analytics value. A conversation's own 24-month Confidential-class retention is unaffected by this and follows its own schedule independently.

Deletion workflow identifies subject, verifies requester, freezes conflicting processing, enumerates database/objects/analytics/observability/providers, deletes or irreversibly anonymizes, records minimal compliance proof, and completes within policy/legal deadline. Backups expire naturally; deleted subjects are suppressed from restore reactivation through tombstones until backup window passes.

Exports use a secure, expiring, authenticated package containing user-provided content, structured profile, consent and relevant actions—not internal security controls, other persons, secrets or hidden model reasoning.
