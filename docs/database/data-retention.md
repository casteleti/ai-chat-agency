# Data Classification and Retention

| Class | Examples | Default retention | Disposal |
|---|---|---|---|
| Public | published services/cases/FAQs | version lifetime + archive | archive/delete by owner |
| Internal | prompts/config/evals without user content | active + 24 months | purge versions per policy, retain audit hash |
| Confidential | identified lead conversation, brief, CRM data | 24 months after last meaningful activity or legal basis | delete/anonymize and propagate |
| Restricted | private client/project/ticket content, files, auth/security events | contract/legal schedule; auth logs 12 months; files purpose-based | cryptographic/object deletion, tombstone/audit |
| Anonymous telemetry | consented pseudonymous product events | 13 months | aggregate then delete identifiers |

Anonymous conversations default to 90 days; unconsented abandoned message content may be shortened to 30 days for abuse/security then deleted. Qualified business records may have a legitimate-interest/contract schedule documented in policy. Never retain data “forever for AI training.” Product training/eval use requires separate de-identification and lawful-purpose approval.

Deletion workflow identifies subject, verifies requester, freezes conflicting processing, enumerates database/objects/analytics/observability/providers, deletes or irreversibly anonymizes, records minimal compliance proof, and completes within policy/legal deadline. Backups expire naturally; deleted subjects are suppressed from restore reactivation through tombstones until backup window passes.

Exports use a secure, expiring, authenticated package containing user-provided content, structured profile, consent and relevant actions—not internal security controls, other persons, secrets or hidden model reasoning.
