# G3 — Identity, Consent and Authorization

## Objective

Support low-friction anonymous ownership and secure staff/client-ready identity with deny-by-default resource policy.

## Read First

G2 evidence, ADR-008/017, user journeys, auth/authorization matrix, threat model, LGPD.

## Scope

Signed HttpOnly anonymous session and visitor lifecycle; Better Auth staff foundation and magic-link/OTP adapter; membership resolution; consent records/withdrawal; RBAC+resource policy service; CSRF/origin/CORS/session rotation/revocation; privacy-safe identity challenge/link flow; rate limits; auth audit. Client private endpoints remain disabled until V1.

## Files

`packages/security/src/{sessions,authorization,csrf,rate-limit,redaction}.ts`; identity domain/repositories; Fastify auth/session plugins/routes; auth UI shells; integration/security tests.

## Constraints

Typed email alone never links prior data or confirms client existence. Uniform auth responses. Server owns authorization. Hash/minimize IP. No JWT as browser session substitute. Global flags cannot grant permission.

## Tests/Commands

Anonymous ownership/expiry/revocation, fixation/rotation, CSRF/CORS, enumeration, expired/replayed OTP, resource matrix, cache key isolation, consent grant/withdrawal, audit/redaction. Run integration/security/E2E auth and `verify`.

## Acceptance Criteria

Private resource access before auth is 0; session cookies secure in production config; consent purpose/version persisted; revoked/expired sessions fail; all decisions traceable by reason code.

## Completion Report

Include cookie/session settings, matrix coverage and security test counts; no real email credentials required for local fake adapter.
