# Product Team's Tool Chest

A comprehensive toolkit that transforms AI coding assistants into your personal product development partner. Go from idea to interactive prototype, with specialized support for AI/ML products.

The toolchest ships as a **portable Agent Plugin** at the root of this repo. Install it once through your editor's own plugin mechanism and use it in every project — across Claude Code, Codex, Cursor, Kiro, and Grok Build. It's built on the open [Agent Plugins](https://agent-plugins.org/) standard (steering committee: Amazon, Cursor, Microsoft, OpenAI, Vercel).

## Install

Each editor installs from this repo using its own native command — no scripts, no per-project copying.

- **Claude Code** (in-session):
  ```
  /plugin marketplace add aws-samples/sample-kiro-cli-prompts-for-product-teams
  /plugin install product-toolchest
  ```
- **Codex** (CLI): `codex plugin marketplace add aws-samples/sample-kiro-cli-prompts-for-product-teams`, then open `/plugins` to install & enable it.
  Desktop: ChatGPT desktop app → Plugins Directory → select the marketplace → install.
- **Kiro** — IDE: Powers panel (⚡) → *Add Custom Power* → *Import power from GitHub* → paste the repo URL.
  CLI: `git clone` the repo, then `kiro-cli powers install ./sample-kiro-cli-prompts-for-product-teams` (or `/powers install <path>` inside a chat).
- **Cursor** (IDE): Customize → Plugins → add the Agent Plugin from the repo.
- **Grok Build**: Plugins panel → install from this git repo.

> Because the plugin lives at the **repo root** (`plugin.json` + `skills/`), the bare repo URL / `owner/repo` reference is all each tool needs.

## Using it

Describe your product work and the matching skill activates (e.g. "research this product idea" → `product-research`; "write the PRD" → `product-prd`; "build the prototype" → `product-prototype`). Each skill loads its bundled guides on demand. All outputs are **self-contained HTML files** in `./documents/` that open directly in any browser — no build step or server.

## How the plugin is organized

Each skill is a small "agent prompt" (`SKILL.md`) plus bundled reference markdown it loads on demand (progressive disclosure):

```
skills/product-research/
├── SKILL.md                      ← agent prompt: role, non-negotiables, when to use
└── references/
    ├── Deep_Research_Agent.md    ← full method + quality gates
    ├── Shared_Standards.md       ← output format, naming, syntax gate
    ├── Handoff_Schema.md         ← payload to downstream phases
    └── Brand_And_Logo_Rules.md   ← customer logo rules
```

References use plain skill-relative paths, so they resolve identically in every Agent Plugins client — no tool-specific variables.

The six skills:

| Skill | Phase |
|-------|-------|
| `product-research` | Deep market research (6 sourced dimensions, TAM/SAM/SOM, personas) |
| `product-ai-framing` | AI/ML problem framing (AI/ML products only) |
| `product-prfaq` | Amazon-style Working Backwards PRFAQ |
| `product-prd` | PRD — EARS requirements + AWS-native architecture |
| `product-prototype` | Interactive, modular HTML prototype |
| `regenerate-screen-index` | Rebuild the prototype navigation hub from screens on disk |

## Workflow

```
Discovery → Deep Market Research → (AI Framing, optional) → PRFAQ → PRD → Prototype
```

Each phase produces a professional, styled HTML deliverable:

- **Deep Market Research** — 6 parallel dimensions, 120+ sources with quality gates, market sizing, customer pain points, technology radar mapped to AWS services, verified customer brand assets. → `MarketResearch_[Product]_[Date].html`
- **AI Framing** (AI/ML only) — ML problem type, input/output schemas, metrics with thresholds, data strategy. → `AIFraming_[ProductSlug]_[Date].html`
- **PRFAQ** — press release (as if already launched) + skeptical FAQ, grounded in research. → `PRFAQ_[Product]_[Date].html`
- **PRD** — personas, EARS requirements, current-year technology research, inline SVG architecture diagram. → `PRD_[Product]_[Date].html` + `.kiro/specs/[product-slug]/requirements.md`
- **Prototype** — shared `[product-slug].css` → `DesignSystem_*.html` → per-screen `Screen_*.html` → `ScreenIndex_*.html` hub, with realistic data/interactions and a per-screen dependency-load guard + error banner.

## Design Standards

Distinctive design, no generic "AI slop":

**Anti-patterns (never use):** generic fonts (Inter, Roboto, Arial); purple-to-blue gradients on white; uniform card grids; Bootstrap/Tailwind defaults; excessive emojis.

**Required:** distinctive typography; the 60-30-10 color rule; bouncy animations for key moments; visual texture; modular file structure for prototypes.

## AWS-Native Architecture

PRD technical designs prefer AWS services: Lambda/ECS/EC2/App Runner (compute); DynamoDB/Aurora/RDS (database); Amazon Bedrock, Bedrock AgentCore, Amazon Q (generative AI); S3/EFS (storage); API Gateway/AppSync (API); Cognito (auth). Bedrock provides foundation models from Amazon (Nova) and third parties (Anthropic Claude, Meta Llama, Mistral, and more).

## Output Format

All documents are **self-contained HTML**: no CDN-loaded scripts (Chart.js is downloaded into the gitignored `documents/lib/` at build time, integrity-checked); Google Fonts CSS is the one sanctioned external reference; open directly in any browser; print to PDF for sharing.

## Editor-native source layers

Alongside the portable plugin, this repo also keeps the editor-native layers for teams who prefer them per-project: Kiro steering (`.kiro/steering/`) and hooks (`.kiro/hooks.json`), the Claude Code files (`CLAUDE.md`, `.claude/`), Cursor rules (`.cursorrules`), and the shared guides in `prompts/`. The plugin's skills bundle the same guidance from these sources, so you can use either path.

## Sample Files

The [`samples/`](samples/) folder includes example outputs from a "TeenFit" project — a Design System, PRFAQ, PRD, and prototype screens modeling the modular CSS standard. Open any in a browser to see the output quality.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
