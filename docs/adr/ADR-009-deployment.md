# ADR-009 — Hetzner Docker Behind Cloudflare

Status: Accepted — 2026-09-02

## Context

The owner wants predictable cost/control and already operates Docker/Hetzner-style infrastructure. The system needs long-lived SSE, API and workers, not only frontend hosting.

## Decision

Build OCI images in GitHub Actions, deploy with Docker Compose to Hetzner, expose only Caddy behind Cloudflare, isolate data networks, and store objects in R2. Use staging before production and immutable image digests.

## Alternatives

Vercel plus managed services; AWS; Kubernetes; one public VPS with all ports.

## Consequences

Cost control and portable containers; team owns patching, backups, monitoring and failover. Recommended production separates app and database nodes.

## Risks

Operational error/single host outage. Mitigate with IaC/config review, off-host backups, restore drills, hardening, health checks and scale topology.
