---
inclusion: manual
---

# Threat Modeling Guide

This steering file guides Threat Modeling phase creation. Produces a lightweight threat model informed by the AWS Security Maturity Model and the AWS Security Blog's four-step threat modeling process.

## When This Phase Runs

Between PRD (Phase 3) and Prototype (Phase 5). Mandatory for every project. In Full Approval mode, pauses for user approval before proceeding to Prototype.

## Input Required

Before creating the threat model, ensure you have:
- Completed PRD (`documents/PRD_[Product]_[Date].html` or `.kiro/specs/[product-slug]/requirements.md`)
- Technical stack identified (from PRD's technical architecture section)
- Personas identified (used as legitimate actors)

## Output

Single HTML deliverable:
- `documents/ThreatModel_[Product]_[Date].html`

Reference-only. Not consumed by the Prototype phase.

## Methodology

Follow the AWS Security Blog's four-step process:

### Step 1: System Snapshot

Extract from the PRD:
- **Assets** — data and systems attackers want (PII, app data, credentials, audit logs)
- **Actors** — legitimate (personas, admins, services) and threat (attackers, insiders, competitors)
- **Entry points** — screens, APIs, admin consoles, integrations, file uploads
- **Trust boundaries** — Internet→App, App→Data, User→Admin, App→Third-party

Render as four short tables plus an embedded diagram (SVG or Mermaid) showing data flow across trust boundaries.

### Step 2: Threat Identification (STRIDE)

Walk each STRIDE category against each entry point/asset:

| Category | Question |
|----------|----------|
| Spoofing | Impersonation possible? |
| Tampering | Unauthorized modification possible? |
| Repudiation | Harmful action without audit trail? |
| Information Disclosure | Unauthorized data read? |
| Denial of Service | Availability loss? |
| Elevation of Privilege | Capabilities beyond authorization? |

Output a threats table with columns: Threat ID, STRIDE, Description, Affected Asset/Entry Point, Attack Vector.

All 6 categories must appear (use "No significant X threats given scope" if truly absent).

### Step 3: Mitigations

Map each threat to an AWS-native mitigation. Default mappings:

| STRIDE | AWS Services |
|--------|--------------|
| Spoofing | Cognito, IAM Identity Center, WAF |
| Tampering | KMS, S3 Object Lock, DynamoDB streams |
| Repudiation | CloudTrail, CloudWatch Logs, AWS Config |
| Information Disclosure | KMS, IAM, VPC, Macie |
| Denial of Service | Shield, WAF, API Gateway throttling, Auto Scaling |
| Elevation of Privilege | IAM policies, Cognito groups, SCPs |

### Step 4: Risk Matrix

Score Likelihood × Impact (Low/Med/High), then residual likelihood × residual impact after mitigation. Any threat with residual High/High is flagged as an open item for architecture review.

Every threat evaluated against the CIA triad.

## Deliverable Sections

1. Document Header (title, product, date, version)
2. Scope & Assumptions
3. System Snapshot (four tables + diagram)
4. STRIDE Threat Table
5. Mitigations Table
6. Risk Matrix
7. Open Items (High/High residual risks)
8. References (two AWS URLs below)

## References

- AWS Security Maturity Model — Threat Modeling: https://maturitymodel.security.aws.dev/en/3.-efficient/threat-modeling/
- AWS Security Blog — How to approach threat modeling: https://aws.amazon.com/blogs/security/how-to-approach-threat-modeling/

## Quality Checklist

- [ ] System snapshot: ≥3 assets, ≥3 actors, ≥3 entry points, ≥1 trust boundary
- [ ] All 6 STRIDE categories represented in threats table
- [ ] Every threat has an AWS-mapped mitigation
- [ ] Risk matrix includes residual risk per threat
- [ ] Open items section lists High/High residual risks (or states "None")
- [ ] Diagram embedded
- [ ] Both AWS references linked
- [ ] No placeholder text
- [ ] File saved as `ThreatModel_[Product]_[Date].html`

## Out of Scope

- Compliance-specific modeling (HIPAA, PCI, SOC2) — architecture phase
- Pen testing or red-team scenarios
- Code-level vulnerability analysis (SAST/DAST)
- Prototype-phase security UI (this phase is reference-only)
