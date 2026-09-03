-- CONCEPTUAL SCHEMA, not an executable migration. G2 translates this into
-- Drizzle schema and forward migrations, preserving names and invariants.
CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE tenants (
  id uuid PRIMARY KEY, slug text NOT NULL UNIQUE, name text NOT NULL,
  default_locale text NOT NULL CHECK (default_locale IN ('pt-BR','en-US')),
  status text NOT NULL CHECK (status IN ('ACTIVE','SUSPENDED')),
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL
);
CREATE TABLE tenant_settings (
  tenant_id uuid PRIMARY KEY REFERENCES tenants(id), version int NOT NULL DEFAULT 1,
  time_zone text NOT NULL, settings jsonb NOT NULL, updated_at timestamptz NOT NULL
);
CREATE TABLE feature_flags (
  tenant_id uuid NOT NULL REFERENCES tenants(id), key text NOT NULL, enabled boolean NOT NULL,
  config jsonb NOT NULL DEFAULT '{}', updated_by uuid, updated_at timestamptz NOT NULL,
  PRIMARY KEY (tenant_id,key)
);

CREATE TABLE visitors (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id),
  first_seen_at timestamptz NOT NULL, last_seen_at timestamptz NOT NULL,
  locale text, status text NOT NULL, anonymized_at timestamptz,
  UNIQUE (tenant_id,id)
);
CREATE TABLE visitor_sessions (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id),
  visitor_id uuid NOT NULL, token_hash text NOT NULL UNIQUE,
  started_at timestamptz NOT NULL, last_seen_at timestamptz NOT NULL,
  expires_at timestamptz NOT NULL, revoked_at timestamptz,
  ip_hash text, user_agent_family text,
  FOREIGN KEY (tenant_id,visitor_id) REFERENCES visitors(tenant_id,id)
);
CREATE TABLE users (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), email text NOT NULL,
  name text, email_verified_at timestamptz, status text NOT NULL,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (tenant_id,email), UNIQUE (tenant_id,id)
);
CREATE TABLE memberships (
  tenant_id uuid NOT NULL REFERENCES tenants(id), user_id uuid NOT NULL,
  role text NOT NULL CHECK (role IN ('CLIENT_USER','SALES','SUPPORT','KNOWLEDGE_EDITOR','ADMIN','OWNER')),
  client_id uuid, status text NOT NULL, created_at timestamptz NOT NULL,
  PRIMARY KEY (tenant_id,user_id,role), FOREIGN KEY (tenant_id,user_id) REFERENCES users(tenant_id,id)
);
CREATE TABLE consents (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id),
  visitor_id uuid, user_id uuid, purpose text NOT NULL, policy_version text NOT NULL,
  granted boolean NOT NULL, occurred_at timestamptz NOT NULL, withdrawn_at timestamptz,
  evidence jsonb NOT NULL, CHECK ((visitor_id IS NOT NULL) <> (user_id IS NOT NULL))
);

CREATE TABLE companies (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), name text NOT NULL,
  normalized_domain text, industry text, size_band text, country_code text,
  data jsonb NOT NULL DEFAULT '{}', version int NOT NULL DEFAULT 1,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE NULLS NOT DISTINCT (tenant_id,normalized_domain), UNIQUE (tenant_id,id)
);
CREATE TABLE contacts (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), company_id uuid,
  name text, email text, normalized_email text, phone_e164 text,
  verified_at timestamptz, communication_status text NOT NULL DEFAULT 'UNSPECIFIED',
  version int NOT NULL DEFAULT 1, created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE NULLS NOT DISTINCT (tenant_id,normalized_email), UNIQUE (tenant_id,id),
  FOREIGN KEY (tenant_id,company_id) REFERENCES companies(tenant_id,id)
);
CREATE TABLE clients (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), company_id uuid NOT NULL,
  status text NOT NULL, support_entitlement jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (tenant_id,company_id), UNIQUE (tenant_id,id),
  FOREIGN KEY (tenant_id,company_id) REFERENCES companies(tenant_id,id)
);

CREATE TABLE conversations (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), visitor_id uuid,
  channel text NOT NULL CHECK (channel IN ('WEB','WHATSAPP','EMAIL','INSTAGRAM','PORTAL','SLACK')),
  lifecycle text NOT NULL, journey_stage text NOT NULL, primary_intent text,
  locale text NOT NULL, consent_scope jsonb NOT NULL DEFAULT '{}',
  page_context jsonb NOT NULL DEFAULT '{}', version int NOT NULL DEFAULT 1,
  started_at timestamptz NOT NULL, last_message_at timestamptz, completed_at timestamptz,
  retention_until timestamptz NOT NULL, deleted_at timestamptz,
  UNIQUE (tenant_id,id), FOREIGN KEY (tenant_id,visitor_id) REFERENCES visitors(tenant_id,id)
);
CREATE TABLE conversation_participants (
  tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  participant_type text NOT NULL CHECK (participant_type IN ('VISITOR','CONTACT','USER','AGENT')),
  participant_id uuid NOT NULL, joined_at timestamptz NOT NULL, left_at timestamptz,
  PRIMARY KEY (tenant_id,conversation_id,participant_type,participant_id),
  FOREIGN KEY (tenant_id,conversation_id) REFERENCES conversations(tenant_id,id)
);
CREATE TABLE messages (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  role text NOT NULL CHECK (role IN ('USER','ASSISTANT','HUMAN','SYSTEM_EVENT')),
  content_text text, content_json jsonb, schema_version int NOT NULL DEFAULT 1,
  client_message_id uuid, reply_to_message_id uuid, status text NOT NULL,
  created_at timestamptz NOT NULL, completed_at timestamptz,
  UNIQUE (tenant_id,conversation_id,client_message_id), UNIQUE (tenant_id,id),
  FOREIGN KEY (tenant_id,conversation_id) REFERENCES conversations(tenant_id,id),
  FOREIGN KEY (tenant_id,reply_to_message_id) REFERENCES messages(tenant_id,id),
  CHECK (content_text IS NOT NULL OR content_json IS NOT NULL)
);
CREATE TABLE conversation_states (
  tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  version int NOT NULL, schema_version int NOT NULL, state jsonb NOT NULL,
  created_by_run_id uuid, created_at timestamptz NOT NULL,
  PRIMARY KEY (tenant_id,conversation_id,version),
  FOREIGN KEY (tenant_id,conversation_id) REFERENCES conversations(tenant_id,id)
);
CREATE TABLE conversation_summaries (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  through_message_id uuid NOT NULL, summary text NOT NULL, claims jsonb NOT NULL,
  prompt_version_id uuid NOT NULL, model_run_id uuid NOT NULL, created_at timestamptz NOT NULL,
  UNIQUE (tenant_id,conversation_id,through_message_id)
);
CREATE TABLE memory_claims (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), subject_type text NOT NULL,
  subject_id uuid NOT NULL, predicate text NOT NULL, value jsonb NOT NULL,
  status text NOT NULL CHECK (status IN ('OBSERVED','CONFIRMED','INFERRED','REJECTED')),
  confidence numeric(4,3) NOT NULL CHECK (confidence BETWEEN 0 AND 1),
  sensitivity text NOT NULL, source_type text NOT NULL, source_id uuid NOT NULL,
  first_seen_at timestamptz NOT NULL, last_seen_at timestamptz NOT NULL,
  expires_at timestamptz, superseded_by uuid REFERENCES memory_claims(id),
  UNIQUE (tenant_id,id)
);

CREATE TABLE prompt_versions (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), prompt_key text NOT NULL,
  version text NOT NULL, locale text, status text NOT NULL, content text NOT NULL, hash text NOT NULL,
  author_user_id uuid, reviewer_user_id uuid, created_at timestamptz NOT NULL,
  published_at timestamptz, retired_at timestamptz,
  UNIQUE (tenant_id,prompt_key,version), UNIQUE (tenant_id,prompt_key,hash), UNIQUE (tenant_id,id)
);
CREATE UNIQUE INDEX one_published_prompt ON prompt_versions(tenant_id,prompt_key,locale)
  WHERE status='PUBLISHED';
CREATE TABLE agent_versions (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), agent_key text NOT NULL,
  version text NOT NULL, status text NOT NULL, config jsonb NOT NULL, hash text NOT NULL,
  eval_run_id uuid, created_by uuid, created_at timestamptz NOT NULL, published_at timestamptz,
  UNIQUE (tenant_id,agent_key,version), UNIQUE (tenant_id,id)
);
CREATE UNIQUE INDEX one_published_agent ON agent_versions(tenant_id,agent_key) WHERE status='PUBLISHED';
CREATE TABLE agent_runs (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  trigger_message_id uuid NOT NULL, agent_version_id uuid NOT NULL, prompt_bundle_hash text NOT NULL,
  provider text NOT NULL, model text NOT NULL, model_config jsonb NOT NULL,
  status text NOT NULL, route_reason text NOT NULL, input_tokens bigint, output_tokens bigint,
  cost_usd numeric(12,6), time_to_first_token_ms int, latency_ms int,
  started_at timestamptz NOT NULL, completed_at timestamptz, error_code text,
  UNIQUE (tenant_id,id), FOREIGN KEY (tenant_id,conversation_id) REFERENCES conversations(tenant_id,id)
);
CREATE TABLE tool_calls (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), agent_run_id uuid NOT NULL,
  conversation_id uuid NOT NULL, tool_name text NOT NULL, tool_version int NOT NULL,
  input_redacted jsonb NOT NULL, input_hash text NOT NULL, permission text NOT NULL,
  risk text NOT NULL, confirmation_id uuid, status text NOT NULL,
  result_reference jsonb, error_code text, started_at timestamptz NOT NULL, completed_at timestamptz,
  UNIQUE (tenant_id,id), FOREIGN KEY (tenant_id,agent_run_id) REFERENCES agent_runs(tenant_id,id)
);
CREATE TABLE action_confirmations (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  tool_call_id uuid NOT NULL, actor_type text NOT NULL, actor_id uuid NOT NULL,
  status text NOT NULL CHECK (status IN ('PENDING','APPROVED','DENIED','EXPIRED','CONSUMED')),
  expires_at timestamptz NOT NULL, decided_at timestamptz,
  UNIQUE (tenant_id,tool_call_id), UNIQUE (tenant_id,id)
);

CREATE TABLE briefings (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  lead_id uuid, current_version int NOT NULL DEFAULT 1, created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL, UNIQUE (tenant_id,conversation_id), UNIQUE (tenant_id,id)
);
CREATE TABLE briefing_versions (
  tenant_id uuid NOT NULL REFERENCES tenants(id), briefing_id uuid NOT NULL, version int NOT NULL,
  schema_version int NOT NULL, fields jsonb NOT NULL, open_questions jsonb NOT NULL,
  source_run_id uuid, created_by_type text NOT NULL, created_by_id uuid NOT NULL,
  created_at timestamptz NOT NULL, PRIMARY KEY (tenant_id,briefing_id,version),
  FOREIGN KEY (tenant_id,briefing_id) REFERENCES briefings(tenant_id,id)
);
CREATE TABLE insights (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  kind text NOT NULL, title text NOT NULL, body text NOT NULL, evidence jsonb NOT NULL,
  confidence numeric(4,3) NOT NULL, preliminary boolean NOT NULL DEFAULT true,
  status text NOT NULL, created_at timestamptz NOT NULL, UNIQUE (tenant_id,id)
);
CREATE TABLE opportunity_maps (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  briefing_version int NOT NULL, version int NOT NULL, schema_version int NOT NULL,
  items jsonb NOT NULL, contradictions jsonb NOT NULL, preliminary boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL, UNIQUE (tenant_id,conversation_id,version), UNIQUE (tenant_id,id)
);
CREATE TABLE leads (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), contact_id uuid NOT NULL,
  company_id uuid, conversation_id uuid NOT NULL, status text NOT NULL,
  source jsonb NOT NULL, consent_id uuid NOT NULL, version int NOT NULL DEFAULT 1,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (tenant_id,conversation_id), UNIQUE (tenant_id,id),
  FOREIGN KEY (tenant_id,contact_id) REFERENCES contacts(tenant_id,id),
  FOREIGN KEY (tenant_id,company_id) REFERENCES companies(tenant_id,id)
);
ALTER TABLE briefings ADD CONSTRAINT briefings_lead_fk
  FOREIGN KEY (tenant_id,lead_id) REFERENCES leads(tenant_id,id);
CREATE TABLE qualification_snapshots (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), lead_id uuid,
  conversation_id uuid NOT NULL, algorithm_version text NOT NULL, input_hash text NOT NULL,
  dimensions jsonb NOT NULL, score numeric(5,2), coverage numeric(4,3) NOT NULL,
  confidence numeric(4,3) NOT NULL, band text NOT NULL, recommendation text NOT NULL,
  hard_disqualifier text, created_at timestamptz NOT NULL,
  UNIQUE (tenant_id,conversation_id,input_hash), UNIQUE (tenant_id,id)
);
CREATE TABLE opportunities (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), lead_id uuid NOT NULL,
  company_id uuid, qualification_id uuid, status text NOT NULL, title text NOT NULL,
  initiative_ids uuid[] NOT NULL DEFAULT '{}', version int NOT NULL DEFAULT 1,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (tenant_id,id), FOREIGN KEY (tenant_id,lead_id) REFERENCES leads(tenant_id,id)
);
CREATE TABLE meeting_intents (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  opportunity_id uuid, meeting_type_id uuid NOT NULL, time_zone text NOT NULL,
  status text NOT NULL, preferred_windows jsonb, expires_at timestamptz,
  created_at timestamptz NOT NULL, UNIQUE (tenant_id,id)
);
CREATE TABLE meetings (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), meeting_intent_id uuid NOT NULL,
  contact_id uuid NOT NULL, opportunity_id uuid, starts_at timestamptz NOT NULL,
  ends_at timestamptz NOT NULL, attendee_time_zone text NOT NULL, status text NOT NULL,
  provider text, external_id text, sync_status text NOT NULL, reference text NOT NULL,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (tenant_id,meeting_intent_id), UNIQUE (tenant_id,provider,external_id), UNIQUE (tenant_id,id)
);

CREATE TABLE projects (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), client_id uuid NOT NULL,
  name text NOT NULL, status text NOT NULL, data jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (tenant_id,id), FOREIGN KEY (tenant_id,client_id) REFERENCES clients(tenant_id,id)
);
CREATE TABLE support_requests (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  client_id uuid, project_id uuid, category text NOT NULL, severity text NOT NULL,
  severity_evidence jsonb NOT NULL, summary text NOT NULL, status text NOT NULL,
  contact_route text, consent_id uuid, reference text NOT NULL,
  first_response_due_at timestamptz, resolution_due_at timestamptz,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL, UNIQUE (tenant_id,id)
);
CREATE TABLE tickets (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), support_request_id uuid NOT NULL,
  assignee_user_id uuid, status text NOT NULL, severity text NOT NULL, version int NOT NULL DEFAULT 1,
  provider text, external_id text, sync_status text NOT NULL, created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL, resolved_at timestamptz,
  UNIQUE (tenant_id,support_request_id), UNIQUE (tenant_id,provider,external_id), UNIQUE (tenant_id,id)
);
CREATE TABLE handoffs (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid NOT NULL,
  lead_id uuid, support_request_id uuid, package_version int NOT NULL, package jsonb NOT NULL,
  requested_team text NOT NULL, urgency text NOT NULL, status text NOT NULL,
  assigned_user_id uuid, notification_status text NOT NULL, reference text NOT NULL,
  created_at timestamptz NOT NULL, accepted_at timestamptz, completed_at timestamptz,
  UNIQUE (tenant_id,id)
);

CREATE TABLE attachments (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid,
  owner_type text NOT NULL, owner_id uuid NOT NULL, object_key text NOT NULL,
  original_name text NOT NULL, declared_mime text NOT NULL, detected_mime text,
  size_bytes bigint NOT NULL, sha256 text NOT NULL, scan_status text NOT NULL,
  retention_until timestamptz NOT NULL, deleted_at timestamptz,
  created_at timestamptz NOT NULL, UNIQUE (tenant_id,object_key), UNIQUE (tenant_id,id)
);
CREATE TABLE knowledge_documents (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), document_key text NOT NULL,
  type text NOT NULL, title text NOT NULL, status text NOT NULL, current_active_version int,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (tenant_id,document_key), UNIQUE (tenant_id,id)
);
CREATE TABLE knowledge_document_versions (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), document_id uuid NOT NULL,
  version int NOT NULL, locale text NOT NULL, visibility text NOT NULL,
  source_type text NOT NULL, source_uri text, source_attachment_id uuid,
  content_hash text NOT NULL, metadata jsonb NOT NULL, valid_from timestamptz,
  valid_until timestamptz, status text NOT NULL, author_user_id uuid, reviewer_user_id uuid,
  created_at timestamptz NOT NULL, published_at timestamptz,
  UNIQUE (tenant_id,document_id,version), UNIQUE (tenant_id,id),
  FOREIGN KEY (tenant_id,document_id) REFERENCES knowledge_documents(tenant_id,id)
);
CREATE TABLE knowledge_chunks (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), document_version_id uuid NOT NULL,
  ordinal int NOT NULL, heading_path text[], content text NOT NULL, token_count int NOT NULL,
  metadata jsonb NOT NULL, search_vector tsvector GENERATED ALWAYS AS (to_tsvector('simple',content)) STORED,
  embedding vector(1536), embedding_model text, embedding_config_hash text,
  created_at timestamptz NOT NULL, UNIQUE (tenant_id,document_version_id,ordinal), UNIQUE (tenant_id,id)
);
CREATE INDEX knowledge_chunks_fts ON knowledge_chunks USING gin(search_vector);
CREATE INDEX knowledge_chunks_hnsw ON knowledge_chunks USING hnsw (embedding vector_cosine_ops)
  WHERE embedding IS NOT NULL;

CREATE TABLE integrations (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), type text NOT NULL,
  provider text NOT NULL, status text NOT NULL, encrypted_credentials bytea,
  config jsonb NOT NULL, last_health_at timestamptz, created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL, UNIQUE (tenant_id,type,provider), UNIQUE (tenant_id,id)
);
CREATE TABLE external_mappings (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), integration_id uuid NOT NULL,
  entity_type text NOT NULL, entity_id uuid NOT NULL, external_id text NOT NULL,
  external_version text, last_synced_at timestamptz, sync_status text NOT NULL,
  UNIQUE (tenant_id,integration_id,entity_type,entity_id),
  UNIQUE (tenant_id,integration_id,entity_type,external_id)
);
CREATE TABLE webhook_inbox (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), integration_id uuid NOT NULL,
  provider_event_id text NOT NULL, received_at timestamptz NOT NULL, signature_valid boolean NOT NULL,
  body_hash text NOT NULL, payload_encrypted bytea, status text NOT NULL, processed_at timestamptz,
  UNIQUE (tenant_id,integration_id,provider_event_id)
);
CREATE TABLE idempotency_keys (
  tenant_id uuid NOT NULL REFERENCES tenants(id), scope text NOT NULL, key text NOT NULL,
  request_hash text NOT NULL, status text NOT NULL, result_reference jsonb,
  created_at timestamptz NOT NULL, expires_at timestamptz NOT NULL,
  PRIMARY KEY (tenant_id,scope,key)
);
CREATE TABLE outbox_events (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), type text NOT NULL,
  schema_version int NOT NULL, aggregate_type text NOT NULL, aggregate_id uuid NOT NULL,
  occurred_at timestamptz NOT NULL, actor jsonb NOT NULL, request_id text NOT NULL,
  correlation_id text NOT NULL, causation_id uuid, payload jsonb NOT NULL, sensitivity text NOT NULL,
  published_at timestamptz, attempts int NOT NULL DEFAULT 0, last_error text,
  UNIQUE (tenant_id,id)
);
CREATE INDEX outbox_unpublished ON outbox_events(occurred_at) WHERE published_at IS NULL;
CREATE TABLE consumer_receipts (
  consumer text NOT NULL, event_id uuid NOT NULL, processed_at timestamptz NOT NULL,
  result_hash text, PRIMARY KEY (consumer,event_id)
);

CREATE TABLE product_events (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), name text NOT NULL,
  schema_version int NOT NULL, occurred_at timestamptz NOT NULL, anonymous_subject_hash text,
  user_id uuid, conversation_id uuid, properties jsonb NOT NULL, consent_scope text NOT NULL
);
CREATE TABLE feedback (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), conversation_id uuid,
  message_id uuid, rating smallint, reason_code text, comment text,
  created_at timestamptz NOT NULL, CHECK (rating IS NULL OR rating BETWEEN 1 AND 5)
);
CREATE TABLE evaluation_runs (
  id uuid PRIMARY KEY, tenant_id uuid REFERENCES tenants(id), suite text NOT NULL,
  dataset_version text NOT NULL, config_hash text NOT NULL, status text NOT NULL,
  metrics jsonb NOT NULL, baseline_run_id uuid, started_at timestamptz NOT NULL,
  completed_at timestamptz, artifact_uri text
);
CREATE TABLE audit_logs (
  id uuid PRIMARY KEY, tenant_id uuid NOT NULL REFERENCES tenants(id), occurred_at timestamptz NOT NULL,
  actor_type text NOT NULL, actor_id text NOT NULL, action text NOT NULL,
  resource_type text NOT NULL, resource_id text NOT NULL, request_id text NOT NULL,
  before_redacted jsonb, after_redacted jsonb, tool_call_id uuid, agent_run_id uuid,
  model text, ip_hash text, metadata jsonb NOT NULL
);
CREATE INDEX audit_resource_time ON audit_logs(tenant_id,resource_type,resource_id,occurred_at DESC);

-- Every high-volume tenant table additionally needs (tenant_id, created_at/id) indexes
-- matching repository access patterns. G2 uses EXPLAIN tests to finalize them.
