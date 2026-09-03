# Generative UI Contract

The model never produces code. It produces a descriptor validated by `packages/contracts/generative-ui.schema.json`; the server resolves record/action IDs and the client registry renders an approved component.

## Registered components

| Type | Purpose | Sensitive/action notes |
|---|---|---|
| text | prose with citations | markdown subset, no raw HTML |
| quick_actions/question_group | low-friction user choice | always free-text alternative |
| insight | evidence-linked preliminary insight | confidence and preliminary label |
| briefing | progressive correctable fields | optimistic version; corrections audited |
| opportunity_map | up to five problem→opportunity items | evidence and confidence; no final strategy claim |
| service/case_study | approved canonical record | ID/citation required; no generated case |
| website_diagnostic | bounded URL observations | limitations and fetch timestamp |
| meeting_picker/confirmation | server-issued slots/result | action IDs/token expiry; no model-created slot |
| support_ticket | status/reference | private content only after authorization |
| file_request | V1 upload intent | accepted types/size/purpose/consent shown |
| progress | truthful operation steps | no fake percentage or fake completed step |
| timeline/metric | authorized structured data | source/freshness/definition required |
| human_handoff | handoff state/reference | SLA only from config |
| cta | eligible next action | server-issued action ID |

## Renderer rules

- Exhaustive discriminated switch; unknown/version-new descriptor falls back to safe text and telemetry.
- No arbitrary icon name, class, CSS, URL, HTML, event handler or component import from model data.
- Record cards resolve public/read models by ID; model text cannot override canonical title/price/result.
- Actions use opaque, signed, expiring server IDs bound to conversation/actor/operation and confirmation policy.
- Maximum one dominant card and two supporting cards per turn; mobile cards are full available width and never nested carousels.
- Every component includes loading, empty, error, expired, offline/resume, keyboard, screen-reader and reduced-motion states.
- Analytics use schema-defined keys and exclude free text/PII.

## Versioning

Descriptors are persisted with schema version and immutable message. Renderer supports the current and prior major during rolling deploy. Migration transforms old descriptors on read without mutating message history. New component type requires schema, Zod type, renderer, Storybook states, unit/a11y tests, E2E, analytics definition and security review if actionable.
