# Install — use the toolchest anywhere

Three ways to get the Product Toolchest skills, from "every agent, machine-wide" to "one agent, one project." Pick the one that matches your setup.

| Path | Best for | Scope |
|------|----------|-------|
| **1. One-command global install (`install.sh`)** | Kiro, Codex, Cursor, Claude Code — any mix | Every project on your machine |
| **2. Claude Code plugin + marketplace** | Claude Code users who want managed updates | Every project (Claude Code) |
| **3. Per-project copy** | Trying it out, or pinning a project to a version | One project |

---

## 1. One-command global install (recommended)

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

## 2. Claude Code plugin + marketplace

Claude Code's official plugin mechanism, with managed updates:

```
/plugin marketplace add aws-samples/sample-kiro-cli-prompts-for-product-teams
/plugin install product-toolchest@aws-samples-product-toolchest
```

This gives you the `/product-build` command, the phase skills, and the subagents, all self-contained. Update with `/plugin marketplace update aws-samples-product-toolchest`. See `plugins/product-toolchest/README.md`.

---

## 3. Per-project copy

The original mode — copy the config into a single project (see the README's Quick Start). Good for pinning a project to a specific version of the guides.

**Kiro:**
```bash
cp -r .kiro/steering/* your-project/.kiro/steering/
cp .kiro/hooks.json your-project/.kiro/
```

**Claude Code / Cursor:**
```bash
cp CLAUDE.md your-project/        # Claude Code
cp .cursorrules your-project/     # Cursor
cp -r prompts/ your-project/prompts/
cp -r .claude/ your-project/.claude/
```

---

## Which should I use?

- **Want the skills in every project, no per-project setup?** → Path 1.
- **Claude Code only, want `/plugin` updates?** → Path 2.
- **Just evaluating, or need this project pinned?** → Path 3.
