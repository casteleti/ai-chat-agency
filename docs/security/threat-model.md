# Threat Model

## Assets and boundaries

Assets: identities/sessions, lead/client/project data, conversations/files, prompts/knowledge, provider credentials, tool authority, audit/eval data and availability/cost. Boundaries: browser→Cloudflare→origin; web/admin→API; API/worker→data; orchestrator→model; model→tool policy; ingestion/fetch/upload→knowledge; adapters→vendors.

| Threat | Control | Required test/evidence |
|---|---|---|
| direct/indirect prompt injection | trust-labeled context, policy outside model, no instruction from RAG/tool data | injection eval corpus, forbidden tool assertions |
| tool abuse/argument injection | allowlist, Zod, identity/resource policy, confirmation, idempotency | 100% authorization matrix/property tests |
| cross-tenant leak | required TenantContext, composite FK/index, selective RLS, cache key tenant | tenant-B integration/E2E canaries; 0 leaks |
| client impersonation/enumeration | uniform magic-link response, verified membership, short tokens, limits | auth enumeration/session fixation tests |
| XSS/HTML injection | React escaping, safe markdown subset, CSP, no arbitrary UI | stored/reflected DOM security tests |
| CSRF | SameSite cookies, Origin/Referer, CSRF token for mutations | cross-site request tests |
| SSRF/DNS rebinding | HTTPS only, resolve/revalidate each redirect, block private/link-local/metadata, size/time limits | redirect/DNS/IP test suite |
| SQL injection | parameterized Drizzle/SQL, validated filters/sorts | SAST and malicious query tests |
| malicious upload | quarantine, magic bytes, parser sandbox/limits, AV scan, private object | EICAR/polyglot/zip bomb tests |
| credential leakage | least privilege, encryption, redaction, no model/log/client access | secret scan, log snapshot, rotation drill |
| session theft | Secure HttpOnly, rotation/revocation, TTL, re-auth, CSP | replay/revocation tests |
| webhook replay/spoof | raw-body signature, timestamp window, unique event ID/inbox | signature/replay tests |
| rate/cost denial | edge+app buckets, Turnstile challenge, concurrency/budget breakers, body limits | k6/adversarial load |
| poisoned knowledge | review/publish, source ownership, hash/version, injection boundary | publication authorization and grounding eval |
| audit tampering | append-only permissions, off-host export/checksums, restricted access | DB role tests and integrity check |

## Abuse decisions

Moderation can assist but cannot be the sole security control. Harassment receives boundaries and human exit; credible security/privacy incidents route to SEV-1 without asking for exploit secrets in chat. Website analysis is a constrained public fetch, not a general browser or port scanner. AI never receives raw credentials or direct database/network tools.

Threat model is updated whenever a new tool, provider, channel, upload/parser, authentication method, private data class or autonomous action is added.
