# Mobile, Design Tokens and Motion

## Mobile-first requirements

- Support 320 CSS px width; primary target 375–430 px.
- Full-screen workspace uses `100dvh` with fallbacks, `visualViewport` handling, `env(safe-area-inset-*)`, no fixed element hidden by iOS/Android keyboard.
- Sticky composer is inside the layout flow/visual viewport, padded for safe area; preserve draft and scroll anchor during keyboard resize/orientation.
- Touch targets minimum 44×44 CSS px (48 preferred), 8 px separation, no hover-only action.
- Cards use available width with 16 px page gutters; no horizontal scroll except intentionally accessible tables transformed to summaries.
- Bottom actions respect thumb reach; critical deny/cancel is not hidden in overflow.
- Avoid nested modals/drawers and full-screen card takeover. Use inline expansion or one bottom sheet with focus trap/restore.
- Overscroll is contained in transcript while browser navigation remains predictable; do not disable pinch zoom.
- Animations stay under 300 ms and avoid large parallax/filter effects on low-power devices.

## Design token contract

Tokens are CSS custom properties mapped from the main website, never hard-coded brand identity in components.

- Color: canvas/surface/elevated, text strong/muted/inverse, border, accent, success/warning/danger/info, focus, scrim; each has light/dark/contrast values.
- Typography: display, heading, body, label, mono families; fluid sizes, weights, line heights, tracking.
- Spacing: 0, 1, 2, 3, 4, 6, 8, 12, 16, 24 on a 4 px base.
- Radius: none/sm/md/lg/xl/pill; cards use one consistent family.
- Shadow/blur: subtle elevation levels; blur never carries essential separation.
- Motion: durations instant/fast/base/slow, easing enter/exit/emphasis, distance.
- Z-index: base, sticky, overlay, modal, toast; no arbitrary numbers.
- Container: chat readable, workspace, wide; breakpoints driven by layout need (sm 480, md 768, lg 1024, xl 1280).

Contrast: normal text 4.5:1, large 3:1, UI/focus 3:1. Focus ring is never color-only. Typography must survive user font scaling and 200% zoom.

## Motion specification

| Event | Motion | Budget |
|---|---|---|
| launcher→workspace | shared fade/scale + backdrop, focus after stable | 240 ms |
| contextual rail emerges | width/opacity without content jump | 220 ms |
| message arrival | 8 px translate + opacity | 160 ms |
| card | opacity/height after validation | 200 ms |
| progress step | color/icon state, no endless decorative loop | 150 ms |
| confirmation/meeting | restrained success transition and live announcement | 220 ms |
| handoff | status transition, no celebratory gimmick | 200 ms |

With `prefers-reduced-motion: reduce`, remove translation/scale/parallax and use instant or ≤80 ms opacity. Never animate streaming text per character, layout continuously, or auto-play audio.
