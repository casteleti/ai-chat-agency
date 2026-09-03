-- CONCEPTUAL SCHEMA, not an executable migration. G2 translates this into
-- Drizzle schema and forward migrations, preserving names and invariants.
-- Single-tenant by decision (ADR-017): no tenants/tenant_settings tables,
-- no tenant_id column anywhere. See ADR-017-single-tenant-confirmation.md.
CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE app_settings (
  id boolean PRIMARY KEY DEFAULT true CHECK (id), version int NOT NULL DEFAULT 1,
  time_zone text NOT NULL, settings jsonb NOT NULL, updated_at timestamptz NOT NULL
);
CREATE TABLE feature_flags (
  key text PRIMARY KEY, enabled boolean NOT NULL,
  config jsonb NOT NULL DEFAULT '{}', updated_by uuid, updated_at timestamptz NOT NULL
);

CREATE TABLE visitors (
  id uuid PRIMARY KEY,
  first_seen_at timestamptz NOT NULL, last_seen_at timestamptz NOT NULL,
  locale text, status text NOT NULL, anonymized_at timestamptz
);
CREATE TABLE visitor_sessions (
  id uuid PRIMARY KEY,
  visitor_id uuid NOT NULL, token_hash text NOT NULL UNIQUE,
  started_at timestamptz NOT NULL, last_seen_at timestamptz NOT NULL,
  expires_at timestamptz NOT NULL, revoked_at timestamptz,
  ip_hash text, user_agent_family text,
  FOREIGN KEY (visitor_id) REFERENCES visitors(id)
);
CREATE TABLE users (
  id uuid PRIMARY KEY, email text NOT NULL,
  name text, email_verified_at timestamptz, status text NOT NULL,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (email)
);
CREATE TABLE memberships (
  user_id uuid NOT NULL,
  role text NOT NULL CHECK (role IN ('CLIENT_USER','SALES','SUPPORT','KNOWLEDGE_EDITOR','ADMIN','OWNER')),
  client_id uuid, status text NOT NULL, created_at timestamptz NOT NULL,
  PRIMARY KEY (user_id,role), FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE consents (
  id uuid PRIMARY KEY,
  visitor_id uuid, user_id uuid, purpose text NOT NULL, policy_version text NOT NULL,
  granted boolean NOT NULL, occurred_at timestamptz NOT NULL, withdrawn_at timestamptz,
  evidence jsonb NOT NULL, CHECK ((visitor_id IS NOT NULL) <> (user_id IS NOT NULL))
);

CREATE TABLE companies (
  id uuid PRIMARY KEY, name text NOT NULL,
  normalized_domain text, industry text, size_band text, country_code text,
  data jsonb NOT NULL DEFAULT '{}', version int NOT NULL DEFAULT 1,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE NULLS NOT DISTINCT (normalized_domain)
);
CREATE TABLE contacts (
  id uuid PRIMARY KEY, company_id uuid,
  name text, email text, normalized_email text, phone_e164 text,
  verified_at timestamptz, communication_status text NOT NULL DEFAULT 'UNSPECIFIED',
  version int NOT NULL DEFAULT 1, created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE NULLS NOT DISTINCT (normalized_email),
  FOREIGN KEY (company_id) REFERENCES companies(id)
);
CREATE TABLE clients (
  id uuid PRIMARY KEY, company_id uuid NOT NULL,
  status text NOT NULL, support_entitlement jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (company_id),
  FOREIGN KEY (company_id) REFERENCES companies(id)
);

CREATE TABLE conversations (
  id uuid PRIMARY KEY, visitor_id uuid,
  channel text NOT NULL CHECK (channel IN ('WEB','WHATSAPP','EMAIL','INSTAGRAM','PORTAL','SLACK')),
  lifecycle text NOT NULL, journey_stage text NOT NULL, primary_intent text,
  locale text NOT NULL, consent_scope jsonb NOT NULL DEFAULT '{}',
  page_context jsonb NOT NULL DEFAULT '{}', version int NOT NULL DEFAULT 1,
  started_at timestamptz NOT NULL, last_message_at timestamptz, completed_at timestamptz,
  retention_until timestamptz NOT NULL, deleted_at timestamptz,
  FOREIGN KEY (visitor_id) REFERENCES visitors(id)
);
CREATE TABLE conversation_participants (
  conversation_id uuid NOT NULL,
  participant_type text NOT NULL CHECK (participant_type IN ('VISITOR','CONTACT','USER','AGENT')),
  participant_id uuid NOT NULL, joined_at timestamptz NOT NULL, left_at timestamptz,
  PRIMARY KEY (conversation_id,participant_type,participant_id),
  FOREIGN KEY (conversation_id) REFERENCES conversations(id)
);
CREATE TABLE messages (
  id uuid PRIMARY KEY, conversation_id uuid NOT NULL,
  role text NOT NULL CHECK (role IN ('USER','ASSISTANT','HUMAN','SYSTEM_EVENT')),
  content_text text, content_json jsonb, schema_version int NOT NULL DEFAULT 1,
  client_message_id uuid, reply_to_message_id uuid, status text NOT NULL,
  created_at timestamptz NOT NULL, completed_at timestamptz,
  UNIQUE (conversation_id,client_message_id),
  FOREIGN KEY (conversation_id) REFERENCES conversations(id),
  FOREIGN KEY (reply_to_message_id) REFERENCES messages(id),
  CHECK (content_text IS NOT NULL OR content_json IS NOT NULL)
);
CREATE TABLE conversation_states (
  conversation_id uuid NOT NULL,
  version int NOT NULL, schema_version int NOT NULL, state jsonb NOT NULL,
  created_by_run_id uuid, created_at timestamptz NOT NULL,
  PRIMARY KEY (conversation_id,version),
  FOREIGN KEY (conversation_id) REFERENCES conversations(id)
);
CREATE TABLE conversation_summaries (
  id uuid PRIMARY KEY, conversation_id uuid NOT NULL,
  through_message_id uuid NOT NULL, summary text NOT NULL, claims jsonb NOT NULL,
  prompt_version_id uuid NOT NULL, model_run_id uuid NOT NULL, created_at timestamptz NOT NULL,
  UNIQUE (conversation_id,through_message_id)
);
CREATE TABLE memory_claims (
  id uuid PRIMARY KEY, subject_type text NOT NULL,
  subject_id uuid NOT NULL, predicate text NOT NULL, value jsonb NOT NULL,
  status text NOT NULL CHECK (status IN ('OBSERVED','CONFIRMED','INFERRED','REJECTED')),
  confidence numeric(4,3) NOT NULL CHECK (confidence BETWEEN 0 AND 1),
  sensitivity text NOT NULL, source_type text NOT NULL, source_id uuid NOT NULL,
  first_seen_at timestamptz NOT NULL, last_seen_at timestamptz NOT NULL,
  expires_at timestamptz, superseded_by uuid REFERENCES memory_claims(id)
);

CREATE TABLE prompt_versions (
  id uuid PRIMARY KEY, prompt_key text NOT NULL,
  version text NOT NULL, locale text, status text NOT NULL, content text NOT NULL, hash text NOT NULL,
  author_user_id uuid, reviewer_user_id uuid, created_at timestamptz NOT NULL,
  published_at timestamptz, retired_at timestamptz,
  UNIQUE (prompt_key,version), UNIQUE (prompt_key,hash)
);
CREATE UNIQUE INDEX one_published_prompt ON prompt_versions(prompt_key,locale)
  WHERE status='PUBLISHED';
CREATE TABLE agent_versions (
  id uuid PRIMARY KEY, agent_key text NOT NULL,
  version text NOT NULL, status text NOT NULL, config jsonb NOT NULL, hash text NOT NULL,
  eval_run_id uuid, created_by uuid, created_at timestamptz NOT NULL, published_at timestamptz,
  UNIQUE (agent_key,version)
);
CREATE UNIQUE INDEX one_published_agent ON agent_versions(agent_key) WHERE status='PUBLISHED';
CREATE TABLE agent_runs (
  id uuid PRIMARY KEY, conversation_id uuid NOT NULL,
  trigger_message_id uuid NOT NULL, agent_version_id uuid NOT NULL, prompt_bundle_hash text NOT NULL,
  provider text NOT NULL, model text NOT NULL, model_config jsonb NOT NULL,
  status text NOT NULL, route_reason text NOT NULL, input_tokens bigint, output_tokens bigint,
  cost_usd numeric(12,6), time_to_first_token_ms int, latency_ms int,
  started_at timestamptz NOT NULL, completed_at timestamptz, error_code text,
  FOREIGN KEY (conversation_id) REFERENCES conversations(id)
);
CREATE TABLE tool_calls (
  id uuid PRIMARY KEY, agent_run_id uuid NOT NULL,
  conversation_id uuid NOT NULL, tool_name text NOT NULL, tool_version int NOT NULL,
  input_redacted jsonb NOT NULL, input_hash text NOT NULL, permission text NOT NULL,
  risk text NOT NULL, confirmation_id uuid, status text NOT NULL,
  result_reference jsonb, error_code text, started_at timestamptz NOT NULL, completed_at timestamptz,
  FOREIGN KEY (agent_run_id) REFERENCES agent_runs(id)
);
CREATE TABLE action_confirmations (
  id uuid PRIMARY KEY, conversation_id uuid NOT NULL,
  tool_call_id uuid NOT NULL, actor_type text NOT NULL, actor_id uuid NOT NULL,
  status text NOT NULL CHECK (status IN ('PENDING','APPROVED','DENIED','EXPIRED','CONSUMED')),
  expires_at timestamptz NOT NULL, decided_at timestamptz,
  UNIQUE (tool_call_id)
);

CREATE TABLE briefings (
  id uuid PRIMARY KEY, conversation_id uuid NOT NULL,
  lead_id uuid, current_version int NOT NULL DEFAULT 1, created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL, UNIQUE (conversation_id)
);
CREATE TABLE briefing_versions (
  briefing_id uuid NOT NULL, version int NOT NULL,
  schema_version int NOT NULL, fields jsonb NOT NULL, open_questions jsonb NOT NULL,
  source_run_id uuid, created_by_type text NOT NULL, created_by_id uuid NOT NULL,
  created_at timestamptz NOT NULL, PRIMARY KEY (briefing_id,version),
  FOREIGN KEY (briefing_id) REFERENCES briefings(id)
);
CREATE TABLE insights (
  id uuid PRIMARY KEY, conversation_id uuid NOT NULL,
  kind text NOT NULL, title text NOT NULL, body text NOT NULL, evidence jsonb NOT NULL,
  confidence numeric(4,3) NOT NULL, preliminary boolean NOT NULL DEFAULT true,
  status text NOT NULL, created_at timestamptz NOT NULL
);
CREATE TABLE opportunity_maps (
  id uuid PRIMARY KEY, conversation_id uuid NOT NULL,
  briefing_version int NOT NULL, version int NOT NULL, schema_version int NOT NULL,
  items jsonb NOT NULL, contradictions jsonb NOT NULL, preliminary boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL, UNIQUE (conversation_id,version)
);
CREATE TABLE leads (
  id uuid PRIMARY KEY, contact_id uuid NOT NULL,
  company_id uuid, conversation_id uuid NOT NULL, status text NOT NULL,
  source jsonb NOT NULL, consent_id uuid NOT NULL, version int NOT NULL DEFAULT 1,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (conversation_id),
  FOREIGN KEY (contact_id) REFERENCES contacts(id),
  FOREIGN KEY (company_id) REFERENCES companies(id)
);
ALTER TABLE briefings ADD CONSTRAINT briefings_lead_fk
  FOREIGN KEY (lead_id) REFERENCES leads(id);
CREATE TABLE qualification_snapshots (
  id uuid PRIMARY KEY, lead_id uuid,
  conversation_id uuid NOT NULL, algorithm_version text NOT NULL, input_hash text NOT NULL,
  dimensions jsonb NOT NULL, score numeric(5,2), coverage numeric(4,3) NOT NULL,
  confidence numeric(4,3) NOT NULL, band text NOT NULL, recommendation text NOT NULL,
  hard_disqualifier text, created_at timestamptz NOT NULL,
  UNIQUE (conversation_id,input_hash)
);
CREATE TABLE opportunities (
  id uuid PRIMARY KEY, lead_id uuid NOT NULL,
  company_id uuid, qualification_id uuid, status text NOT NULL, title text NOT NULL,
  initiative_ids uuid[] NOT NULL DEFAULT '{}', version int NOT NULL DEFAULT 1,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  FOREIGN KEY (lead_id) REFERENCES leads(id)
);
CREATE TABLE meeting_intents (
  id uuid PRIMARY KEY, conversation_id uuid NOT NULL,
  opportunity_id uuid, meeting_type_id uuid NOT NULL, time_zone text NOT NULL,
  status text NOT NULL, preferred_windows jsonb, expires_at timestamptz,
  created_at timestamptz NOT NULL
);
CREATE TABLE meetings (
  id uuid PRIMARY KEY, meeting_intent_id uuid NOT NULL,
  contact_id uuid NOT NULL, opportunity_id uuid, starts_at timestamptz NOT NULL,
  ends_at timestamptz NOT NULL, attendee_time_zone text NOT NULL, status text NOT NULL,
  provider text, external_id text, sync_status text NOT NULL, reference text NOT NULL,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (meeting_intent_id), UNIQUE (provider,external_id)
);

CREATE TABLE projects (
  id uuid PRIMARY KEY, client_id uuid NOT NULL,
  name text NOT NULL, status text NOT NULL, data jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(id)
);
CREATE TABLE support_requests (
  id uuid PRIMARY KEY, conversation_id uuid NOT NULL,
  client_id uuid, project_id uuid, category text NOT NULL, severity text NOT NULL,
  severity_evidence jsonb NOT NULL, summary text NOT NULL, status text NOT NULL,
  contact_route text, consent_id uuid, reference text NOT NULL,
  first_response_due_at timestamptz, resolution_due_at timestamptz,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL
);
CREATE TABLE tickets (
  id uuid PRIMARY KEY, support_request_id uuid NOT NULL,
  assignee_user_id uuid, status text NOT NULL, severity text NOT NULL, version int NOT NULL DEFAULT 1,
  provider text, external_id text, sync_status text NOT NULL, created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL, resolved_at timestamptz,
  UNIQUE (support_request_id), UNIQUE (provider,external_id)
);
CREATE TABLE handoffs (
  id uuid PRIMARY KEY, conversation_id uuid NOT NULL,
  lead_id uuid, support_request_id uuid, package_version int NOT NULL, package jsonb NOT NULL,
  requested_team text NOT NULL, urgency text NOT NULL, status text NOT NULL,
  assigned_user_id uuid, notification_status text NOT NULL, reference text NOT NULL,
  created_at timestamptz NOT NULL, accepted_at timestamptz, completed_at timestamptz
);

CREATE TABLE attachments (
  id uuid PRIMARY KEY, conversation_id uuid,
  owner_type text NOT NULL, owner_id uuid NOT NULL, object_key text NOT NULL,
  original_name text NOT NULL, declared_mime text NOT NULL, detected_mime text,
  size_bytes bigint NOT NULL, sha256 text NOT NULL, scan_status text NOT NULL,
  retention_until timestamptz NOT NULL, deleted_at timestamptz,
  created_at timestamptz NOT NULL, UNIQUE (object_key)
);
CREATE TABLE knowledge_documents (
  id uuid PRIMARY KEY, document_key text NOT NULL,
  type text NOT NULL, title text NOT NULL, status text NOT NULL, current_active_version int,
  created_at timestamptz NOT NULL, updated_at timestamptz NOT NULL,
  UNIQUE (document_key)
);
CREATE TABLE knowledge_document_versions (
  id uuid PRIMARY KEY, document_id uuid NOT NULL,
  version int NOT NULL, locale text NOT NULL, visibility text NOT NULL,
  source_type text NOT NULL, source_uri text, source_attachment_id uuid,
  content_hash text NOT NULL, metadata jsonb NOT NULL, valid_from timestamptz,
  valid_until timestamptz, status text NOT NULL, author_user_id uuid, reviewer_user_id uuid,
  created_at timestamptz NOT NULL, published_at timestamptz,
  UNIQUE (document_id,version),
  FOREIGN KEY (document_id) REFERENCES knowledge_documents(id)
);
CREATE TABLE knowledge_chunks (
  id uuid PRIMARY KEY, document_version_id uuid NOT NULL,
  ordinal int NOT NULL, heading_path text[], content text NOT NULL, token_count int NOT NULL,
  metadata jsonb NOT NULL, search_vector tsvector GENERATED ALWAYS AS (to_tsvector('simple',content)) STORED,
  embedding vector(1536), embedding_model text, embedding_config_hash text,
  created_at timestamptz NOT NULL, UNIQUE (document_version_id,ordinal)
);
CREATE INDEX knowledge_chunks_fts ON knowledge_chunks USING gin(search_vector);
CREATE INDEX knowledge_chunks_hnsw ON knowledge_chunks USING hnsw (embedding vector_cosine_ops)
  WHERE embedding IS NOT NULL;

CREATE TABLE integrations (
  id uuid PRIMARY KEY, type text NOT NULL,
  provider text NOT NULL, status text NOT NULL, encrypted_credentials bytea,
  config jsonb NOT NULL, last_health_at timestamptz, created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL, UNIQUE (type,provider)
);
CREATE TABLE external_mappings (
  id uuid PRIMARY KEY, integration_id uuid NOT NULL,
  entity_type text NOT NULL, entity_id uuid NOT NULL, external_id text NOT NULL,
  external_version text, last_synced_at timestamptz, sync_status text NOT NULL,
  UNIQUE (integration_id,entity_type,entity_id),
  UNIQUE (integration_id,entity_type,external_id)
);
CREATE TABLE webhook_inbox (
  id uuid PRIMARY KEY, integration_id uuid NOT NULL,
  provider_event_id text NOT NULL, received_at timestamptz NOT NULL, signature_valid boolean NOT NULL,
  body_hash text NOT NULL, payload_encrypted bytea, status text NOT NULL, processed_at timestamptz,
  UNIQUE (integration_id,provider_event_id)
);
CREATE TABLE idempotency_keys (
  scope text NOT NULL, key text NOT NULL,
  request_hash text NOT NULL, status text NOT NULL, result_reference jsonb,
  created_at timestamptz NOT NULL, expires_at timestamptz NOT NULL,
  PRIMARY KEY (scope,key)
);
CREATE TABLE outbox_events (
  id uuid PRIMARY KEY, type text NOT NULL,
  schema_version int NOT NULL, aggregate_type text NOT NULL, aggregate_id uuid NOT NULL,
  occurred_at timestamptz NOT NULL, actor jsonb NOT NULL, request_id text NOT NULL,
  correlation_id text NOT NULL, causation_id uuid, payload jsonb NOT NULL, sensitivity text NOT NULL,
  published_at timestamptz, attempts int NOT NULL DEFAULT 0, last_error text
);
CREATE INDEX outbox_unpublished ON outbox_events(occurred_at) WHERE published_at IS NULL;
CREATE TABLE consumer_receipts (
  consumer text NOT NULL, event_id uuid NOT NULL, processed_at timestamptz NOT NULL,
  result_hash text, PRIMARY KEY (consumer,event_id)
);

CREATE TABLE product_events (
  id uuid PRIMARY KEY, name text NOT NULL,
  schema_version int NOT NULL, occurred_at timestamptz NOT NULL, anonymous_subject_hash text,
  user_id uuid, conversation_id uuid, properties jsonb NOT NULL, consent_scope text NOT NULL
);
CREATE TABLE feedback (
  id uuid PRIMARY KEY, conversation_id uuid,
  message_id uuid, rating smallint, reason_code text, comment text,
  created_at timestamptz NOT NULL, CHECK (rating IS NULL OR rating BETWEEN 1 AND 5)
);
CREATE TABLE evaluation_runs (
  id uuid PRIMARY KEY, suite text NOT NULL,
  dataset_version text NOT NULL, config_hash text NOT NULL, status text NOT NULL,
  metrics jsonb NOT NULL, baseline_run_id uuid, started_at timestamptz NOT NULL,
  completed_at timestamptz, artifact_uri text
);
CREATE TABLE audit_logs (
  id uuid PRIMARY KEY, occurred_at timestamptz NOT NULL,
  actor_type text NOT NULL, actor_id text NOT NULL, action text NOT NULL,
  resource_type text NOT NULL, resource_id text NOT NULL, request_id text NOT NULL,
  before_redacted jsonb, after_redacted jsonb, tool_call_id uuid, agent_run_id uuid,
  model text, ip_hash text, metadata jsonb NOT NULL
);
CREATE INDEX audit_resource_time ON audit_logs(resource_type,resource_id,occurred_at DESC);

-- Every high-volume table additionally needs (created_at/id) indexes
-- matching repository access patterns. G2 uses EXPLAIN tests to finalize them.
