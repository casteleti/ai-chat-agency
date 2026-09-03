import test from 'node:test';
import assert from 'node:assert/strict';
import { validateActionIdReferences } from './validate-generative-ui.mjs';

test('cta actionId present in root actionIds -> valid', () => {
  const descriptor = {
    schemaVersion: 1,
    id: 'card-cta',
    type: 'cta',
    data: { label: 'Book a call', actionId: '55555555-5555-5555-5555-555555555555' },
    actionIds: ['55555555-5555-5555-5555-555555555555'],
  };
  const result = validateActionIdReferences(descriptor);
  assert.equal(result.valid, true);
  assert.deepEqual(result.dangling, []);
});

test('cta actionId missing from root actionIds -> invalid (dangling reference)', () => {
  const descriptor = {
    schemaVersion: 1,
    id: 'card-cta',
    type: 'cta',
    data: { label: 'Book a call', actionId: '55555555-5555-5555-5555-555555555555' },
    actionIds: ['00000000-0000-0000-0000-000000000000'],
  };
  const result = validateActionIdReferences(descriptor);
  assert.equal(result.valid, false);
  assert.deepEqual(result.dangling, ['55555555-5555-5555-5555-555555555555']);
});

test('cta actionId with no root actionIds array at all -> invalid', () => {
  const descriptor = {
    schemaVersion: 1,
    id: 'card-cta',
    type: 'cta',
    data: { label: 'Book a call', actionId: '55555555-5555-5555-5555-555555555555' },
  };
  const result = validateActionIdReferences(descriptor);
  assert.equal(result.valid, false);
  assert.deepEqual(result.dangling, ['55555555-5555-5555-5555-555555555555']);
});

test('non-action component type (e.g. insight) has nothing to check -> valid', () => {
  const descriptor = {
    schemaVersion: 1,
    id: 'card-insight',
    type: 'insight',
    data: { title: 'T', summary: 'S', confidence: 0.5, preliminary: true },
  };
  const result = validateActionIdReferences(descriptor);
  assert.equal(result.valid, true);
  assert.deepEqual(result.dangling, []);
});
