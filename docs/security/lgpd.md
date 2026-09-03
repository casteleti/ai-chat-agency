# LGPD and Privacy Specification

This is an engineering privacy specification, not legal advice. The controller must have Brazilian counsel approve notices, legal bases, processors and retention before launch.

## Purposes and bases

- Necessary session/security: legitimate interest/contract steps as counsel confirms; minimal cookies, no marketing reuse.
- User-requested conversation and proposal/meeting: pre-contractual steps and legitimate interest; clear notice.
- Contact follow-up/marketing: purpose-specific consent or documented legitimate interest with opt-out; never inferred from chat use.
- Client support: contract performance and legitimate interest.
- Optional product analytics: consent where required; anonymous/aggregate first.
- AI quality/eval reuse: separate purpose assessment and de-identification; not default.

## Data minimization

Anonymous use remains possible. Ask business context before personal data. Budget is optional; never request special-category data. Redact credentials/payment/sensitive personal data from models and traces. Page/UTM capture is allowlisted; no keystroke/session replay.

## Rights

Provide accessible privacy/contact route for confirmation/access, correction, portability/export, deletion/anonymization, processing information, consent withdrawal and review of consequential automated processing. Qualification is advisory, explained and does not deny a legal right/service; users may request human review. Who may request vs. execute deletion/anonymization is defined by the `D` verb in `docs/security/authorization-matrix.md`: data subjects and Support may only request it; execution is Admin/Owner only, privacy-process-gated and audited. Response deadline: 15 business days from a verified request (`docs/database/data-retention.md`) -- reference value, requires counsel confirmation before production.

## Processors/transfers

Maintain a subprocessor register for hosting, Cloudflare, R2, AI providers, auth/email, CRM/calendar, observability and analytics: purpose, data class, region/transfer mechanism, retention, training setting, DPA and deletion capability. Disable provider training on customer content where controls exist; use enterprise/API data terms rather than consumer chat products.

## Consent/cookies

Store policy version, purpose, granted/withdrawn, timestamp and evidence. Necessary cookies are separate from analytics/marketing. No prechecked consent or service denial for optional processing. Withdrawal stops future processing and propagates flags/providers.

## Incident and lifecycle

Privacy incident runbook identifies scope, affected subjects/processors, containment and legally assessed ANPD/subject notification. Retention/deletion/export details are in `docs/database/data-retention.md`. Production release requires Record of Processing Activities, privacy notice, cookie inventory, DPA/subprocessor review and named data owner.
