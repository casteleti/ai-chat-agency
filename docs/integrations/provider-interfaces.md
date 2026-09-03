# Provider and Channel Interfaces

Provider interfaces accept canonical IDs/models and an execution context containing tenant, actor, request/correlation and idempotency. They return canonical results plus provider reference/freshness, never raw SDK objects.

```ts
interface CRMProvider {
  findContact(q: ContactLookup, ctx: ProviderContext): Promise<ContactMatch[]>;
  upsertContact(input: ContactUpsert, ctx: WriteContext): Promise<ExternalMapping>;
  upsertCompany(input: CompanyUpsert, ctx: WriteContext): Promise<ExternalMapping>;
  createDeal(input: DealCreate, ctx: WriteContext): Promise<ExternalMapping>;
  updateDeal(input: DealUpdate, ctx: WriteContext): Promise<ExternalMapping>;
  createActivity(input: ActivityCreate, ctx: WriteContext): Promise<ExternalMapping>;
  addNote(input: NoteCreate, ctx: WriteContext): Promise<ExternalMapping>;
  health(): Promise<ProviderHealth>;
}

interface CalendarProvider {
  listMeetingTypes(ctx: ProviderContext): Promise<MeetingType[]>;
  getAvailability(q: AvailabilityQuery, ctx: ProviderContext): Promise<Slot[]>;
  schedule(input: BookingCreate, ctx: WriteContext): Promise<BookingResult>;
  cancel(input: BookingCancel, ctx: WriteContext): Promise<BookingResult>;
  health(): Promise<ProviderHealth>;
}

interface SupportProvider {
  createTicket(input: TicketCreate, ctx: WriteContext): Promise<ExternalMapping>;
  updateTicket(input: TicketUpdate, ctx: WriteContext): Promise<ExternalMapping>;
  getTicket(ref: ExternalRef, ctx: ProviderContext): Promise<TicketSnapshot>;
  addComment(input: TicketComment, ctx: WriteContext): Promise<ExternalMapping>;
}

interface ChannelAdapter {
  readonly channel: 'WEB'|'WHATSAPP'|'EMAIL'|'INSTAGRAM'|'PORTAL'|'SLACK';
  normalizeInbound(input: unknown, ctx: AdapterContext): Promise<InboundMessage>;
  send(output: OutboundMessage, ctx: WriteContext): Promise<DeliveryResult>;
  verifyWebhook(req: WebhookRequest): Promise<VerifiedWebhook>;
}
```

## Rules

- MVP adapters: fake/local CRM and calendar; one selected production CRM; one production calendar; internal support; web channel; email/internal notification.
- Webhooks enter a signed, timestamp-checked inbox with unique provider event ID and raw-body checksum; handlers are replay-safe.
- Time is stored UTC; availability queries/response include IANA timezone; slot tokens are server-signed/short-lived; daylight-saving edge tests are mandatory.
- Provider errors map to canonical retryability and error codes. Never surface vendor credentials/raw errors to users.
- OAuth/token secrets are encrypted at rest, scope-minimized, rotated and never sent to model context.
- Provider reconciliation compares internal/mapping/external state and requires audit for conflict resolution.
