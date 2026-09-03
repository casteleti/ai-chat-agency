# ADR-002 — Next.js and React Frontend

Status: Accepted — 2026-09-02

## Context

The experience must integrate with a high-performance agency site, stream conversation, support app-like transitions, SEO, responsive Generative UI, and a separate admin surface.

## Decision

Use Next.js 16.3.3 Active LTS, React 19.2 patched, TypeScript, Tailwind 4.3, Radix UI, Motion, and AI SDK UI. Use App Router and server components for site/read shells; client components only for interactive conversation. Lazy-load the Concierge workspace.

## Alternatives

Remix, SPA/Vite, Web Components widget, hosted chat SDK.

## Consequences

Strong rendering/streaming ecosystem and shared web/admin skills. Framework security patches become urgent. The application must avoid Vercel-only runtime features and can self-host its Node output.

## Risks

Bundle creep and RSC security issues. Mitigate with budgets, patch automation, CSP, dependency scanning, minimal client boundaries, and Playwright/Web Vitals gates.
