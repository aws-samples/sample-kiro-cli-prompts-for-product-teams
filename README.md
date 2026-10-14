# Product Team's Tool Chest

A comprehensive toolkit that transforms AI coding assistants into your personal product development partner. Go from idea to interactive prototype, with specialized support for AI/ML products.

The toolchest ships as a **plugin** you install once and use in every project — no copying files per project. It works with Claude Code, Kiro, Codex, and Cursor via the open [Agent Skills](https://code.claude.com/docs/en/skills) format.

## Install

Full guide: **[INSTALL.md](INSTALL.md)**. Two paths:

**Claude Code — plugin + marketplace** (managed updates):

```
/plugin marketplace add aws-samples/sample-kiro-cli-prompts-for-product-teams
/plugin install product-toolchest@aws-samples-product-toolchest
```

**Any agent (Kiro / Codex / Cursor / Claude Code) — one-command global install:**

```bash
git clone https://github.com/aws-samples/sample-kiro-cli-prompts-for-product-teams
cd sample-kiro-cli-prompts-for-product-teams
./install.sh            # detects your agents; --dry-run / --uninstall supported
```

Both install the same self-contained skills into each agent's global config dir, so they work in every project with zero per-project files. The plugin itself lives in [`plugins/product-toolchest/`](plugins/product-toolchest/).

> **Upgrading from an older version?** The toolchest used to require copying `CLAUDE.md`, `.cursorrules`, `prompts/`, `.claude/`, and `.kiro/` into each project. **That per-project flow is retired** in favor of the plugin. Install via one of the paths above and delete those copied files from your projects. See the migration note in [INSTALL.md](INSTALL.md).

## Using it

Once installed, in any project:

```
/product-build a meal-planning app for busy parents     # Claude Code — full workflow with per-phase gates
```

Or just describe your product idea and let the relevant phase skill activate (e.g. "do market research on …" triggers the `product-research` skill). All outputs are **standalone HTML files** in `./documents/` that open directly in any browser — no build step or server.

## Workflow

```
Discovery → Deep Market Research → PRFAQ → PRD → Prototype
```

Each phase produces a professional, styled HTML deliverable. By default the workflow **pauses after each phase** for your review (Full Approval mode); say "switch to streamlined" to run continuously.

### Phase 1: Deep Market Research
- 6 parallel research dimensions (Industry, Competitive, Customer, Technology, Adjacent Innovation, Policy/Risk/Opportunity)
- 120+ sources minimum with quality gates; every figure sourced
- Market sizing (TAM/SAM/SOM), customer pain points, technology radar mapped to AWS services
- Customer brand research (verified logo + colors) when applicable

**Output:** `MarketResearch_[Product]_[Date].html`

### Phase 1b: AI Framing (optional)
For AI/ML products only — ML problem type, input/output schemas, success metrics and thresholds, training-data strategy.

**Output:** `AIFraming_[ProductSlug]_[Date].html`

### Phase 2: PRFAQ
Amazon-style Working Backwards: press release (as if already launched) + a skeptical FAQ, grounded in the research brief.

**Output:** `PRFAQ_[Product]_[Date].html`

### Phase 3: PRD (Requirements)
Implementation-ready spec: personas, EARS-syntax requirements, user stories, current-year technology research, inline SVG architecture diagram, success metrics.

**Output:** `PRD_[Product]_[Date].html` + `.kiro/specs/[product-slug]/requirements.md` (the one machine-consumed markdown artifact)

### Phase 4: Prototype
Interactive HTML prototype with a modular file structure:
- Shared `[product-slug].css` design tokens → `DesignSystem_*.html` → per-screen `Screen_*.html` → `ScreenIndex_*.html` navigation hub
- Distinctive visual design (no generic "AI slop"); realistic data and interactions (state persists via localStorage)
- Chart.js downloaded to a gitignored `documents/lib/` at build time (never a CDN script), with a dependency-load guard + global error banner on every screen
- Syntax gate + adversarial Bug Hunt pass before any screen is declared done

**Output:**
```
documents/
├── lib/chart.min.js                      (downloaded at build time, gitignored)
├── [product-slug].css                    (shared design tokens)
├── DesignSystem_[Product]_[Date].html
├── ScreenIndex_[Product]_[Date].html     (navigation hub)
├── Screen_[Name]_[Product]_[Date].html   (one per screen)
└── ProjectDashboard_[Product]_[Date].html  (live status — regenerated after every phase)
```

## What's in the plugin

[`plugins/product-toolchest/`](plugins/product-toolchest/) is the single source of truth:

- **`/product-build`** command — the full workflow with per-phase approval gates.
- **Skills** (`skills/`) — `product-research`, `product-ai-framing`, `product-prfaq`, `product-prd`, `product-prototype`, plus the `regenerate-screen-index` utility. Each loads its guide only when its phase is active (progressive disclosure).
- **Subagents** (`agents/`) — `deep-research`, `ai-framing`, `prfaq`, `prd`, `design-system`, `screen-builder` (one per screen, in parallel), `product-reviewer`.
- **Guides** (`prompts/`) — the authoritative workflow guides, self-contained (skills/agents resolve them against `${CLAUDE_PLUGIN_ROOT}`): the phase guides, `Brand_And_Logo_Rules.md`, `Review_Lenses.md`, and the ScreenIndex/ProjectDashboard templates.
- **Validation hooks** (`hooks/hooks.json`) — on Write/Edit of a `Screen_*.html` a JS syntax gate parses each inline `<script>`; on a `PRD_*.html` an SVG well-formedness + paint check runs. Advisory (never blocks) and cross-platform (prefers native `osascript`/`xmllint`, falls back to `node`/`python3`, honest-skips if neither is present).

No executable code ships with the toolchest: hooks are inline commands, and chart libraries are downloaded at build time into the gitignored `documents/lib/`.

## Design Standards

The toolkit enforces distinctive design to avoid generic "AI slop":

**Anti-patterns (never use):** generic fonts (Inter, Roboto, Arial); purple-to-blue gradients on white; uniform card grids; Bootstrap/Tailwind defaults; excessive emojis.

**Required:** distinctive typography per aesthetic direction; the 60-30-10 color rule; bouncy animations for key moments; visual texture (gradients, shadows, depth); modular file structure for prototypes.

## AWS-Native Architecture

As an AWS-provided toolkit, PRD technical designs prefer AWS services for enterprise-grade scalability, security, and compliance:

- **Compute:** Lambda, ECS, EC2, App Runner
- **Database:** DynamoDB, Aurora, RDS
- **Generative AI:** Amazon Bedrock, Bedrock AgentCore, Amazon Q
- **Storage:** S3, EFS
- **API:** API Gateway, AppSync
- **Auth:** Cognito

Amazon Bedrock provides access to foundation models from Amazon (Nova) and third-party providers (Anthropic Claude, Meta Llama, Mistral, and more).

## Output Format

All documents are generated as **self-contained HTML files**:
- No CDN-loaded scripts/libraries — executable code is hand-written inline or downloaded locally (Chart.js into `documents/lib/`, integrity-checked, never loaded from a CDN at view time).
- Google Fonts CSS via CDN is the one sanctioned external reference (styling only; degrades to system fonts offline).
- Open directly in any browser; print to PDF for offline sharing.

## Sample Files

The [`samples/`](samples/) folder includes example outputs from a "TeenFit" project — a Design System, PRFAQ, PRD, and several prototype screens that model the modular CSS standard (shared tokens in `teenfit.css`, screen-specific overrides in each file's `<style>` block). Open any sample in your browser to see the output quality and design standards.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
