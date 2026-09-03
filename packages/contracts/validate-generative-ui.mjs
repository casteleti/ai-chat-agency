// Reference implementation of the one invariant that generative-ui.schema.json (JSON Schema
// Draft 2020-12) cannot express: every actionId referenced inside a component's `data` must also
// appear in the descriptor's root-level `actionIds` array. Standard JSON Schema has no portable way
// to validate a nested field's value against a sibling array (no cross-field/"$data" support in the
// draft this contract targets), so this check must run as a second pass after schema validation.
//
// Usage: validate the descriptor against generative-ui.schema.json with a standard validator first
// (ajv, Zod, etc.); call validateActionIdReferences(descriptor) after that passes. G9's "UI contract
// adapters" (docs/codex/G9-generative-ui-workspace.md) ports this to the real Zod/TypeScript renderer.

// Dot-paths, relative to the descriptor root, of every field in each component's `data` shape that
// carries an action ID. Extend this map when a new type gains an action-bound field.
const ACTION_ID_PATHS = {
  cta: ['data.actionId'],
};

function readPath(obj, dotPath) {
  return dotPath.split('.').reduce((node, key) => (node == null ? undefined : node[key]), obj);
}

export function findReferencedActionIds(descriptor) {
  const paths = ACTION_ID_PATHS[descriptor?.type] ?? [];
  return paths
    .map((path) => readPath(descriptor, path))
    .filter((value) => typeof value === 'string');
}

export function validateActionIdReferences(descriptor) {
  const rootActionIds = new Set(descriptor?.actionIds ?? []);
  const referenced = findReferencedActionIds(descriptor);
  const dangling = referenced.filter((id) => !rootActionIds.has(id));
  return { valid: dangling.length === 0, dangling };
}
