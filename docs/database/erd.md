# Entity Relationship Diagram

```mermaid
erDiagram
  VISITOR ||--o{ VISITOR_SESSION : uses
  VISITOR ||--o{ CONVERSATION : starts
  COMPANY ||--o{ CONTACT : employs
  COMPANY ||--o| CLIENT : becomes
  CLIENT ||--o{ PROJECT : has
  CONVERSATION ||--o{ MESSAGE : contains
  CONVERSATION ||--o{ CONVERSATION_STATE : versions
  CONVERSATION ||--o{ AGENT_RUN : triggers
  AGENT_RUN ||--o{ TOOL_CALL : proposes
  CONVERSATION ||--o| BRIEFING : builds
  BRIEFING ||--o{ BRIEFING_VERSION : versions
  CONVERSATION ||--o{ INSIGHT : produces
  CONVERSATION ||--o{ OPPORTUNITY_MAP : produces
  CONTACT ||--o{ LEAD : identifies
  COMPANY ||--o{ LEAD : groups
  LEAD ||--o{ QUALIFICATION : scores
  LEAD ||--o{ OPPORTUNITY : creates
  OPPORTUNITY ||--o{ MEETING_INTENT : offers
  MEETING_INTENT ||--o| MEETING : books
  CONVERSATION ||--o{ SUPPORT_REQUEST : raises
  SUPPORT_REQUEST ||--o| TICKET : creates
  CONVERSATION ||--o{ HANDOFF : escalates
  CONVERSATION ||--o{ ATTACHMENT : includes
  KNOWLEDGE_DOCUMENT ||--o{ KNOWLEDGE_VERSION : versions
  KNOWLEDGE_VERSION ||--o{ KNOWLEDGE_CHUNK : contains
  INTEGRATION ||--o{ EXTERNAL_MAPPING : maps
  CONVERSATION ||--o{ PRODUCT_EVENT : measures
```

The simplified ERD omits auth library tables, outbox receipts, consent links and several versioning relations for readability. `schema.sql` is authoritative for table-level design.
