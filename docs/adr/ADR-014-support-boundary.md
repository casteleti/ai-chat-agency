# ADR-014 — Support MVP Boundary

Status: Accepted — 2026-09-02

## Context

The long-term product includes client support, but private account/project/ticket access requires authentication, data integrations, stronger authorization, uploads and SLA operations. Building it alongside the commercial differentiator risks delay and weak security.

## Decision

MVP support detects intent, provides public grounded answers, collects safe issue context, deterministically classifies severity, creates an internal support request and hands off. Authenticated private support, files, projects and tickets are V1.

## Alternatives

Full support in MVP; omit support entirely; redirect to WhatsApp.

## Consequences

The website serves clients responsibly without claiming unavailable private capability. The architecture and schemas preserve V1 paths.

## Risks

Users may expect account answers. Mitigate with clear capability messaging, quick handoff and no authentication theatre before private support exists.
