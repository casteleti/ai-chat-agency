#!/usr/bin/env node
import { readFile, readdir, stat } from 'node:fs/promises';
import path from 'node:path';
import process from 'node:process';

const root = path.resolve(path.dirname(new URL(import.meta.url).pathname), '..');
const required = [
  'README.md','PROJECT.md','ARCHITECTURE.md','CONTRIBUTING.md','SECURITY.md','ROADMAP.md',
  'CHANGELOG.md','AGENTS.md','CODEX.md','DEFINITION_OF_DONE.md','DECISIONS.md','.env.example',
  'docs/FILE_MANIFEST.md','docs/BLUEPRINT_TREE.md','docs/PRE_DEVELOPMENT_AUDIT.md','openapi/openapi.yaml',
  'packages/contracts/structured-output.schema.json','packages/contracts/generative-ui.schema.json',
  'packages/contracts/event-envelope.schema.json','docs/database/schema.sql','docs/database/erd.md',
  'docs/tools/tool-catalog.yaml','tests/fixtures/golden-conversation.schema.json',
  'tests/fixtures/golden-conversations.jsonl'
];
const gateHeadings = ['## Objective','## Read First','## Scope','## Files','## Constraints','## Tests/Commands','## Acceptance Criteria','## Completion Report'];
const failures = [];
const files = [];
const directories = new Set();

async function walk(dir) {
  directories.add(dir);
  for (const entry of await readdir(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) await walk(full);
    else if (entry.isFile()) files.push(full);
  }
}

await walk(root);

for (const rel of required) {
  const full = path.join(root, rel);
  try {
    if (!(await stat(full)).isFile()) failures.push(`Required path is not a file: ${rel}`);
  } catch { failures.push(`Missing required file: ${rel}`); }
}

for (const full of files) {
  const rel = path.relative(root, full);
  const content = await readFile(full, 'utf8');
  if (content.trim().length === 0) failures.push(`Empty file: ${rel}`);
  if (/^(<{7}|={7}|>{7})/m.test(content)) failures.push(`Merge marker: ${rel}`);
  if (/\b(TODO|TBD|FIXME)\b/.test(content) && !rel.includes('scripts/verify-blueprint')) failures.push(`Unresolved placeholder: ${rel}`);
  if (rel.endsWith('.json')) {
    try { JSON.parse(content); } catch (error) { failures.push(`Invalid JSON ${rel}: ${error.message}`); }
  }
  if (rel.endsWith('.jsonl')) {
    content.trim().split('\n').forEach((line, index) => {
      try { JSON.parse(line); } catch (error) { failures.push(`Invalid JSONL ${rel}:${index + 1}: ${error.message}`); }
    });
  }
  if (/docs\/codex\/G\d+-.+\.md$/.test(rel)) {
    for (const heading of gateHeadings) if (!content.includes(heading)) failures.push(`${rel} missing ${heading}`);
  }
}

const adrCount = files.filter((f) => /docs\/adr\/ADR-\d+/.test(path.relative(root, f))).length;
const gateCount = files.filter((f) => /docs\/codex\/G\d+-.+\.md$/.test(path.relative(root, f))).length;
if (adrCount !== 16) failures.push(`Expected 16 ADRs, found ${adrCount}`);
if (gateCount !== 18) failures.push(`Expected 18 gates, found ${gateCount}`);

const jsonl = await readFile(path.join(root, 'tests/fixtures/golden-conversations.jsonl'), 'utf8');
const goldenCount = jsonl.trim().split('\n').filter(Boolean).length;
if (goldenCount < 10) failures.push(`Expected at least 10 blueprint golden scenarios, found ${goldenCount}`);

console.log(`Blueprint root: ${root}`);
console.log(`Directories: ${directories.size}`);
console.log(`Files: ${files.length}`);
console.log(`ADRs: ${adrCount}`);
console.log(`Codex gates: ${gateCount}`);
console.log(`Golden scenarios: ${goldenCount}`);

if (failures.length) {
  console.error('\nVALIDATION FAILED');
  failures.forEach((failure) => console.error(`- ${failure}`));
  process.exit(1);
}
console.log('\nVALIDATION PASSED: no required file is missing or empty; JSON/JSONL and gate structure are valid.');
