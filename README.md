# Product Team's Tool Chest

A comprehensive toolkit that transforms AI coding assistants into your personal product development partner. Go from idea to interactive prototype with specialized support for AI/ML products.

## Overview

This toolkit provides **steering files for [Kiro](https://kiro.dev)** that guide an AI assistant through a complete product development workflow:

> **What is Kiro?** Kiro is an AI-powered IDE that uses "steering files" to guide AI behavior with project-specific instructions. Steering files are markdown documents in `.kiro/steering/` that provide context, workflows, and constraints. When you work in Kiro, these files automatically shape how the AI assistant responds - no manual prompting required.

```
Discovery → Deep Market Research → PRFAQ → PRD → Prototype
```

Each phase produces professional deliverables as styled HTML documents that can be viewed in a browser and shared with stakeholders.

## Install (use the skills anywhere)

Want the toolchest skills in **every project on your machine** instead of copying files per-project? There are three install paths — see **[INSTALL.md](INSTALL.md)** for the full guide:

1. **One-command global install** — installs the skills into each agent's global config dir (Kiro, Claude Code, Codex, Cursor) so they work in every project:
   ```bash
   ./install.sh            # detects your agents; --dry-run / --uninstall supported
   ```
2. **Claude Code plugin + marketplace** — official plugin with managed updates:
   ```
   /plugin marketplace add aws-samples/sample-kiro-cli-prompts-for-product-teams
   /plugin install product-toolchest@aws-samples-product-toolchest
   ```
3. **Per-project copy** — the original mode (Quick Start below), for evaluating or pinning a project to a version.

The global install and the plugin both ship **self-contained** skills (the guides travel with them, resolved against the agent's config dir or `${CLAUDE_PLUGIN_ROOT}`), so they work with zero project files. See `plugins/product-toolchest/` for the plugin.

## Quick Start (Kiro)

1. **Copy steering files** to your project:
   ```bash
   cp -r .kiro/steering/* your-project/.kiro/steering/
   cp .kiro/hooks.json your-project/.kiro/
   ```

2. **Open your project in Kiro** and describe your product idea

3. **The workflow runs automatically:**
   - Market research with web search
   - PRFAQ (Press Release / FAQ) using Working Backwards methodology
   - PRD with detailed requirements
   - Interactive HTML prototype with modular screens

All outputs are **standalone HTML files** that open directly in any browser - no build step or server required. Share them with stakeholders by simply sending the files.

## Workflow Phases

### Phase 1: Deep Market Research
- 6 parallel research dimensions (Industry, Competitive, Customer, Technology, Adjacent Innovation, Policy/Risk/Opportunity)
- 120+ sources minimum with quality gates
- Market sizing (TAM/SAM/SOM with sources)
- Customer pain points research
- Technology radar mapped to AWS services
- Customer brand research (logo, colors) if applicable

**Output:** `MarketResearch_[Product]_[Date].html`

### Phase 1b: AI Framing (Optional)
Only for AI/ML products. Defines:
- ML problem type (classification, regression, etc.)
- Input/output schemas
- Success metrics and thresholds
- Training data requirements

### Phase 2: PRFAQ
Amazon-style Working Backwards documentation:
- Press Release (as if product already launched)
- FAQ addressing customer and business questions
- Incorporates market research findings

**Output:** `PRFAQ_[Product]_[Date].html`

### Phase 3: PRD (Requirements)
Implementation-ready specification:
- User personas with detailed profiles
- Requirements in EARS syntax (When/The/Shall format)
- User stories with acceptance criteria
- Current-year technology research (validated against latest AWS services)
- Inline SVG architecture diagrams
- Success metrics and business model
- Challenge Check stress-tests PRFAQ assumptions before writing

**Output:** `PRD_[Product]_[Date].html` + `.kiro/specs/[product]/requirements.md`

### Phase 4: Prototype
Interactive HTML prototype with:
- **Modular file structure** (not monolithic)
- Distinctive visual design (no generic "AI slop")
- Chart.js data visualizations (downloaded to `documents/lib/` at build time, referenced locally — never a CDN script)
- Dependency-load guard + global error banner on every screen (failures surface visibly instead of a blank page)
- Realistic interaction patterns (state persists via localStorage, no toast-only responses)
- Working navigation between screens
- Form validation with visible state changes
- Responsive layouts (desktop, tablet, mobile)
- Syntax gate + adversarial Bug Hunt pass (parses every inline `<script>`; assumes bugs exist, finds and fixes them)
- Realistic data (no Lorem ipsum)

**Output:**
```
documents/
├── lib/chart.min.js                      (Chart.js — downloaded at build time, gitignored, not committed)
├── [product-slug].css                    (shared design tokens)
├── DesignSystem_[Product]_[Date].html    (visual reference)
├── ScreenIndex_[Product]_[Date].html     (navigation hub)
├── Screen_Dashboard_[Product]_[Date].html
├── Screen_[Name]_[Product]_[Date].html   (one per screen)
└── ProjectDashboard_[Product]_[Date].html  (live status — regenerated after every phase)
```

## File Structure

```
CLAUDE.md                       (auto-loads in Claude Code)
.cursorrules                    (auto-loads in Cursor)

.kiro/                          (Kiro mode)
├── steering/
│   ├── product-workflow.md     (main orchestration - always loaded)
│   ├── design-standards.md     (visual standards - always loaded)
│   ├── market-research.md      (deep research guide - manual)
│   ├── prfaq-guide.md          (PRFAQ guide - manual)
│   ├── prd-guide.md            (PRD guide + tech research - manual)
│   ├── prototype-spec-guide.md (interaction spec - manual)
│   ├── prototype-guide.md      (prototype guide - manual)
│   ├── specialist-*.md         (per-phase specialists - fileMatch, auto-injected when editing the matching output)
│   └── templates/              (ScreenIndex + ProjectDashboard templates)
└── hooks.json                  (17 agent hooks: validators, phase transitions, analysis lenses)

prompts/                        (Claude Code / Cursor workflow — single source of truth for both modes)
├── Claude_Code_Workflow.md     (main workflow guide)
├── Orchestrator.md             (coordination + per-phase agent dispatch)
├── Shared_Standards.md         (runtime baseline, syntax gate, file naming, budgets)
├── Deep_Research_Agent.md      (6 parallel dimensions, quality gates)
├── AI_Framing_Agent.md         (AI/ML products only)
├── PRFAQ_Guide.md
├── PRD_Creation_Guide.md       (includes Technology Research)
├── Prototype_Spec_Guide.md     (interaction blueprint)
├── Prototype_Creation_Guide.md
├── Handoff_Schema.md           (inter-phase payload contract)
└── ProjectDashboard_Template.html / ScreenIndex_Template.html

.claude/                        (native Claude Code layer — thin shims over prompts/)
├── agents/                     (7 subagents: deep-research, ai-framing, prfaq, prd, design-system, screen-builder, product-reviewer)
├── skills/                     (5 phase skills: product-research/ai-framing/prfaq/prd/prototype + regenerate-screen-index utility)
└── settings.json               (advisory PostToolUse validation hooks — cross-platform, never blocks)

documents/                      (auto-generated outputs — gitignored)
├── lib/chart.min.js            (downloaded at build time, not committed)
├── MarketResearch_*.html       (Deep Research output)
├── PRFAQ_*.html
├── PRD_*.html
├── PrototypeSpec_*.html        (Interaction Spec — internal sub-step artifact)
├── DesignSystem_*.html
├── Screen_*.html
└── ProjectDashboard_*.html     (live status, regenerated after every phase)

samples/                        (example outputs for reference)
├── DesignSystem_TeenFit.html
├── PRFAQ_TeenFit.html
├── PRD_TeenFit.html
└── Screen_*.html
```

## Steering Files

| File | Inclusion | Purpose |
|------|-----------|---------|
| `product-workflow.md` | always | Main workflow orchestration (incl. runtime baseline, syntax gate, dashboard protocol) |
| `design-standards.md` | always | Visual design standards |
| `market-research.md` | manual | Web-based research guide |
| `prfaq-guide.md` | manual | PRFAQ creation guide |
| `prd-guide.md` | manual | PRD and Kiro spec guide |
| `prototype-spec-guide.md` | manual | Interaction blueprint guide |
| `prototype-guide.md` | manual | Prototype creation guide |
| `specialist-*.md` | fileMatch | Per-phase specialist prompts, auto-injected when editing the matching output (e.g. `specialist-prototype.md` activates on `Screen_*.html`) |

## Agent Hooks

> These hooks are **Kiro mode only**. Claude Code's automated gating is narrower — `.claude/settings.json` runs an advisory JS-syntax gate on `Screen_*.html` and an SVG paint check on `PRD_*.html`; everything else below is enforced by the agent via the prose guides rather than a save-triggered hook. See *Native Claude Code primitives*.

`.kiro/hooks.json` defines **17 hooks** in three groups:

**Automatic validators (trigger on file save):**
- Market Research Validator, PRFAQ Validator, PRD Validator, Prototype Spec Validator, Design System Validator, Screen Validator
- Kiro Spec Validator (EARS syntax), Tech Stack Validator (prefers AWS-native services)

**Automatic phase transitions (on file save):**
- Market Research → PRFAQ, PRFAQ → PRD, PRD → Prototype (prompt to continue to the next phase)

**Manual analysis lenses (run on demand):**
- Customer Interview Simulator (roleplay as personas)
- Competitive Response Analyzer
- Risk Analyzer
- Feature Prioritizer (RICE)
- Accessibility Auditor (WCAG)
- Interactivity & Link Checker

See `.kiro/hooks.json` for the full hook configuration. (Claude Code mode has its own equivalents — see *Native Claude Code primitives* below.)

## Design Standards

The toolkit enforces distinctive design to avoid generic "AI slop":

**Anti-Patterns (never use):**
- Generic fonts: Inter, Roboto, Arial
- Purple-to-blue gradients on white
- Uniform card grids
- Bootstrap/Tailwind defaults
- Excessive emojis (unless essential to product tone)

**Required:**
- Distinctive typography per aesthetic direction
- 60-30-10 color rule (dominant/secondary/accent)
- Bouncy animations for key moments
- Visual texture (gradients, shadows, depth)
- Modular file structure for prototypes

## Validation

Each phase includes validation checkpoints:
- Completeness - All required sections present
- Quality - Content is specific and sourced
- Consistency - Aligns with previous phases
- Format - Correct naming conventions

The workflow will not proceed until validation passes.

## AWS-Native Architecture

As an AWS-provided toolkit, PRD technical designs prefer AWS services for enterprise-grade scalability, security, and compliance:

- **Compute:** Lambda, ECS, EC2, App Runner
- **Database:** DynamoDB, Aurora, RDS
- **Generative AI:** Amazon Bedrock, Bedrock AgentCore, Amazon Q
- **Storage:** S3, EFS
- **API:** API Gateway, AppSync
- **Auth:** Cognito

Amazon Bedrock provides access to foundation models from Amazon (Nova) and third-party providers (Anthropic Claude, Meta Llama, Mistral, and more).

## Claude Code / Cursor Mode

For Claude Code or Cursor, copy the auto-loading config files to your project:

```bash
cp CLAUDE.md your-project/       # For Claude Code
cp .cursorrules your-project/    # For Cursor
cp -r prompts/ your-project/prompts/
cp -r .claude/ your-project/.claude/   # Claude Code: subagents, skills, validation hooks
```

The workflow loads automatically when you open your project. Just describe your product idea and the AI will guide you through the phases.

### Native Claude Code primitives

Alongside the prose guides, the toolchest ships native Claude Code integration (the guides in `prompts/*.md` remain the single source of truth — these primitives are thin layers over them):

- **Subagents** (`.claude/agents/`) — `deep-research`, `ai-framing` (AI/ML products only), `prfaq`, `prd`, `design-system`, `screen-builder`, `product-reviewer`. A full build runs the Orchestrator, which dispatches these per phase. The Prototype phase runs `design-system` once, then one `screen-builder` per screen in parallel — each screen gets its own isolated context.
- **Skills** (`.claude/skills/`) — `product-research`, `product-ai-framing`, `product-prfaq`, `product-prd`, `product-prototype`. A solo user can invoke a single phase's expertise inline; the relevant guide loads only when that phase is active (progressive disclosure). A utility skill, `regenerate-screen-index`, rebuilds the ScreenIndex hub from the screens actually on disk after screens are added/removed/renamed.
- **Validation hooks** (`.claude/settings.json`) — on Write/Edit of a `Screen_*.html` a JS syntax gate parses each inline `<script>`; on a `PRD_*.html` an SVG well-formedness + paint check runs. Advisory only (never blocks an edit). **Cross-platform:** it detects the machine and prefers native validators (macOS `osascript`/`xmllint`/`plutil`), falls back to `node --check`/`python3` on Linux/Windows, and if no validator exists it warns and skips rather than silently passing.

No code ships with the toolchest: hooks are inline config in `settings.json` (not committed scripts), and chart libraries are downloaded at build time into the gitignored `documents/lib/`.

See `prompts/Claude_Code_Workflow.md` for the complete workflow guide.

## Requirements

- **[Kiro](https://kiro.dev)** (recommended) - AI-powered IDE with native steering file support
- **Or** any AI coding assistant with file system access (Claude Code, Cursor, etc.)
- Web search capability for market research phase (built into most AI tools)

## Output Format

All documents are generated as **self-contained HTML files**:
- **No CDN-loaded scripts/libraries** — executable code is hand-written inline or downloaded locally. Chart.js is fetched into `documents/lib/` at build time (then integrity-checked), never loaded from a CDN at view time.
- Google Fonts CSS via CDN is the one sanctioned external reference (styling only, degrades to system fonts offline)
- Open directly in any browser (`open documents/PRD_MyProduct_2026-06-03.html`)
- Print to PDF for offline sharing
- Fully styled with professional formatting

## Sample Files

The `samples/` folder includes example outputs from a "TeenFit" project:

```
samples/
├── README.md                      (what each sample demonstrates)
├── teenfit.css                    (shared design tokens & components — the [product-slug].css standard)
├── DesignSystem_TeenFit.html      (design tokens & components reference)
├── PRFAQ_TeenFit.html             (press release & FAQ)
├── PRD_TeenFit.html               (product requirements)
├── Screen_Dashboard_TeenFit.html  (prototype screen — links teenfit.css)
├── Screen_Welcome_TeenFit.html    (prototype screen — links teenfit.css)
└── Screen_WorkoutExecution_TeenFit.html
```

The screens model the modular CSS standard: shared tokens and components live in `teenfit.css`, with screen-specific overrides in each file's `<style>` block. (`ClickablePrototype_TeenFit.html` is the sanctioned single-file exception.) Open any sample in your browser to see the output quality and design standards. The Design System sample includes extensive comments explaining the design philosophy.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
