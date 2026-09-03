# Security Policy and Engineering Baseline

## Reporting

Do not open public issues for vulnerabilities. Report privately to the repository security contact configured by the owner. Include impact, affected version, reproduction, and suggested mitigation. Do not include real customer data or secrets.

## Trust model

Default deny. User messages, page context, fetched websites, uploads, RAG documents, provider payloads, webhook bodies, model output, and tool results are untrusted. Only version-controlled/published system policies and server-side authorization/configuration are trusted instructions.

## Mandatory controls

- TLS at edge and origin; HSTS after domain validation.
- HttpOnly Secure SameSite cookies; CSRF protection for cookie-authenticated mutations; session rotation and revocation.
- Resource authorization on every private query/action.
- Zod/JSON Schema validation, body/stream limits, parameterized queries, output encoding, CSP, and no unsafe HTML.
- Tool policy pipeline with permission, risk, confirmation, idempotency, timeout, audit, and least-privilege provider credentials.
- SSRF allow/deny resolution for website analysis; no private/link-local/loopback IPs or redirect escapes.
- Upload quarantine, MIME/magic-byte verification, checksum, malware scan, private objects, short signed URLs.
- Per-route/identity/IP rate limits and global AI concurrency/cost circuit breakers.
- Secrets in deployment secret store/environment injection; never repository, image, logs, traces, analytics, or client bundles.
- Dependency, container, secret, SAST, and IaC scans in CI.

## Severity and response

| Severity | Example | Initial response target |
|---|---|---|
| Critical | unauthorized private-data disclosure, auth bypass, secret compromise, arbitrary privileged tool execution | 30 min |
| High | stored XSS, SSRF to sensitive network, broad PII exposure | 4 h |
| Medium | limited CSRF, rate-limit bypass, low-scope data exposure | 2 business days |
| Low | hardening issue without practical exploit | 5 business days |

The security incident runbook governs containment, evidence, notification, rotation, remediation, and post-incident review. `docs/security/` contains the threat model, AI controls, LGPD, upload and rate policies.
