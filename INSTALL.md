# Install

The toolchest ships as a plugin. Two ways to install it, depending on which agents you use.

| Path | Best for | Scope |
|------|----------|-------|
| **1. Claude Code plugin + marketplace** | Claude Code users who want managed updates | Every project (Claude Code) |
| **2. One-command global install (`install.sh`)** | Kiro, Codex, Cursor, Claude Code — any mix | Every project on your machine |

Both install the **same self-contained skills** — the guides travel with them (resolved against `${CLAUDE_PLUGIN_ROOT}` or the installed skills dir), so they work in every project with zero per-project files.

---

## 1. Claude Code plugin + marketplace

Claude Code's official plugin mechanism, with managed updates:

```
/plugin marketplace add aws-samples/sample-kiro-cli-prompts-for-product-teams
/plugin install product-toolchest@aws-samples-product-toolchest
```

This gives you the `/product-build` command, the phase skills, the subagents, and the advisory validation hooks. Update with `/plugin marketplace update aws-samples-product-toolchest`. See `plugins/product-toolchest/README.md`.

---

## 2. One-command global install

Installs the skills into each detected agent's **global** skills directory, so they work in every project without copying files per-project. The shared guides are installed once under `~/.product-toolchest/` and each skill is rewritten to resolve its guides against that payload.

```bash
git clone https://github.com/aws-samples/sample-kiro-cli-prompts-for-product-teams
cd sample-kiro-cli-prompts-for-product-teams
./install.sh                 # install for every agent it detects
```

Options:

```bash
./install.sh --dry-run                 # show what it would do, change nothing
./install.sh --agents kiro,claude      # restrict to specific agents
./install.sh --uninstall               # surgically remove only toolchest skills + payload
```

It installs into whichever of these exist:

| Agent | Global skills dir |
|-------|-------------------|
| Kiro | `~/.kiro/skills/` |
| Claude Code | `~/.claude/skills/` |
| Codex | `~/.codex/skills/` |
| Cursor | `~/.cursor/skills/` |

Skills use the open [Agent Skills](https://code.claude.com/docs/en/skills) `SKILL.md` format, which is cross-compatible across these tools. Re-run `install.sh` any time to update; `--uninstall` removes only the skills this installer placed (identified by a marker file) and leaves your other skills untouched.

> **Note:** Cursor also reads Claude's and Codex's skills dirs, so installing for either of those already covers Cursor on many setups.

---

## Which should I use?

- **Claude Code, want `/plugin` updates and the validation hooks?** → Path 1.
- **Kiro / Codex / Cursor, or a mix, and want it in every project machine-wide?** → Path 2.

> **Migrating from the old per-project setup?** Earlier versions required copying `CLAUDE.md`, `.cursorrules`, `prompts/`, `.claude/`, and `.kiro/` into each project. That flow is retired — install the plugin (Path 1) or run `install.sh` (Path 2) once instead. You can delete those copied files from your projects.
