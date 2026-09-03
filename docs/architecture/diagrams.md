# Architecture Diagrams

## Deployment

```mermaid
flowchart TB
  NET[Internet] --> CF["Cloudflare DNS / CDN / WAF"]
  CF --> FW["Hetzner firewall"]
  FW --> RP["Caddy origin proxy"]
  RP --> WEB["Web container"]
  RP --> ADMIN["Admin container"]
  RP --> API["API containers"]
  API --> PG[("PostgreSQL 18.6")]
  API --> REDIS[("Redis 8.2")]
  WORKER["Worker containers"] --> PG
  API --> R2["Cloudflare R2"]
  API --> AI["AI providers"]
  WORKER --> AI
  API --> OBS["OTel / Langfuse"]
```

## AI request lifecycle

```mermaid
sequenceDiagram
  participant U as User
  participant A as API
  participant O as Orchestrator
  participant M as Model
  participant T as Tool policy
  U->>A: Message + idempotency key
  A->>O: Identity, tenant, state
  O->>O: Build authorized context
  O->>M: Versioned prompt + tools
  M-->>O: Text / structured proposal
  O->>T: Validate proposed action
  T-->>O: Deny, confirm, or execute result
  O-->>A: Persisted SSE events
  A-->>U: Progress, text, approved UI
```

## Agent orchestration

```mermaid
flowchart TB
  IN["Message + current state"] --> ROUTE["Intent / role routing"]
  ROUTE --> ORCH["Single orchestrator"]
  ORCH --> CTX["Context engine"]
  ORCH --> RAG["Knowledge retrieval"]
  ORCH --> MODEL["Model gateway"]
  MODEL --> POL["Policy engine"]
  POL --> TOOLS["Deterministic tools"]
```

## New business journey

```mermaid
stateDiagram-v2
  [*] --> Entry
  Entry --> Discovery
  Discovery --> Context
  Context --> Diagnosis
  Diagnosis --> Briefing
  Briefing --> Qualification
  Qualification --> Recommendation
  Recommendation --> NextAction
  NextAction --> Meeting
  NextAction --> Handoff
  Context --> Discovery: correction
  Qualification --> Diagnosis: new evidence
  Meeting --> [*]
  Handoff --> [*]
```

## Support journey

```mermaid
flowchart TB
  Q["Support message"] --> C["Classify + triage"]
  C --> P{"Public answer?"}
  P -- Yes --> K["Grounded knowledge answer"]
  P -- No --> A{"Authenticated and authorized?"}
  A -- No --> COL["Collect safe context"]
  A -- Yes --> R["V1 private resolution"]
  K --> DONE["Resolved or continue"]
  COL --> T["Support request"]
  R --> T
  T --> H["Human handoff"]
```

## Human handoff

```mermaid
flowchart LR
  AI["Conversation"] --> SUM["Structured summary"]
  SUM --> PACK["Handoff package"]
  PACK --> AUD["Audit + persistence"]
  AUD --> ROUTE["Team / severity route"]
  ROUTE --> HUMAN["Human takeover"]
```

## Knowledge / RAG

```mermaid
flowchart LR
  DOC[Document] --> PARSE["Parse + normalize"]
  PARSE --> CHUNK["Semantic chunks"]
  CHUNK --> IDX["Embedding + FTS"]
  Q[Query] --> HYB["Vector + lexical"]
  IDX --> HYB
  HYB --> FILTER["Tenant / visibility / date"]
  FILTER --> RERANK[Rerank]
  RERANK --> CITE["Context + citations"]
```

## CRM and calendar adapters

```mermaid
flowchart TB
  DOMAIN["Canonical domain"] --> PORTS["Provider ports"]
  PORTS --> CRM["CRM adapter"]
  PORTS --> CAL["Calendar adapter"]
  CRM --> MAP1["External ID mappings"]
  CAL --> MAP2["Booking mappings"]
  CRM --> RETRY["Outbox / retry"]
  CAL --> RETRY
```

## Data flow

```mermaid
flowchart TB
  MSG[Message] --> NORM[Normalize]
  NORM --> DB[(Persist)]
  DB --> CTX["Authorized context"]
  CTX --> MODEL[Model]
  MODEL --> TEXT[Text]
  MODEL --> DATA["Structured patch"]
  MODEL --> ACTION["Tool proposal"]
  DATA --> VALIDATE[Validate]
  ACTION --> POLICY[Authorize]
  VALIDATE --> DB
  POLICY --> DB
  TEXT --> DB
```

## Conversation state

```mermaid
stateDiagram-v2
  [*] --> Active
  Active --> AwaitingUser
  AwaitingUser --> Active
  Active --> AwaitingConfirmation
  AwaitingConfirmation --> Active: approve or deny
  Active --> HumanPending
  HumanPending --> HumanActive
  Active --> Completed
  AwaitingUser --> Abandoned
  Abandoned --> Active: resume
  HumanActive --> Completed
```

The business journey stage is separate from the conversation lifecycle state; changing intent does not corrupt message/run lifecycle.
