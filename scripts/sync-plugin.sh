#!/usr/bin/env bash
#
# sync-plugin.sh — regenerate plugins/product-toolchest from the repo-root
# source of truth, OR (with --check) verify the committed plugin is in sync.
#
# The repo root is the editable source:
#   prompts/*            -> plugin prompts/ (verbatim)
#   .claude/skills/*     -> plugin skills/  (guide refs rewritten to ${CLAUDE_PLUGIN_ROOT})
#   .claude/agents/*     -> plugin agents/  (same rewrite + brand/lens ref swaps)
#   .kiro/hooks.json     -> plugin prompts/Review_Lenses.md (manual lenses, generated)
#
# Two files have no single-file source and are authored directly in the plugin
# (not regenerated here): prompts/Brand_And_Logo_Rules.md (extracted from CLAUDE.md)
# and the plugin manifest/README/command.
#
# Usage:
#   ./scripts/sync-plugin.sh            # regenerate the bundled plugin in place
#   ./scripts/sync-plugin.sh --check    # verify in sync; exit 1 (no writes) if drifted
#
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

PLUGIN="plugins/product-toolchest"
CHECK=0
[ "${1:-}" = "--check" ] && CHECK=1

# Plugin-authored guides with no single-file repo-root source. They are owned
# by the plugin (hand-authored, e.g. Brand_And_Logo_Rules.md extracted from
# CLAUDE.md), so they are NOT regenerated from source and NOT drift-checked —
# just preserved verbatim across a regenerate.
PLUGIN_AUTHORED_PROMPTS=(Brand_And_Logo_Rules.md)

# Snapshot the authored files up front (before any wipe) so both the in-place
# regenerate and the --check temp build can restore them.
AUTHORED_SNAPSHOT="$(mktemp -d)"
trap 'rm -rf "$AUTHORED_SNAPSHOT"' EXIT
for name in "${PLUGIN_AUTHORED_PROMPTS[@]}"; do
  [ -f "$PLUGIN/prompts/$name" ] && cp "$PLUGIN/prompts/$name" "$AUTHORED_SNAPSHOT/$name"
done

# In --check mode, build into a temp dir and diff against the committed plugin.
# Otherwise, build directly into the plugin's prompts/skills/agents.
if [ "$CHECK" -eq 1 ]; then
  DEST="$(mktemp -d)"
  trap 'rm -rf "$AUTHORED_SNAPSHOT" "$DEST"' EXIT
  mkdir -p "$DEST/prompts" "$DEST/skills" "$DEST/agents"
  OUT="$DEST"
else
  OUT="$PLUGIN"
  rm -rf "$PLUGIN/prompts" "$PLUGIN/skills" "$PLUGIN/agents"
  mkdir -p "$PLUGIN/prompts" "$PLUGIN/skills" "$PLUGIN/agents"
fi

# --- 1) prompts: verbatim copies of the repo-root guides + templates ---------
cp prompts/*.md "$OUT/prompts/"
cp prompts/ScreenIndex_Template.html prompts/ProjectDashboard_Template.html "$OUT/prompts/"

# Restore plugin-authored prompts (snapshotted before any wipe) into the build.
for name in "${PLUGIN_AUTHORED_PROMPTS[@]}"; do
  if [ -f "$AUTHORED_SNAPSHOT/$name" ]; then
    cp "$AUTHORED_SNAPSHOT/$name" "$OUT/prompts/$name"
  fi
done

# --- 2) Review_Lenses.md: generated from the manual lenses in .kiro/hooks.json
python3 - "$OUT/prompts/Review_Lenses.md" <<'PY'
import json, sys
out_path = sys.argv[1]
with open('.kiro/hooks.json') as f:
    h = json.load(f)
manual = [hk for hk in h['hooks'] if (hk.get('trigger', {}) or {}).get('type') == 'manual']
lines = [
    "# Review Lenses",
    "",
    "Self-contained definitions for the on-demand review lenses the `product-reviewer` runs — bundled so the agent needs no project `.kiro/hooks.json`. Run ONE lens at a time, named in the prompt. Each produces findings with specific `file:element` references and concrete fixes; do not fix unless asked.",
    "",
]
for hk in manual:
    lines.append(f"## {hk['name']}")
    lines.append("")
    desc = (hk.get('description') or '').strip()
    if desc:
        lines.append(f"_{desc}_")
        lines.append("")
    lines.append(hk['action']['prompt'].strip())
    lines.append("")
with open(out_path, 'w') as f:
    f.write("\n".join(lines))
PY

# --- 3) skills: copy from .claude/skills, rewrite guide refs to plugin root ---
for d in .claude/skills/*/; do
  name="$(basename "$d")"
  mkdir -p "$OUT/skills/$name"
  cp "$d/SKILL.md" "$OUT/skills/$name/SKILL.md"
done

# --- 4) agents: copy from .claude/agents, same rewrites ----------------------
cp .claude/agents/*.md "$OUT/agents/"

# --- 5) apply the self-contained rewrites to skills + agents -----------------
# (a) bare `prompts/...  ->  `${CLAUDE_PLUGIN_ROOT}/prompts/...
# (b) brand-rule references  ->  the bundled Brand_And_Logo_Rules.md
# (c) lens-definition reference  ->  the bundled Review_Lenses.md
# Edits are idempotent: re-running them on already-rewritten text is a no-op.
rewrite_file() {
  local f="$1"
  perl -0777 -i -pe '
    s{`prompts/}{`\${CLAUDE_PLUGIN_ROOT}/prompts/}g;
    # product-research skill: brand rules
    s{logo/brand-source rules from `CLAUDE\.md`\.}{logo/brand-source rules from `\${CLAUDE_PLUGIN_ROOT}/prompts/Brand_And_Logo_Rules.md`.};
    # deep-research agent: brand rules
    s{Respect BLOCKED/APPROVED logo-source lists in `\.kiro/steering/product-workflow\.md` \(mirrored guidance\) / `CLAUDE\.md`\.}{Respect BLOCKED/APPROVED logo-source lists in `\${CLAUDE_PLUGIN_ROOT}/prompts/Brand_And_Logo_Rules.md`.};
    # product-reviewer agent: lens definitions
    s{Lens definitions mirror the manual agent hooks in `\.kiro/hooks\.json` \(}{Lens definitions are in `\${CLAUDE_PLUGIN_ROOT}/prompts/Review_Lenses.md` (};
  ' "$f"
}
for f in "$OUT"/skills/*/SKILL.md "$OUT"/agents/*.md; do
  rewrite_file "$f"
done

# --- verify / report ---------------------------------------------------------
if [ "$CHECK" -eq 1 ]; then
  # Compare each regenerated subtree against the committed plugin.
  drift=0
  for sub in prompts skills agents; do
    if ! diff -r -q "$PLUGIN/$sub" "$OUT/$sub" >/dev/null 2>&1; then
      echo "DRIFT in $PLUGIN/$sub:"
      diff -r -q "$PLUGIN/$sub" "$OUT/$sub" 2>&1 | sed 's/^/  /'
      drift=1
    fi
  done
  if [ "$drift" -eq 1 ]; then
    echo ""
    echo "The bundled plugin is out of sync with the repo-root source."
    echo "Run ./scripts/sync-plugin.sh and commit the result."
    exit 1
  fi
  echo "Plugin is in sync with the repo-root source."
else
  echo "Regenerated $PLUGIN from the repo-root source."
  echo "Review 'git status' / 'git diff' and commit the result."
fi
