#!/usr/bin/env bash
#
# install.sh — install the Product Toolchest skills GLOBALLY so they work in
# every project on your machine, for whichever agents you have installed.
#
# Mirrors the modern "skills live in the agent's global config dir" model
# (e.g. ~/.claude/skills, ~/.kiro/skills, ~/.codex/skills, ~/.cursor/skills).
# The shared guide payload (prompts/) is installed once under a toolchest home,
# and each globally-installed skill is rewritten to resolve its guides against
# that payload — so the skills are self-contained outside this repo.
#
# Usage:
#   ./install.sh                 # install for every detected agent
#   ./install.sh --agents kiro,claude
#   ./install.sh --dry-run       # show what would happen, change nothing
#   ./install.sh --uninstall     # remove toolchest skills + payload (surgical)
#   ./install.sh --help
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$SCRIPT_DIR/plugins/product-toolchest"
SRC_SKILLS="$PLUGIN_DIR/skills"
SRC_PROMPTS="$PLUGIN_DIR/prompts"

# Toolchest home: shared payload lives here; skills point at $TOOLCHEST_HOME/prompts.
TOOLCHEST_HOME="${TOOLCHEST_HOME:-$HOME/.product-toolchest}"
MARKER=".product-toolchest-skill"   # dropped in each installed skill dir for surgical uninstall

DRY_RUN=0
UNINSTALL=0
AGENTS_ARG=""

# agent -> global skills dir
declare -A AGENT_DIR=(
  [kiro]="$HOME/.kiro/skills"
  [claude]="$HOME/.claude/skills"
  [codex]="$HOME/.codex/skills"
  [cursor]="$HOME/.cursor/skills"
)
# agent -> a config dir whose existence means "this agent is installed"
declare -A AGENT_PROBE=(
  [kiro]="$HOME/.kiro"
  [claude]="$HOME/.claude"
  [codex]="$HOME/.codex"
  [cursor]="$HOME/.cursor"
)

log()  { printf '%s\n' "$*"; }
run()  { if [ "$DRY_RUN" -eq 1 ]; then log "  [dry-run] $*"; else eval "$@"; fi; }

usage() { sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//'; exit 0; }

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run)   DRY_RUN=1 ;;
    --uninstall) UNINSTALL=1 ;;
    --agents)    AGENTS_ARG="${2:-}"; shift ;;
    --agents=*)  AGENTS_ARG="${1#*=}" ;;
    -h|--help)   usage ;;
    *) log "Unknown option: $1" >&2; exit 2 ;;
  esac
  shift
done

# Resolve the agent list: explicit --agents, else auto-detect by probe dir.
resolve_agents() {
  local list=()
  if [ -n "$AGENTS_ARG" ]; then
    IFS=',' read -r -a list <<< "$AGENTS_ARG"
    for a in "${list[@]}"; do
      [ -n "${AGENT_DIR[$a]:-}" ] || { log "Unknown agent: $a (known: ${!AGENT_DIR[*]})" >&2; exit 2; }
    done
  else
    for a in "${!AGENT_PROBE[@]}"; do
      [ -d "${AGENT_PROBE[$a]}" ] && list+=("$a")
    done
  fi
  printf '%s\n' "${list[@]}" | sort
}

skill_names() { for d in "$SRC_SKILLS"/*/; do basename "$d"; done; }

do_uninstall() {
  local removed=0
  for a in $(resolve_agents); do
    local dir="${AGENT_DIR[$a]}"
    [ -d "$dir" ] || continue
    while IFS= read -r name; do
      local target="$dir/$name"
      if [ -f "$target/$MARKER" ]; then
        log "- removing $a skill: $target"
        run "rm -rf '$target'"
        removed=$((removed+1))
      fi
    done < <(skill_names)
  done
  if [ -d "$TOOLCHEST_HOME" ]; then
    log "- removing payload: $TOOLCHEST_HOME"
    run "rm -rf '$TOOLCHEST_HOME'"
  fi
  log ""
  log "Uninstall complete. Removed $removed skill install(s). Unrelated skills left untouched."
}

do_install() {
  local agents; agents="$(resolve_agents)"
  if [ -z "$agents" ]; then
    log "No supported agents detected (looked for: ${!AGENT_PROBE[*]})."
    log "Pass --agents kiro,claude,codex,cursor to force, or install an agent first."
    exit 1
  fi

  log "Toolchest home: $TOOLCHEST_HOME"
  log "Agents:         $(echo "$agents" | tr '\n' ' ')"
  log ""

  # 1) Install shared guide payload once.
  log "Installing shared guides -> $TOOLCHEST_HOME/prompts"
  run "mkdir -p '$TOOLCHEST_HOME'"
  run "rm -rf '$TOOLCHEST_HOME/prompts'"
  run "cp -R '$SRC_PROMPTS' '$TOOLCHEST_HOME/prompts'"

  local payload="$TOOLCHEST_HOME/prompts"
  local installed=0

  # 2) Install each skill into each agent's global skills dir, rewriting the
  #    plugin-root placeholder to the resolved payload path.
  for a in $agents; do
    local dir="${AGENT_DIR[$a]}"
    log "[$a] -> $dir"
    run "mkdir -p '$dir'"
    while IFS= read -r name; do
      local src="$SRC_SKILLS/$name"
      local target="$dir/$name"
      log "  + $name"
      run "rm -rf '$target'"
      run "cp -R '$src' '$target'"
      # Rewrite \${CLAUDE_PLUGIN_ROOT}/prompts -> <payload> so the global skill finds its guides.
      run "find '$target' -type f -name '*.md' -exec sed -i.bak 's#\${CLAUDE_PLUGIN_ROOT}/prompts#$payload#g' {} +"
      run "find '$target' -type f -name '*.bak' -delete"
      run "touch '$target/$MARKER'"
      installed=$((installed+1))
    done < <(skill_names)
  done

  log ""
  log "Installed $installed skill(s) across $(echo "$agents" | wc -w | tr -d ' ') agent(s)."
  log "Guides shared at: $payload"
  log "Re-run this script any time to update; use --uninstall to remove."
}

# macOS sed needs a backup-suffix arg to -i; the install uses -i.bak + delete,
# which is portable across GNU and BSD sed. (BSD treats '-i.bak' as the suffix;
# GNU treats it as suffix too.) No branch needed.

if [ ! -d "$SRC_SKILLS" ] || [ ! -d "$SRC_PROMPTS" ]; then
  log "Error: run this script from the repo root (expected $PLUGIN_DIR)." >&2
  exit 1
fi

if [ "$UNINSTALL" -eq 1 ]; then do_uninstall; else do_install; fi
