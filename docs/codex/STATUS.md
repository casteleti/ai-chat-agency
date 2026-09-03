# Gate Status

| Gate | Status | Commit | Evidence | Notes |
|---|---|---|---|---|
| G0 Repository foundation | READY | — | Blueprint verified | First action |
| G1 Contracts/config | BLOCKED_BY_G0 | — | — | — |
| G2 Database/outbox | BLOCKED_BY_G1 | — | — | — |
| G3 Identity/consent/policy | BLOCKED_BY_G2 | — | — | — |
| G4 Conversation/streaming | BLOCKED_BY_G3 | — | — | — |
| G5 AI orchestration | BLOCKED_BY_G4 | — | — | — |
| G6 Knowledge/RAG | BLOCKED_BY_G5 | — | — | — |
| G7 Discovery/briefing | BLOCKED_BY_G6 | — | — | — |
| G8 Qualification/next action | BLOCKED_BY_G7 | — | — | — |
| G9 Generative UI | BLOCKED_BY_G8 | — | — | — |
| G10 CRM | BLOCKED_BY_G8 | — | — | May parallel G11/G12 |
| G11 Calendar | BLOCKED_BY_G8 | — | — | May parallel G10/G12 |
| G12 Support | BLOCKED_BY_G6 | — | — | May parallel G10/G11 |
| G13 Handoff | BLOCKED_BY_G10_G12 | — | — | — |
| G14 Admin/quality | BLOCKED_BY_G6_G13 | — | — | — |
| G15 Analytics/observability/evals | BLOCKED_BY_G14 | — | — | — |
| G16 Hardening | BLOCKED_BY_G15 | — | — | — |
| G17 Production release | BLOCKED_BY_G16 | — | — | — |

Codex updates this table only with the report evidence required by `CODEX.md`. `READY` means prerequisites exist, not that the gate is complete.
