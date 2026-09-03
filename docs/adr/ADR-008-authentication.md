# ADR-008 — Anonymous Sessions and Better Auth

Status: Accepted — 2026-09-02

## Context

Public prospects need low-friction anonymous chat; staff and V1 clients need secure sessions, magic link/OTP and organization membership.

## Decision

Use an HttpOnly signed cookie referencing a server-side anonymous visitor session. Use Better Auth for identified users with short magic links/OTP, secure session cookies, rotation/revocation, and tenant memberships. Anonymous identity never grants private client access.

## Alternatives

Auth.js, Clerk, Supabase Auth, JWT-only, mandatory login.

## Consequences

Self-hosted TypeScript control and progressive identity. Auth schema/plugin changes require migration tests.

## Risks

Account enumeration, session theft and mistaken visitor/client linkage. Mitigate with uniform responses, rate limits, secure cookies, verified email, explicit linking transaction, audit and re-auth for sensitive actions.
