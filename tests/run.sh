#!/bin/sh
# Test suite for bin/product-team-ai-kit, install.sh and the release scripts.
# Plain POSIX sh, no test framework, fully offline.
#
#   sh tests/run.sh [shell]      # e.g. sh tests/run.sh dash ; sh tests/run.sh bash
#
# The scripts under test are executed with the given shell (default: sh).
# Installer and release tests build real release assets from git HEAD, so
# commit your changes before running them locally.
set -u

SH=${1:-${TEST_SHELL:-sh}}
ROOT=$(cd -P "$(dirname "$0")/.." && pwd -P)
CLI=$ROOT/bin/product-team-ai-kit
LC_ALL=C
export LC_ALL
PASS=0
FAIL=0
FAILED=
T=$(mktemp -d "${TMPDIR:-/tmp}/ptak-test.XXXXXX")
trap 'chmod -R u+w "$T" 2>/dev/null; rm -rf "$T"' EXIT
VERSION=$(sed -n '1p' "$ROOT/VERSION")

# Never let tests see the developer's real install locations.
HOME=$T/home
export HOME
unset XDG_DATA_HOME PTAK_BIN_DIR PTAK_VERSION PTAK_REF PTAK_INSECURE_SKIP_VERIFY PTAK_BASE_URL PTAK_MODIFY_PATH 2>/dev/null || true
mkdir -p "$HOME"

# ---- helpers ---------------------------------------------------------------
CUR=
begin() { CUR=$1; }
ok() { PASS=$((PASS + 1)); }
bad() {
  FAIL=$((FAIL + 1))
  FAILED="$FAILED
  - $CUR: $*"
  printf '    FAIL [%s] %s\n' "$CUR" "$*"
  if [ -n "${OUT:-}" ]; then printf '%s\n' "$OUT" | sed 's/^/      | /' | tail -n 15; fi
}
# run <cmd...>: capture combined output in OUT and exit status in RC
run() { OUT=$("$@" 2>&1); RC=$?; }
cli() { run "$SH" "$CLI" "$@"; }
expect_rc() { if [ "$RC" = "$1" ]; then ok; else bad "expected exit $1, got $RC"; fi; }
expect_out() { if printf '%s\n' "$OUT" | grep -qF -- "$1"; then ok; else bad "output lacks: $1"; fi; }
expect_file() { if [ -f "$1" ]; then ok; else bad "missing file: ${1#"$T"/}"; fi; }
expect_absent() { if [ ! -e "$1" ] && [ ! -L "$1" ]; then ok; else bad "should not exist: ${1#"$T"/}"; fi; }
expect_grep() { if grep -qF -- "$2" "$1" 2>/dev/null; then ok; else bad "${1#"$T"/} lacks: $2"; fi; }
expect_empty_dir() {
  if [ -z "$(find "$1" -mindepth 1 -print 2>/dev/null | sed -n '1p')" ]; then ok; else bad "dir not empty: ${1#"$T"/}"; fi
}
tree_sum() { (cd "$1" && find . -type f | sort | while IFS= read -r f; do cksum "$f"; done); }
fresh() { _d=$T/p/$1; rm -rf "$_d"; mkdir -p "$_d"; printf '%s\n' "$_d"; }
count_grep() { grep -cF -- "$2" "$1" 2>/dev/null || true; }

# A private copy of the kit, so tests can change its content or map.
kit_copy() {
  _k=$T/kits/$1
  rm -rf "$_k"
  mkdir -p "$_k"
  (cd "$ROOT" && tar -cf - bin install.sh VERSION LICENSE kit prompts samples CLAUDE.md .cursorrules \
    .claude/agents .claude/skills .claude/settings.json .kiro/steering .kiro/hooks.json) | (cd "$_k" && tar -xf -)
  printf '%s\n' "$_k"
}

# ---- CLI: basics -----------------------------------------------------------
begin help-version
cli --help; expect_rc 0; expect_out "Usage: product-team-ai-kit"
cli --version; expect_rc 0; expect_out "product-team-ai-kit $VERSION"
cli; expect_rc 2; expect_out "no agent given"

begin list
cli --list; expect_rc 0
for a in claude kiro cursor codex copilot gemini windsurf; do expect_out "  $a  -  "; done
cli --list --agent kiro; expect_rc 0; expect_out ".kiro/hooks.json"

begin usage-errors
cli --agent nope --dir "$(fresh u1)"; expect_rc 2; expect_out "unknown agent: nope"
cli --agent 'Bad!'; expect_rc 2; expect_out "invalid agent name"
cli --bogus; expect_rc 2; expect_out "unknown option: --bogus"
cli --agent; expect_rc 2

# ---- CLI: every agent ------------------------------------------------------
check_agent() {
  _a=$1
  shift
  begin "agent-$_a"
  _d=$(fresh "agent-$_a")
  cli --agent "$_a" --dir "$_d"; expect_rc 0; expect_out "created"
  for _f in "$@" .gitignore .product-team-ai-kit.json; do expect_file "$_d/$_f"; done
  expect_grep "$_d/.product-team-ai-kit.json" "\"agents\": [\"$_a\"]"
  expect_grep "$_d/.product-team-ai-kit.json" "\"version\": \"$VERSION\""
  _before=$(tree_sum "$_d")
  cli --agent "$_a" --dir "$_d"; expect_rc 0; expect_out "Already up to date"
  if [ "$_before" = "$(tree_sum "$_d")" ]; then ok; else bad "second run changed files"; fi
}
check_agent claude CLAUDE.md .claude/agents/prd.md .claude/agents/screen-builder.md \
  .claude/skills/product-prd/SKILL.md .claude/skills/regenerate-screen-index/SKILL.md \
  .claude/settings.json prompts/Claude_Code_Workflow.md prompts/ScreenIndex_Template.html
check_agent kiro .kiro/steering/product-workflow.md .kiro/steering/specialist-prd.md \
  .kiro/steering/templates/ScreenIndex_Template.html .kiro/hooks.json
expect_absent "$T/p/agent-kiro/prompts"
check_agent cursor .cursor/rules/product-team-ai-kit.mdc prompts/PRD_Creation_Guide.md
if [ "$(sed -n '1p' "$T/p/agent-cursor/.cursor/rules/product-team-ai-kit.mdc")" = "---" ]; then ok; else bad "mdc lacks front matter"; fi
expect_grep "$T/p/agent-cursor/.cursor/rules/product-team-ai-kit.mdc" "alwaysApply: true"
check_agent codex AGENTS.md .agents/skills/product-prd/SKILL.md prompts/Orchestrator.md
check_agent copilot .github/copilot-instructions.md prompts/Shared_Standards.md
check_agent gemini GEMINI.md prompts/Handoff_Schema.md
check_agent windsurf AGENTS.md .agents/skills/product-research/SKILL.md prompts/Deep_Research_Agent.md
expect_grep "$T/p/agent-claude/CLAUDE.md" "<!-- BEGIN product-team-ai-kit"
expect_grep "$T/p/agent-claude/.gitignore" "# BEGIN product-team-ai-kit"
expect_grep "$T/p/agent-claude/.gitignore" "documents/lib/"

begin multi-agent
d=$(fresh multi)
cli --agent claude,kiro --agent codex --agent kiro --dir "$d"; expect_rc 0
expect_file "$d/CLAUDE.md"; expect_file "$d/.kiro/hooks.json"; expect_file "$d/AGENTS.md"
expect_grep "$d/.product-team-ai-kit.json" '"agents": ["claude", "codex", "kiro"]'
cli --agent windsurf --dir "$d"; expect_rc 0
expect_grep "$d/.product-team-ai-kit.json" '"agents": ["claude", "codex", "kiro", "windsurf"]'
if [ "$(count_grep "$d/AGENTS.md" '<!-- BEGIN product-team-ai-kit')" = 1 ]; then ok; else bad "AGENTS.md has duplicate blocks"; fi

begin samples
d=$(fresh samples)
cli --agent gemini --include-samples --dir "$d"; expect_rc 0
expect_file "$d/samples/teenfit.css"; expect_file "$d/prompts/Sample_Screen_Dashboard.html"

# ---- CLI: safety -----------------------------------------------------------
begin dry-run
d=$(fresh dry)
cli --agent claude,kiro --dry-run --dir "$d"; expect_rc 0
expect_out "would create"; expect_out "Dry run, nothing written"
expect_empty_dir "$d"

begin conflict
d=$(fresh conflict)
mkdir -p "$d/.claude"; printf 'mine\n' > "$d/.claude/settings.json"
cli --agent claude --dir "$d"; expect_rc 3; expect_out "CONFLICT   .claude/settings.json"
expect_absent "$d/CLAUDE.md"; expect_absent "$d/.product-team-ai-kit.json"
expect_grep "$d/.claude/settings.json" mine
cli --agent claude --dir "$d" --dry-run; expect_rc 3
cli --agent claude --dir "$d" --force; expect_rc 0; expect_out "overwrite  .claude/settings.json"
if cmp -s "$d/.claude/settings.json" "$ROOT/.claude/settings.json"; then ok; else bad "--force did not overwrite"; fi

begin managed-block
d=$(fresh block)
printf '# My project\nmy own notes' > "$d/CLAUDE.md"
printf 'node_modules/\n' > "$d/.gitignore"
cli --agent claude --dir "$d"; expect_rc 0; expect_out "append     CLAUDE.md (managed block)"
if [ "$(sed -n '1p' "$d/CLAUDE.md")" = "# My project" ]; then ok; else bad "user header not preserved"; fi
expect_grep "$d/CLAUDE.md" "my own notes"
expect_grep "$d/.gitignore" "node_modules/"
# hand-edit inside the block; a re-run restores it and keeps text outside
awk '{print} /^<!-- BEGIN product-team-ai-kit/ {print "EDITED INSIDE"}' "$d/CLAUDE.md" > "$d/c.tmp" && mv "$d/c.tmp" "$d/CLAUDE.md"
printf 'more notes after\n' >> "$d/CLAUDE.md"
cli --agent claude --dir "$d"; expect_rc 0; expect_out "update     CLAUDE.md (managed block)"
if grep -q "EDITED INSIDE" "$d/CLAUDE.md"; then bad "block not restored"; else ok; fi
expect_grep "$d/CLAUDE.md" "my own notes"; expect_grep "$d/CLAUDE.md" "more notes after"
if [ "$(count_grep "$d/CLAUDE.md" '<!-- BEGIN product-team-ai-kit')" = 1 ]; then ok; else bad "duplicate block"; fi
cli --agent claude --dir "$d"; expect_rc 0; expect_out "Already up to date"

begin malformed-block
d=$(fresh malformed)
printf '<!-- BEGIN product-team-ai-kit\nno end marker\n' > "$d/AGENTS.md"
cli --agent codex --dir "$d" --force; expect_rc 3; expect_out "malformed managed block"

begin kit-upgrade
k=$(kit_copy upg)
d=$(fresh upg)
run "$SH" "$k/bin/product-team-ai-kit" --agent claude --dir "$d"; expect_rc 0
printf '\nNew guidance in a later kit version.\n' >> "$k/prompts/PRFAQ_Guide.md"
printf '\nNew summary line.\n' >> "$k/CLAUDE.md"
run "$SH" "$k/bin/product-team-ai-kit" --agent claude --dir "$d"; expect_rc 0
expect_out "update     prompts/PRFAQ_Guide.md"; expect_out "update     CLAUDE.md (managed block)"
expect_grep "$d/CLAUDE.md" "New summary line."
printf 'local edit\n' >> "$d/prompts/PRFAQ_Guide.md"
printf '\nEven newer.\n' >> "$k/prompts/PRFAQ_Guide.md"
run "$SH" "$k/bin/product-team-ai-kit" --agent claude --dir "$d"; expect_rc 3
expect_out "CONFLICT   prompts/PRFAQ_Guide.md"

begin foreign-manifest
d=$(fresh foreign)
printf '{"something": "else"}\n' > "$d/.product-team-ai-kit.json"
cli --agent gemini --dir "$d"; expect_rc 3; expect_out "not written by product-team-ai-kit"

begin dir-errors
cli --agent claude --dir "$T/does-not-exist"; expect_rc 4
printf 'x' > "$T/afile"
cli --agent claude --dir "$T/afile"; expect_rc 4
if [ "$(id -u)" != 0 ]; then
  d=$(fresh ro); chmod 555 "$d"
  cli --agent claude --dir "$d"; expect_rc 4; expect_out "not writable"
  chmod 755 "$d"
fi

begin symlink-escape
d=$(fresh sym); out=$(fresh sym-outside)
ln -s "$out" "$d/.claude"
cli --agent claude --dir "$d" --force; expect_rc 4; expect_out "symlink"
expect_empty_dir "$out"
d=$(fresh sym2)
printf 'target\n' > "$out/victim.md"
ln -s "$out/victim.md" "$d/GEMINI.md"
cli --agent gemini --dir "$d" --force; expect_rc 4
if [ "$(cat "$out/victim.md")" = target ]; then ok; else bad "wrote through a symlink"; fi

begin path-traversal
k=$(kit_copy trav)
printf 'gemini|file|VERSION|../escaped.txt\n' >> "$k/kit/agents.map"
d=$(fresh trav)
run "$SH" "$k/bin/product-team-ai-kit" --agent gemini --dir "$d"; expect_rc 4; expect_out "unsafe target path"
expect_absent "$T/p/escaped.txt"
expect_empty_dir "$d"
k=$(kit_copy trav2)
printf 'gemini|file|../../etc/passwd|x.txt\n' >> "$k/kit/agents.map"
run "$SH" "$k/bin/product-team-ai-kit" --agent gemini --dir "$d"; expect_rc 1; expect_out "unsafe source path"
k=$(kit_copy trav3)
printf 'gemini|file|VERSION|/tmp/abs.txt\n' >> "$k/kit/agents.map"
run "$SH" "$k/bin/product-team-ai-kit" --agent gemini --dir "$d"; expect_rc 4

begin content-check
run "$SH" "$ROOT/scripts/check.sh"; expect_rc 0; expect_out "All content checks passed"

# ---- release build ---------------------------------------------------------
if ! git -C "$ROOT" rev-parse --verify HEAD >/dev/null 2>&1; then
  printf 'SKIP installer/release tests: %s is not a git checkout\n' "$ROOT"
else
  REL=$T/rel
  TAG=v$VERSION
  begin release-build
  run "$SH" "$ROOT/scripts/build-release.sh" "$TAG" "$REL/$TAG"; expect_rc 0
  for f in "product-team-ai-kit-$TAG.tar.gz" install.sh checksums.txt; do expect_file "$REL/$TAG/$f"; done
  printf '%s\n' "$TAG" > "$REL/latest"
  run "$SH" "$ROOT/scripts/build-release.sh" "$TAG" "$T/rel-again"; expect_rc 0
  if cmp -s "$REL/$TAG/checksums.txt" "$T/rel-again/checksums.txt"; then ok; else bad "build is not reproducible"; fi
  top=$(tar -tzf "$REL/$TAG/product-team-ai-kit-$TAG.tar.gz" | cut -d/ -f1 | sort -u)
  if [ "$top" = "product-team-ai-kit-$TAG" ]; then ok; else bad "tarball top-level is '$top'"; fi
  run "$SH" "$ROOT/scripts/build-release.sh" v1.2 "$T/rel-bad"; expect_rc 1

  inst() { run env "$@" "$SH" "$ROOT/install.sh"; }
  begin install-ok
  H=$T/h1
  inst HOME="$H" PTAK_BASE_URL="file://$REL" PTAK_VERSION="$TAG" PATH="/usr/bin:/bin"
  expect_rc 0; expect_out "Verified SHA-256"; expect_out "is not on your PATH"
  if [ -L "$H/.local/bin/product-team-ai-kit" ]; then ok; else bad "command link missing"; fi
  expect_file "$H/.local/share/product-team-ai-kit/$TAG/bin/product-team-ai-kit"
  run "$SH" "$H/.local/bin/product-team-ai-kit" --version; expect_rc 0; expect_out "product-team-ai-kit $VERSION"
  d=$(fresh via-link)
  run "$SH" "$H/.local/bin/product-team-ai-kit" --agent claude --dir "$d"; expect_rc 0; expect_file "$d/CLAUDE.md"
  inst HOME="$H" PTAK_BASE_URL="file://$REL" PTAK_VERSION="$TAG"; expect_rc 0   # re-run is fine

  begin install-latest-and-custom-dirs
  H=$T/h2
  inst HOME="$H" XDG_DATA_HOME="$H/data" PTAK_BIN_DIR="$H/mybin" PTAK_BASE_URL="file://$REL" PATH="$H/mybin:/usr/bin:/bin"
  expect_rc 0; expect_out "Installed product-team-ai-kit $VERSION ($TAG)"
  if printf '%s\n' "$OUT" | grep -q "not on your PATH"; then bad "PATH hint shown although on PATH"; else ok; fi
  expect_file "$H/data/product-team-ai-kit/$TAG/VERSION"
  if [ -L "$H/mybin/product-team-ai-kit" ]; then ok; else bad "custom bin link missing"; fi

  begin install-checksum-mismatch
  cp -R "$REL" "$T/rel-bad"
  printf 'x' >> "$T/rel-bad/$TAG/product-team-ai-kit-$TAG.tar.gz"
  H=$T/h3
  inst HOME="$H" PTAK_BASE_URL="file://$T/rel-bad" PTAK_VERSION="$TAG"
  if [ "$RC" != 0 ]; then ok; else bad "mismatch did not abort"; fi
  expect_out "SHA-256 mismatch"; expect_absent "$H/.local/share/product-team-ai-kit"; expect_absent "$H/.local/bin/product-team-ai-kit"

  begin install-missing-checksums
  cp -R "$REL" "$T/rel-nock"; rm -f "$T/rel-nock/$TAG/checksums.txt"
  H=$T/h4
  inst HOME="$H" PTAK_BASE_URL="file://$T/rel-nock" PTAK_VERSION="$TAG"
  if [ "$RC" != 0 ]; then ok; else bad "missing checksums did not abort"; fi
  expect_out "checksums.txt is missing"; expect_absent "$H/.local/share/product-team-ai-kit"

  begin install-unlisted-asset
  cp -R "$REL" "$T/rel-unl"; printf '%s  other.tar.gz\n' 0000 > "$T/rel-unl/$TAG/checksums.txt"
  inst HOME="$T/h4b" PTAK_BASE_URL="file://$T/rel-unl" PTAK_VERSION="$TAG"
  if [ "$RC" != 0 ]; then ok; else bad "unlisted asset did not abort"; fi
  expect_out "not listed in checksums.txt"

  begin install-archive-with-symlink
  mkdir -p "$T/evil/product-team-ai-kit-v9.9.9/bin" "$T/rel-evil/v9.9.9"
  ln -s /etc/passwd "$T/evil/product-team-ai-kit-v9.9.9/bin/product-team-ai-kit"
  (cd "$T/evil" && tar -cf - product-team-ai-kit-v9.9.9 | gzip -n > "$T/rel-evil/v9.9.9/product-team-ai-kit-v9.9.9.tar.gz")
  (cd "$T/rel-evil/v9.9.9" && { sha256sum product-team-ai-kit-v9.9.9.tar.gz 2>/dev/null || shasum -a 256 product-team-ai-kit-v9.9.9.tar.gz; } > checksums.txt)
  inst HOME="$T/h5" PTAK_BASE_URL="file://$T/rel-evil" PTAK_VERSION=v9.9.9
  if [ "$RC" != 0 ]; then ok; else bad "symlink archive accepted"; fi
  expect_out "links or special files"

  begin install-input-validation
  inst HOME="$T/h6" PTAK_BASE_URL="file://$REL" PTAK_VERSION=v1.2
  if [ "$RC" != 0 ]; then ok; else bad "bad version accepted"; fi; expect_out "invalid version"
  inst HOME="$T/h6" PTAK_BASE_URL="file://$REL" PTAK_VERSION=v1.2.3-rc1
  if [ "$RC" != 0 ]; then ok; else bad "pre-release accepted"; fi
  inst HOME="$T/h6" PTAK_REF=main
  if [ "$RC" != 0 ]; then ok; else bad "PTAK_REF without skip accepted"; fi; expect_out "PTAK_INSECURE_SKIP_VERIFY=1"
  inst HOME="$T/h6" PTAK_INSECURE_SKIP_VERIFY=1 PTAK_BASE_URL="file://$REL" PTAK_VERSION="$TAG"
  if [ "$RC" != 0 ]; then ok; else bad "skip-verify for a release accepted"; fi
  inst HOME="$T/h6" PTAK_REF='../x' PTAK_INSECURE_SKIP_VERIFY=1
  if [ "$RC" != 0 ]; then ok; else bad "bad PTAK_REF accepted"; fi; expect_out "invalid PTAK_REF"
  inst HOME="$T/h6" PTAK_BASE_URL="http://example.invalid"
  if [ "$RC" != 0 ]; then ok; else bad "http URL accepted"; fi; expect_out "refusing non-HTTPS"
  mkdir -p "$T/h7/.local/bin"; printf 'not a link\n' > "$T/h7/.local/bin/product-team-ai-kit"
  inst HOME="$T/h7" PTAK_BASE_URL="file://$REL" PTAK_VERSION="$TAG"
  if [ "$RC" != 0 ]; then ok; else bad "replaced a non-symlink command"; fi; expect_out "is not a symlink"
  run "$SH" "$ROOT/install.sh" --bogus
  if [ "$RC" != 0 ]; then ok; else bad "unknown installer flag accepted"; fi

  begin upgrade-and-self-update
  NEXT=v99.0.0
  run "$SH" "$ROOT/scripts/build-release.sh" "$NEXT" "$REL/$NEXT"; expect_rc 0
  H=$T/h1
  printf '%s\n' "$TAG" > "$REL/latest"
  run env HOME="$H" PTAK_BASE_URL="file://$REL" "$SH" "$H/.local/bin/product-team-ai-kit" self-update
  expect_rc 0; expect_out "is up to date"
  printf '%s\n' "$NEXT" > "$REL/latest"
  run env HOME="$H" PTAK_BASE_URL="file://$REL" "$SH" "$H/.local/bin/product-team-ai-kit" self-update
  expect_rc 0; expect_out "Upgrading product-team-ai-kit v$VERSION -> $NEXT"
  case $(readlink "$H/.local/bin/product-team-ai-kit") in
    */product-team-ai-kit/$NEXT/bin/product-team-ai-kit) ok ;;
    *) bad "link not switched to $NEXT" ;;
  esac
  expect_absent "$H/.local/share/product-team-ai-kit/$TAG"
  cp "$REL/$NEXT/install.sh" "$T/install.orig"; printf '# tampered\n' >> "$REL/$NEXT/install.sh"
  run env HOME="$H" PTAK_BASE_URL="file://$REL" "$SH" "$H/.local/bin/product-team-ai-kit" self-update
  if [ "$RC" != 0 ]; then ok; else bad "tampered install.sh accepted"; fi; expect_out "install.sh checksum mismatch"
  cp "$T/install.orig" "$REL/$NEXT/install.sh"

  begin modify-path
  H=$T/h8
  inst HOME="$H" SHELL=/bin/zsh ZDOTDIR="$H" PTAK_MODIFY_PATH=1 PTAK_BASE_URL="file://$REL" PTAK_VERSION="$TAG" PATH=/usr/bin:/bin
  expect_rc 0; expect_grep "$H/.zshrc" "export PATH=\"$H/.local/bin:\$PATH\""
  inst HOME="$H" SHELL=/bin/zsh ZDOTDIR="$H" PTAK_MODIFY_PATH=1 PTAK_BASE_URL="file://$REL" PTAK_VERSION="$TAG" PATH=/usr/bin:/bin
  if [ "$(count_grep "$H/.zshrc" "$H/.local/bin")" = 1 ]; then ok; else bad "PATH line duplicated"; fi
  inst HOME="$T/h9" PTAK_BASE_URL="file://$REL" PTAK_VERSION="$TAG" PATH=/usr/bin:/bin
  expect_absent "$T/h9/.bashrc"; expect_absent "$T/h9/.zshrc"; expect_absent "$T/h9/.profile"

  begin uninstall
  H=$T/h2
  run env HOME="$H" XDG_DATA_HOME="$H/data" PTAK_BIN_DIR="$H/mybin" "$SH" "$ROOT/install.sh" --uninstall
  expect_rc 0; expect_absent "$H/mybin/product-team-ai-kit"; expect_absent "$H/data/product-team-ai-kit"
  H=$T/h1
  run env HOME="$H" "$SH" "$H/.local/bin/product-team-ai-kit" uninstall
  expect_rc 0; expect_absent "$H/.local/bin/product-team-ai-kit"; expect_absent "$H/.local/share/product-team-ai-kit"
  expect_file "$T/p/via-link/CLAUDE.md"

  # ---- release guards --------------------------------------------------------
  begin release-guards
  G=$T/guard
  git init -q "$G"
  gitc() { git -C "$G" -c user.name=test -c user.email=test@example.invalid -c commit.gpgsign=false -c tag.gpgsign=false "$@"; }
  printf '0.1.0\n' > "$G/VERSION"
  gitc add VERSION; gitc commit -q -m one; gitc branch -M main
  gitc tag v0.1.0; gitc tag v0.2.0; gitc tag v1.2; gitc tag v1.2.3-rc1
  gitc checkout -q -b side; printf '0.1.1\n' > "$G/VERSION"; gitc commit -q -am side; gitc tag v0.1.1
  guard() { OUT=$(cd "$G" && PTAK_MAIN_REF=main "$SH" "$ROOT/scripts/check-release-tag.sh" "$1" 2>&1); RC=$?; }
  guard v0.1.0; expect_rc 0; expect_out "reachable from main"
  guard v0.2.0; expect_rc 1; expect_out "VERSION file says '0.1.0'"
  guard v1.2; expect_rc 1; expect_out "not of the form"
  guard v1.2.3-rc1; expect_rc 1; expect_out "not of the form"
  guard v0.1.1; expect_rc 1; expect_out "is not on main"
  guard v7.7.7; expect_rc 1; expect_out "does not exist"
fi

printf '\n%s: %d passed, %d failed (shell: %s)\n' "tests/run.sh" "$PASS" "$FAIL" "$SH"
if [ "$FAIL" -gt 0 ]; then
  printf 'Failures:%s\n' "$FAILED"
  exit 1
fi
