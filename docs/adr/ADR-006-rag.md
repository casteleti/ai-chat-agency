# ADR-006 — PostgreSQL Hybrid RAG

Status: Accepted — 2026-09-02

## Context

Agency knowledge is curated, permissioned and expected to remain far below millions of active chunks initially. Retrieval must combine terminology and semantics with visibility/date filters.

## Decision

Parse and version documents; create semantic chunks; index `tsvector` and pgvector cosine HNSW; combine lexical/vector ranks through RRF; optionally rerank top candidates; enforce filters before final context; always return source citations.

## Alternatives

Hosted file search; Qdrant/Pinecone; vector-only search; knowledge graph.

## Consequences

One transactional data platform and precise filtering. The team owns ingestion and retrieval quality.

## Risks

Weak chunking/stale content can harm answers. Mitigate with publication lifecycle, retrieval evals, stale-date rules, index hashes, admin tester and knowledge-gap feedback.
