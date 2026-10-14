---
description: Run the full product-development workflow (Deep Research → PRFAQ → PRD → Prototype) for a product idea, with a per-phase approval gate.
argument-hint: [product idea, e.g. "a meal-planning app for busy parents"]
---

# Product Build

Run the complete product-development workflow for: **$ARGUMENTS**

Follow the Orchestrator and workflow guides bundled with this plugin — they are the single source of truth:

- Workflow + per-phase dispatch: `${CLAUDE_PLUGIN_ROOT}/prompts/Claude_Code_Workflow.md` and `${CLAUDE_PLUGIN_ROOT}/prompts/Orchestrator.md`
- Shared runtime baseline, syntax gate, file naming: `${CLAUDE_PLUGIN_ROOT}/prompts/Shared_Standards.md`
- Brand & logo rules: `${CLAUDE_PLUGIN_ROOT}/prompts/Brand_And_Logo_Rules.md`

## Phases

1. **Deep Market Research** — dispatch the `deep-research` subagent (6 dimensions, sourced, quality-gated). Output `documents/MarketResearch_[Product]_[YYYY-MM-DD].html`.
2. **AI Framing** *(AI/ML products only)* — dispatch `ai-framing`. Output `documents/AIFraming_[ProductSlug]_[YYYY-MM-DD].html`.
3. **PRFAQ** — dispatch `prfaq`. Output `documents/PRFAQ_[Product]_[YYYY-MM-DD].html`.
4. **PRD** — dispatch `prd` (includes internal Technology Research). Output `documents/PRD_[Product]_[YYYY-MM-DD].html` + `.kiro/specs/[product-slug]/requirements.md`.
5. **Prototype** — dispatch `design-system` once, then one `screen-builder` per screen in parallel. Rebuild the navigation hub with the `regenerate-screen-index` skill.

## Rules

- **Pause after each phase** for the user's review and approval before continuing (Full Approval mode). The user may say "switch to streamlined" to run continuously.
- All deliverables are self-contained HTML in `./documents/`; follow the naming convention `[Type]_[Product]_[YYYY-MM-DD].html`.
- Update `documents/ProjectDashboard_[Product]_[YYYY-MM-DD].html` after every phase (regenerate wholesale from its CONFIG — never str-replace structural HTML).
- Prefer AWS-native services in the PRD architecture; validate current-year availability with sources.
- Run the syntax gate on every `Screen_*.html` and the SVG check on the PRD diagram before declaring a phase done.

If no product idea was supplied in `$ARGUMENTS`, ask the user for it before starting.
