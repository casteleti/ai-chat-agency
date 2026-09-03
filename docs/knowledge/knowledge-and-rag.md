# Knowledge Base and RAG

## Taxonomy

Required metadata: `documentKey`, `version`, `type`, `locale`, `visibility`, `title`, `serviceIds`, `industries`, `audiences`, `tags`, `validFrom`, `validUntil`, `sourceType`, `sourceUri`, `owner`, `reviewer`, `contentHash`, `publishedAt`.

Types: `SERVICE`, `CASE_STUDY`, `FAQ`, `METHOD`, `POLICY`, `SUPPORT`, `ONBOARDING`, `TECHNOLOGY`, `PRICING_RULE`, `BRAND`, `TEAM`, `PROCESS`. Visibility: `PUBLIC`, `PROSPECT`, `CLIENT`, `PROJECT`, `STAFF`. Pricing is rules/approved records, never prose inference.

## Ingestion

1. Create immutable document version from reviewed draft/source object.
2. Verify type, checksum, malware status (for files), encoding, locale and metadata.
3. Parse only approved formats; preserve headings, lists, tables, source offsets and links.
4. Normalize whitespace/boilerplate without changing meaning; reject low-text/corrupt output.
5. Chunk semantically by heading/paragraph/list/table. Target 300–600 tokens, hard max 900, 10–15% contextual overlap only across coherent boundaries. Prefix with title/heading path for embedding but keep raw content.
6. Embed with configured model; build FTS; store model/config/content hashes.
7. Run completeness and retrieval smoke queries.
8. Atomically activate new index generation; retain prior until success.

## Retrieval

Normalize/query-expand from current intent and key entities. Execute lexical and cosine searches independently with strict locale fallback, visibility, service/industry and effective-date filters. Retrieve top 20 each, merge via Reciprocal Rank Fusion (`k=60`), deduplicate same document/near chunks, optionally rerank top 20, return max 8 chunks from max 5 documents. Diversity rule prevents one long document monopolizing context.

Permission filters are part of SQL and rechecked on hydrated documents. No post-hoc filtering of already exposed private content. Query timeout 800 ms target; degrade to lexical if embedding unavailable and mark trace.

## Response grounding

The context block includes stable citation ID, title, version, excerpt and source URI/reference; retrieved text is delimited untrusted data. The response maps factual agency claims to citations. Case, pricing, SLA and policy claims require exact canonical records. If no adequate evidence, abstain or give general non-agency guidance labeled as such.

## Quality and staleness

Expired/archived versions are excluded. Documents with review cadence generate warnings before expiry; critical policies fail closed after expiry. User feedback creates knowledge gaps linked to query/retrieved/result (redacted). Retrieval tester shows lexical/vector/RRF/rerank scores, filters and citations to authorized editors.

## Extraction threshold

Consider Qdrant or separate retrieval service only when active chunks exceed ~5 million, measured p95 retrieval breaches SLO after PostgreSQL tuning, retrieval load harms OLTP, or multi-vector capabilities are demonstrably required. Benchmark and ADR first.
