# Product Toolchest — Claude Code Plugin

A self-contained Claude Code plugin that turns Claude into a product-development partner: deep market research → PRFAQ → PRD → interactive HTML prototype.

Unlike the per-project files in the repo root, this plugin **installs once and works in every project** — all guides travel with the plugin, so skills and subagents resolve their references against `${CLAUDE_PLUGIN_ROOT}` instead of a `prompts/` directory in your working tree.

## Install

From Claude Code, add this repo as a marketplace, then install the plugin:

```
/plugin marketplace add aws-samples/sample-kiro-cli-prompts-for-product-teams
/plugin install product-toolchest@aws-samples-product-toolchest
```

Updates come through `/plugin marketplace update aws-samples-product-toolchest`.

For a one-command, cross-agent global install (Kiro, Codex, Cursor, and Claude Code), use the repo's `install.sh` instead — see the top-level `INSTALL.md`.

## What's inside

- **`/product-build`** command — runs the full workflow for a product idea, with a per-phase approval gate.
- **Skills** (`skills/`) — `product-research`, `product-ai-framing`, `product-prfaq`, `product-prd`, `product-prototype`, and the `regenerate-screen-index` utility. Each loads the relevant bundled guide only when its phase is active (progressive disclosure).
- **Subagents** (`agents/`) — `deep-research`, `ai-framing`, `prfaq`, `prd`, `design-system`, `screen-builder` (one per screen, in parallel), `product-reviewer`.
- **Guides** (`prompts/`) — the single source of truth, bundled so skills/agents are self-contained: the phase guides plus `Brand_And_Logo_Rules.md` and `Review_Lenses.md` (extracted from the repo's `CLAUDE.md` and `.kiro/hooks.json` so no project config is required), and the ScreenIndex/ProjectDashboard templates.

## Usage

```
/product-build a meal-planning app for busy parents
```

Or invoke a single phase by its skill (e.g. ask Claude to "do market research on …" and the `product-research` skill activates). Outputs are self-contained HTML files in `./documents/` of your current project.

## Notes

- No executable code ships with the plugin. Chart.js is downloaded at build time into the gitignored `documents/lib/` during the Prototype phase.
- The plugin's guides mirror the repo's `prompts/*.md`; the repo root remains the editable source. When those change, bump `version` in `.claude-plugin/plugin.json` and the plugin's bundled copies.
