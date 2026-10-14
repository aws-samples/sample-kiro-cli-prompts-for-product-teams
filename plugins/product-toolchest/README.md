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

## Keeping the plugin in sync (maintainers)

The repo root is the editable source of truth; this plugin bundles a **generated** mirror so it travels self-contained. The mapping:

| Source | Bundled as | How |
|--------|-----------|-----|
| `prompts/*` | `prompts/*` | verbatim copy |
| `.claude/skills/*` | `skills/*` | copy + guide refs rewritten to `${CLAUDE_PLUGIN_ROOT}` |
| `.claude/agents/*` | `agents/*` | copy + guide/brand/lens refs rewritten |
| `.kiro/hooks.json` (manual lenses) | `prompts/Review_Lenses.md` | generated |
| *(hand-authored)* | `prompts/Brand_And_Logo_Rules.md` | owned by the plugin — extracted from `CLAUDE.md`, not generated |

After editing any source file, regenerate and commit:

```bash
./scripts/sync-plugin.sh          # regenerate the bundled plugin in place
```

CI (`.github/workflows/plugin-sync.yml`) runs `./scripts/sync-plugin.sh --check` on every PR that touches the source or the plugin, and **fails if the two have drifted** — so a forgotten re-sync is caught before merge. If a release warrants it, bump `version` in `.claude-plugin/plugin.json`.
