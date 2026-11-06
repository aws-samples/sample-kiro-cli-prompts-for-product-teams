# product-team-ai-kit: design

Status: proposal (draft PR). Owners for review: @nateober, @famestad.

`product-team-ai-kit` is a small command that configures a project folder for an AI agent harness with the Product Team's Tool Chest workflow. A user installs it once with one shell command, `cd`s into a new project, and runs `product-team-ai-kit --agent claude` (or `kiro`, `cursor`, `codex`, `copilot`, `gemini`, `windsurf`).

## 1. What the toolkit is today

**Workflow.** Deep Market Research (6 dimensions, 120+ sources standard, 150+ comprehensive) -> AI Framing (AI/ML products only) -> PRFAQ -> PRD (includes the internal Technology Research sub-step) -> Prototype (starts with the internal Prototype Spec, then the strict build order: shared CSS -> Design System -> Design Token Contract -> screen manifest and sidebar shell -> `Screen_*.html` -> `ScreenIndex_*.html`). A live `ProjectDashboard_*.html` is regenerated after every phase. Open PR #4 adds a Threat Modeling phase between PRD and Prototype. Every deliverable is a self-contained HTML file in `documents/`.

**Shared layers in `prompts/`.** `Orchestrator.md` routes phases and dispatches per-phase agents. `Handoff_Schema.md` is the payload contract between phases. `Shared_Standards.md` holds the runtime baseline, syntax gate, file naming and budgets. CONTRIBUTING declares `prompts/*.md` the single source of truth.

**Per-harness layers on main.**

| Layer | Contents | How it relates to `prompts/` |
|---|---|---|
| Claude Code | `CLAUDE.md` (always-on summary), `.claude/agents/` (7 subagents), `.claude/skills/` (6 skills), `.claude/settings.json` (advisory syntax/SVG hooks) | Agents and skills are thin shims that say "read `prompts/X.md` first" |
| Kiro | `.kiro/steering/` (2 `always`, 5 `manual`, 5 `fileMatch` specialists), `templates/`, `.kiro/hooks.json` (17 hooks) | A parallel, condensed rewrite (for example `prd-guide.md` is 249 lines against 549 in `PRD_Creation_Guide.md`); it never references `prompts/`, except once |
| Cursor | `.cursorrules` | A near-copy of `CLAUDE.md` with harness-neutral wording |

## 2. Drift found (main at `eee1436`)

What already matches: the two templates are byte-identical in `prompts/` and `.kiro/steering/templates/`, and the source gates (120+/150+, 15+/20+ per dimension), the "5 Logo Gate checks", and the hook, agent and skill counts agree everywhere. These mismatches remain:

1. **`.kiro/hooks.json` is probably never loaded.** Kiro IDE 1.0 and CLI V3 read `.kiro/hooks/*.json` with `"version": "v1"`, PascalCase triggers (`PostFileSave`) and `action.type: "agent"`. IDE 0.x read `.kiro.hook` files (`when`/`then`). The repo's single file uses `trigger.type: "onFileSave"` and `action.type: "agentPrompt"`, which matches neither documented format ([Kiro hooks, 1.0](https://kiro.dev/docs/ide/whats-new-v1/hooks/)). So the 17 validators, phase transitions and lenses that the README advertises likely never fire. The 6 manual lenses have no v1 equivalent; Kiro's docs say to use `manual` steering files instead.
2. **Kiro has no AI Framing guide.** `prompts/AI_Framing_Agent.md` (284 lines) and its template have no Kiro mirror. `product-workflow.md` covers AI Framing in about 20 lines. No hook validates `AIFraming_*.html`, and the "Market Research -> PRFAQ" transition hook never offers AI Framing.
3. **Kiro has no mirror of `Orchestrator.md`, `Handoff_Schema.md` or `Document_Summarizer.md`.** It folds parts of `Shared_Standards.md` inline.
4. **The logo-source rules contradict each other.** Kiro's `product-workflow.md` and `market-research.md` BLOCK `wikipedia.org` image URLs and `wikimedia.org`. `CLAUDE.md`, `.cursorrules`, `prompts/Prototype_Creation_Guide.md` (and PR #9's `Brand_And_Logo_Rules.md`) list Wikipedia as a source to try.
5. **Cross-layer references break for single-harness installs.** `.claude/agents/deep-research.md` sends the agent to `.kiro/steering/product-workflow.md` / `CLAUDE.md` for the BLOCKED/APPROVED logo lists, but `CLAUDE.md` has no such lists, and a Claude-only install has no `.kiro/`. `.kiro/steering/design-standards.md` cites `prompts/Shared_Standards.md`, which a Kiro-only install (README Quick Start) does not copy. `.claude/skills/product-research` cites `CLAUDE.md`, which a Codex install does not have.
6. **`CLAUDE.md` and `.cursorrules` disagree** (45 differing lines). `.cursorrules` has the newer "HTML-only deliverables; markdown only for `requirements.md`" rule and a Design Standards section (no Inter/Roboto/Arial/system-ui). `CLAUDE.md` has the extended token rules (spacing/shadow/radius/z-index/animation `var()`) and the native-primitives roster. `CLAUDE.md` also cites `Prototype_Creation_Guide.md` without its `prompts/` prefix.
7. **Phase numbering differs.** README, `Claude_Code_Workflow.md` and Kiro use 1, 1b, 2, 3, 4. `CLAUDE.md` and `.cursorrules` number 1-5 (AI Framing = 2, Prototype = 5). PR #4 renumbers Prototype to 5 in the workflow files only.
8. **`.cursorrules` is Cursor's legacy format.** Cursor documents `.cursor/rules/*.mdc` ([Cursor rules](https://docs.cursor.com/en/context/rules)).
9. **Orphans.** Nothing references `prompts/LLM_Workflow_Checklist.md`, `Sample_ClickablePrototype_AnyCompanyLearning.html` or `Sample_Screen_Dashboard.html`.
10. **The open PRs add layers.** PR #9's `skills/*/references/` are a fourth copy of `prompts/` (all identical except `AI_Framing_Agent.md`, with 3 path rewrites). PR #4 is based on `04cd866` (before #5, #6 and #7). It edits `prompts/Handoff Schema.md` (main renamed it to `Handoff_Schema.md`) and adds `prompts/Threat Modeling Guide.md` with spaces. It adds no Claude agent/skill or `.cursorrules` entry for the new phase.

This PR does not change any workflow content. It surfaces these items and guards against new drift in CI (`scripts/check.sh`, section 5).

## 3. Source of truth for the CLI

The CLI does not regenerate harness layers from `prompts/`. It copies the reviewed layers that already exist and adds thin wrappers for harnesses that have no native layer. Regenerating Kiro steering or `CLAUDE.md` from `prompts/` would silently replace content the authors tuned per harness (item 3 above shows how different it is), and a generator would itself become a new drift source.

- **One registry: `kit/agents.map`.** This is the single, line-oriented list of what each agent gets (`agent|mode|source|target`). Shared groups (`@guides`, `@gitignore`, `@samples`) keep `prompts/` listed once.
- **Guides:** `prompts/` (unchanged; still the declared SoT).
- **Always-on summary for AGENTS.md, GEMINI.md, Copilot and Cursor:** `.cursorrules`, because it is the harness-neutral wording ("AI assistants") and the more current of the two summaries (item 6). Recommendation for a later PR: rename it to a repo-root `AGENTS.md` and reduce `CLAUDE.md` to `@AGENTS.md` plus Claude-specific lines. That collapses item 6 for good.
- **Skills for Codex and Windsurf:** `.claude/skills/` (plain `name`/`description` front matter, valid Agent Skills). When PR #9 merges, these two map lines switch to `skills/`, and the bundled `references/` remove the need to copy `prompts/` for those agents.

## 4. Supported agents and files written

Every agent also gets a managed block in `.gitignore` (generated `documents/` output, `documents/lib/`) and the manifest `.product-team-ai-kit.json`. "Block" means a delimited `<!-- BEGIN/END product-team-ai-kit -->` section is appended to the file, and only that section is ever updated.

| `--agent` | Files written in the project | Files | Convention source |
|---|---|---|---|
| `claude` | `CLAUDE.md` (block), `.claude/agents/*.md` (7), `.claude/skills/*/SKILL.md` (6), `.claude/settings.json`, `prompts/` (15) | 32 | repo's own layer |
| `kiro` | `.kiro/steering/*.md` (12), `.kiro/steering/templates/*.html` (2), `.kiro/hooks.json` | 18 | repo's own layer ([steering](https://kiro.dev/docs/steering/)) |
| `cursor` | `.cursor/rules/product-team-ai-kit.mdc` (`alwaysApply: true` + `.cursorrules`), `prompts/` | 18 | [Cursor rules](https://docs.cursor.com/en/context/rules) |
| `codex` | `AGENTS.md` (block), `.agents/skills/*/SKILL.md` (6), `prompts/` | 24 | [Codex skills](https://developers.openai.com/codex/skills) scan `.agents/skills` |
| `copilot` | `.github/copilot-instructions.md` (block), `prompts/` | 18 | [Copilot repo instructions](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions) |
| `gemini` | `GEMINI.md` (block), `prompts/` | 18 | [GEMINI.md](https://geminicli.com/docs/cli/gemini-md/) |
| `windsurf` | `AGENTS.md` (block), `.agents/skills/*/SKILL.md` (6), `prompts/` | 24 | Windsurf is now Devin Local, which reads `AGENTS.md` and `.agents/skills/`, and still imports legacy `.windsurf/rules` ([docs](https://docs.devin.ai/desktop/cascade/memories)) |

`--include-samples` adds `samples/` and `prompts/Sample_*.html`. `codex` and `windsurf` share `AGENTS.md`; selecting both writes one block. The `kiro` entry copies `.kiro/hooks.json` as it is today, so it matches the README's manual install. It should move to `.kiro/hooks/*.json` v1 when item 1 is fixed, which is a one-line map change.

## 5. Distribution

| Option | One command | Needs a runtime | Needs a registry account | Verifiable | Notes |
|---|---|---|---|---|---|
| `npm i -g github:...` / `npx github:...` | yes | Node + npm | no | weak (git ref, no checksum) | the repo's `.gitignore` ignores `package.json` today; product users often lack Node |
| npm registry publish | yes | Node + npm | yes (org scope) | npm provenance | best UX for JS users only |
| `uv tool install git+https://...` | yes | uv + Python | no | weak | adds a Python packaging layer for a shell-sized tool |
| Homebrew tap | yes (after `brew tap`) | Homebrew | a tap repo | bottle SHA | macOS-centric; a second repo to maintain |
| **`curl ... install.sh \| sh` from GitHub Releases** | **yes** | **none (POSIX sh)** | **no** | **SHA-256 + provenance** | the chosen path |

**Chosen: a POSIX-sh CLI and installer, distributed through GitHub Releases.**

```sh
curl -fsSL https://github.com/aws-samples/sample-kiro-cli-prompts-for-product-teams/releases/latest/download/install.sh | sh
```

- **Installer.** `install.sh` resolves the latest tag from the `releases/latest` redirect (no API call, no token), or uses `PTAK_VERSION=vX.Y.Z`. It downloads `product-team-ai-kit-<tag>.tar.gz` and `checksums.txt` over HTTPS and aborts on a SHA-256 mismatch or a missing `checksums.txt`. It rejects archives with absolute paths, `..` or links, and installs to `${XDG_DATA_HOME:-~/.local/share}/product-team-ai-kit/<tag>`, linking `${PTAK_BIN_DIR:-~/.local/bin}/product-team-ai-kit`. It never uses sudo and never edits rc files unless `PTAK_MODIFY_PATH=1`. Everything runs inside `main`, called on the last line, so a truncated download runs nothing. Re-running upgrades and prunes the old version; `--uninstall` removes it.
- **Ordering of downloads.** The tag is resolved first, then both assets are fetched from `releases/download/<tag>/`. Fetching each asset from `latest/download/` could mix two releases if one is published between the requests.
- **Dev escape hatch.** `PTAK_REF=<branch> PTAK_INSECURE_SKIP_VERIFY=1` installs an unreleased ref from codeload with a loud warning. Each variable is refused without the other.
- **CLI.** POSIX sh, offline, and has no `eval`. Every target is checked inside `--dir` (no absolute paths, `.`/`..` components, odd characters, or existing symlink components). It never overwrites a changed file without `--force`, and it updates files it wrote itself (tracked by SHA-256 in the manifest) only if the user has not edited them. Exit codes: 0 ok, 2 usage/unknown agent, 3 conflict, 4 dir/path problem, 5 missing tool, 1 other. `self-update` upgrades only to a newer release, and runs that release's `install.sh` only after checking its SHA-256 against `checksums.txt`.
- **What publishing to a registry would add later.** npm, PyPI or Homebrew packaging could wrap the same tarball for users who prefer those tools. None of them is needed for "one command, works anywhere".

**Relationship to PR #9 (Agent Plugin).** The two paths complement each other. #9 installs the toolchest into the editor (user-scoped, loaded on demand through the editor's plugin manager) for Claude Code, Codex, Cursor, Kiro and Grok. This CLI writes always-on, per-project files that are committed with the project. That serves teams who want the workflow pinned in the repo, harnesses with no plugin support (Gemini CLI, Copilot, Windsurf), and offline machines. Unlike the custom `install.sh` that #8 removed, this installer does not copy skills into each editor's global config. The registry design lets the CLI consume #9's `skills/` once it merges, so there is one skill tree.

**Relationship to PR #4 (Threat Modeling).** Nothing blocks it. After #4 is rebased, its new guide becomes one `@guides` line in `kit/agents.map`, and its Kiro files are picked up automatically by the `kiro` entry's `dir` copy. `scripts/check.sh` fails CI if a new `prompts/` file is not listed, so the phase cannot be silently left out of installs. The `|` separator allows file names with spaces, though `Threat_Modeling_Guide.md` would match the repo's convention.

## 6. Releases

`.github/workflows/release.yml` runs only on a pushed `v*.*.*` tag:

1. **guard:** checks the tag against `^v[0-9]+\.[0-9]+\.[0-9]+$` (pre-releases are rejected, to keep `self-update`'s version comparison simple), checks that `VERSION` at the tagged commit equals the tag, and checks that the tagged commit is an ancestor of `origin/main` (`scripts/check-release-tag.sh`).
2. **test:** runs the full `cli.yml` (shellcheck, the content check, and tests on ubuntu and macOS under dash and bash) via `workflow_call`.
3. **build:** runs `scripts/build-release.sh`. `git archive` of the tagged commit, restricted to what the installer needs under one top-level dir, is piped through `gzip -n`. The output is reproducible, and the tests check it byte-for-byte. The job produces `install.sh` and `checksums.txt` alongside the tarball.
4. **attest:** `actions/attest-build-provenance` for the tarball and `install.sh` (`id-token: write`, `attestations: write` on this job only).
5. **release:** `gh release create "$TAG" --verify-tag --generate-notes` with the three assets (`contents: write` on this job only).

Actions are pinned by SHA, and `contents: read` is the default everywhere. Concurrency is grouped per tag.

**Cutting a release** (maintainers): bump `VERSION`, merge to `main`, then `git tag vX.Y.Z && git push origin vX.Y.Z`. The release job passes `--latest`, so each CLI release becomes what `releases/latest` resolves to.

**Existing `v1.0.0`.** The repo already has a `v1.0.0` release (2026-10-14, no assets; its notes say v1 will be sunset in v2 in favour of the plugin format). Today `releases/latest` resolves to it, and the installer refuses it because there is no `checksums.txt`. The first CLI release should therefore be numbered above `v1.0.0` (for example `v2.0.0`, matching that note). Shipping `v0.1.0` would sort below it, and `self-update` from `0.1.0` would treat `v1.0.0` as an upgrade. `VERSION` is `0.1.0` in this PR only as a placeholder for the maintainers' decision.
