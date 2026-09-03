# G9 — Generative UI and Responsive Workspace

## Objective

Turn validated conversation artifacts into the distinctive, accessible, native-feeling workspace across desktop and mobile.

## Read First

G8 evidence, ADR-012, Generative UI schema/spec, chat/mobile/design/a11y/performance docs.

## Scope

Token bridge from agency site; Radix-based public workspace; exhaustive renderer and version fallback; text, quick actions, insight, briefing editor, opportunity map, service/case, website diagnostic, progress, CTA/handoff and meeting placeholder components; contextual rail emergence; streaming/offline/resume/error/expired; keyboard/screen-reader/reduced motion; analytics hooks; Storybook/visual states.

## Files

`packages/ui` tokens/primitives/components/registry; `apps/web` workspace route/overlay/store; UI contract adapters; stories/tests/a11y/visual E2E; bundle budgets.

## Constraints

No arbitrary HTML/code/style/URL/action. Server-issued action IDs only. One dominant card/turn; free text remains available. Mobile `100dvh`/visual viewport/safe area; no nested modals/carousels; launcher/workspace lazy.

## Tests/Commands

Every descriptor valid/invalid/unknown/old version; actions expired/denied; 320–1440 visual; iOS/Android keyboard/orientation/scroll; keyboard/focus/live regions/axe/200% zoom/reduced motion; streaming reconnect; bundle/Lighthouse. `test:unit test:e2e test:a11y build verify`.

## Acceptance Criteria

Axe critical/serious 0; full keyboard; supported breakpoints/mobile keyboard pass; unknown descriptor safe; no model code path; budgets met; artifacts correctable and transcript stable.

## Completion Report

Include screenshots/recordings artifact paths, viewport/browser matrix, axe and bundle sizes.
