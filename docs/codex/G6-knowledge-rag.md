# G6 — Knowledge Lifecycle and RAG

## Objective

Provide published, permission-filtered, hybrid retrieval with correct citations and safe ingestion.

## Read First

G5 evidence, ADR-006, knowledge/RAG spec, database knowledge tables, AI security, admin product boundary.

## Scope

Draft/review/publish/index/activate/archive domain; parser interfaces and safe Markdown/text baseline; semantic chunker; embedding adapter/config hash; FTS+pgvector searches, RRF, dedupe/diversity, optional reranker interface; SQL visibility/date filters; citation assembler; ingestion jobs/reindex/rollback; seed knowledge; CLI/admin retrieval tester API (UI later).

## Files

Knowledge domain/repositories/services, worker ingestion handlers, parser/embedding/retrieval packages, SQL/index migrations, fixtures/evals.

## Constraints

Only active indexed version serves. Prior stays active on failure. Retrieved text untrusted. No arbitrary remote ingestion. Private filters in SQL. `text-embedding-3-small` 1536 baseline; no mixed model vectors.

## Tests/Commands

Chunk boundaries/tables, publish authorization, failed index rollback, idempotent reindex, visibility/date leaks, lexical/vector/RRF, citation accuracy, injection/stale/conflict/zero-result, pt/en retrieval dataset, EXPLAIN/load. Run `test:integration test:evals test:security verify`.

## Acceptance Criteria

Recall@8 ≥0.90, citation precision/groundedness ≥0.95; 0 unauthorized chunks; source version/freshness visible; activation atomic; retrieval p95 budget met on baseline corpus.

## Completion Report

Include corpus/chunk counts, embedding config/hash/cost, retrieval metrics and query plans.
