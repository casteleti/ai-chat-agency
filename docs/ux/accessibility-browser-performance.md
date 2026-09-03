# Accessibility, Browser Matrix and Web Performance

Target WCAG 2.2 AA.

## Acceptance checklist

- Semantic landmarks/headings; valid labels/descriptions/errors; no color-only meaning.
- Full keyboard access, visible focus, logical order, no traps, focus restore.
- Status/progress uses polite live regions; errors/critical confirmation announced once.
- Chat transcript has sensible reading order and authors; streaming does not flood assistive technology.
- Components survive 200% zoom, reflow at 320 px, text spacing overrides and screen orientation.
- Pointer targets ≥44 px; drag has alternatives; motion has reduced mode; timeouts warn/extend where user-controlled.
- Forms preserve values and associate field errors; auth does not rely on cognitive tests alone.
- Automated axe critical/serious violations 0 plus manual NVDA/Chrome, VoiceOver/Safari and keyboard review.

## Browser/device matrix

Full support: latest two stable Chrome, Edge, Firefox; latest two major Safari on macOS/iOS; Android Chrome current and previous. Minimum practical: iOS 17+, Android 10+. Test 320/375/390/768/1024/1440 px, touch and keyboard, portrait/landscape, slow 4G and 4× CPU slowdown. Older browsers receive readable site/static contact fallback; no broken blank workspace.

## Performance budgets

Public site p75 field targets: LCP ≤2.5 s, INP ≤200 ms, CLS ≤0.1, TTFB ≤800 ms. Initial route JS ≤170 KB gzip excluding lazy Concierge; launcher addition ≤20 KB gzip; workspace lazy chunk ≤180 KB gzip initial with components split. Initial images AVIF/WebP responsive and no chat asset blocks LCP.

Interaction targets: local UI feedback <100 ms; API message acknowledgment p95 <400 ms; stream first meaningful event p50 <1.0 s/p95 <2.0 s excluding provider outage; simple response perceived p95 <5 s; tool progress visible <500 ms after acceptance. RAG query p95 <800 ms at MVP corpus; non-AI API p95 <500 ms.

Use server rendering/site caching, lazy workspace, font subsets/self-hosting, route prefetch restraint, no heavy animation canvas, bounded analytics, virtualize transcript only after measured need while preserving accessibility. CI Lighthouse lab thresholds are regression signals; field Web Vitals are release truth.
