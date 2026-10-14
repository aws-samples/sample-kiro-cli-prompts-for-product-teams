# Product Toolchest — Claude Code Plugin

A self-contained Claude Code plugin that turns Claude into a product-development partner: deep market research → PRFAQ → PRD → interactive HTML prototype.

This plugin is the **single source of truth** for the toolchest. It **installs once and works in every project** — all guides travel with the plugin, so skills and subagents resolve their references against `${CLAUDE_PLUGIN_ROOT}` instead of a `prompts/` directory in your working tree.

## Install

From Claude Code, add this repo as a marketplace, then install the plugin:

```
/plugin marketplace add aws-samples/sample-kiro-cli-prompts-for-product-teams
/plugin install product-toolchest@aws-samples-product-toolchest
```

Updates come through `/plugin marketplace update aws-samples-product-toolchest`.

Prefer a one-command install across Kiro, Codex, and Cursor as well? Use the repo's `install.sh` — see the top-level `INSTALL.md`.

## What's inside

- **`/product-build`** command (`commands/`) — runs the full workflow for a product idea, with a per-phase approval gate.
- **Skills** (`skills/`) — `product-research`, `product-ai-framing`, `product-prfaq`, `product-prd`, `product-prototype`, and the `regenerate-screen-index` utility. Each loads the relevant bundled guide only when its phase is active (progressive disclosure).
- **Subagents** (`agents/`) — `deep-research`, `ai-framing`, `prfaq`, `prd`, `design-system`, `screen-builder` (one per screen, in parallel), `product-reviewer`.
- **Guides** (`prompts/`) — the authoritative workflow guides, self-contained so skills/agents need no project files: the phase guides, `Brand_And_Logo_Rules.md`, `Review_Lenses.md` (the on-demand review-lens definitions), and the ScreenIndex/ProjectDashboard HTML templates.
- **Validation hooks** (`hooks/hooks.json`) — on Write/Edit of a `Screen_*.html` a JS syntax gate parses each inline `<script>`; on a `PRD_*.html` an SVG well-formedness + paint check runs. Advisory only (never blocks an edit) and cross-platform (prefers native `osascript`/`xmllint`, falls back to `node`/`python3`, honest-skips with a warning if neither is present).

## Usage

```
/product-build a meal-planning app for busy parents
```

Or invoke a single phase by its skill (e.g. ask Claude to "do market research on …" and the `product-research` skill activates). Outputs are self-contained HTML files in `./documents/` of your current project.

## Editing (maintainers)

The files in this directory are the source — edit them directly:

- A guide → edit the file under `prompts/`.
- A skill or subagent → edit `skills/<name>/SKILL.md` or `agents/<name>.md`. Guide references use `${CLAUDE_PLUGIN_ROOT}/prompts/…` so they resolve wherever the plugin is installed; keep that form.
- A review lens → edit `prompts/Review_Lenses.md`.
- The validation gate → edit `hooks/hooks.json`.

Bump `version` in `.claude-plugin/plugin.json` for a release. No executable code ships with the plugin (hooks are inline commands); Chart.js is downloaded at build time into the gitignored `documents/lib/` during the Prototype phase.
