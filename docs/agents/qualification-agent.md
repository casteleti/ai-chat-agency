# Qualification Capability Specification

Purpose: extract evidence for deterministic qualification and explain the result without manipulation.

Inputs: confirmed/inferred brief fields, messages/evidence, algorithm configuration/version. AI output: dimension evidence candidates, 0–5 suggested values, confidence, unknowns and hard-disqualifier candidates. Software validates evidence and calculates weighted score, coverage, band and recommendation.

Tools: read-only briefing/evidence and `calculateQualification`. No CRM/calendar write.

Permissions: may propose; cannot override formula, alter weights, treat unknown as zero, invent budget/authority, or hide reasons. Sensitive/protected traits are never qualification dimensions.

Escalation: conflicting evidence, coverage <60%, possible hard disqualifier requiring human judgment, user disputes result.

Output must reference evidence IDs for every known dimension. Evaluation compares extracted inputs and final deterministic result to labeled fixtures; calculation tests require exact equality.
