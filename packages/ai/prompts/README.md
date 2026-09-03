# Prompt Composition and Versioning

Prompts are data, not scattered string literals. Runtime composition order:

1. `global-system.md` — immutable system purpose and trust hierarchy.
2. `security-policy.md` and `tool-policy.md` — non-overridable controls.
3. `brand-personality.md` — localized voice, subordinate to policy.
4. role prompt: `concierge.md`, `new-business.md` or `support.md`.
5. task/output contract — generated from canonical Zod schemas, not prose duplication.
6. trusted runtime context envelope.
7. delimited untrusted user/retrieval/tool data.

Each source file contains front matter with prompt ID, semantic version, locale, status, owner and required eval suite. G5 imports these as draft baseline records; production uses an immutable published database version/hash. Do not live-edit files on production. Do not put secrets, private content or provider-specific tool syntax in prompt prose.

Prompt changes require: new version, diff, eval comparison, cost/latency, reviewer, publish transaction and rollback target. Prompt caching may be used only where the provider does not change trust boundaries.
