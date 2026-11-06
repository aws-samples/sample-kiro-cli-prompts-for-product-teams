#!/bin/sh
# Consistency check for the content the CLI ships (run in CI: `sh scripts/check.sh`).
#
# Fails if:
#   - kit/agents.map is malformed, names a missing source, or has an unsafe target
#   - a guide/template in prompts/ is not listed in @guides (or @samples), so a new
#     phase guide (e.g. Threat Modeling, PR #4) cannot silently miss the CLI
#   - the template copies in prompts/ and .kiro/steering/templates/ differ
#   - CLAUDE.md, .cursorrules or .claude/** reference a prompts/ file that does not exist
#   - a SKILL.md name does not match its directory, or a Kiro steering file has
#     invalid inclusion front matter
#   - CLAUDE.md and .cursorrules disagree on the invariants CONTRIBUTING.md lists
#     (Logo Gate check count, source minimum, naming convention, ScreenIndex placeholders)
#   - VERSION is not MAJOR.MINOR.PATCH
set -eu

LC_ALL=C
export LC_ALL
FAILS=0

fail() { printf 'FAIL: %s\n' "$*"; FAILS=$((FAILS + 1)); }
ok() { printf 'ok:   %s\n' "$*"; }

check_map() {
  _bad=$(awk -F'|' '
    NF == 0 || $0 ~ /^[[:space:]]*#/ {next}
    NF != 4 {printf "line %d: expected 4 fields\n", NR; next}
    $2 !~ /^(about|use|file|dir|block-md|block-hash|mdc)$/ {printf "line %d: unknown mode %s\n", NR, $2}
    $1 !~ /^@?[a-z0-9-]+$/ {printf "line %d: bad name %s\n", NR, $1}
    $1 ~ /^@/ && $2 == "use" {printf "line %d: groups cannot use groups\n", NR}
    ' kit/agents.map)
  if [ -n "$_bad" ]; then fail "kit/agents.map: $_bad"; else ok "kit/agents.map is well-formed"; fi

  cp kit/agents.map "$TMPF.map"
  _n=0
  while IFS='|' read -r who mode src tgt; do
    case $who in '' | '#'*) continue ;; esac
    _n=$((_n + 1))
    case $mode in
      about) continue ;;
      use) grep -q "^$src|" kit/agents.map || fail "$who uses undefined group $src"; continue ;;
      dir) [ -d "$src" ] || fail "$who: missing source directory $src" ;;
      *) [ -f "$src" ] || fail "$who: missing source file $src" ;;
    esac
    case "/$tgt/" in
      //* | */../* | */./*) fail "$who: unsafe target $tgt" ;;
    esac
    case $tgt in
      /* | *[!A-Za-z0-9._/\ -]*) fail "$who: unsafe target $tgt" ;;
    esac
  done < "$TMPF.map"
  ok "checked $_n agents.map entries"

  awk -F'|' 'NF == 4 && $0 !~ /^[[:space:]]*#/ && $1 !~ /^@/ && $2 == "about" {print $1}' kit/agents.map > "$TMPF.agents"
  while IFS= read -r a; do
    awk -F'|' -v a="$a" '$1 == a && $2 != "about" && $2 != "use"' kit/agents.map | grep -q . ||
      fail "agent $a writes no files"
  done < "$TMPF.agents"

  # Two entries for one target must be identical (agents may share AGENTS.md).
  _dup=$(awk -F'|' 'NF == 4 && $0 !~ /^[[:space:]]*#/ && $4 != "-" {
      k = $4; v = $2 "|" $3
      if ((k in s) && s[k] != v) print k
      s[k] = v }' kit/agents.map)
  if [ -n "$_dup" ]; then fail "conflicting entries for: $_dup"; else ok "no conflicting targets"; fi
}

check_guides_listed() {
  for f in prompts/*; do
    case $f in
      prompts/Sample_*) grep -q "^@samples|file|$f|" kit/agents.map || fail "$f is not listed in @samples" ;;
      *) grep -q "^@guides|file|$f|" kit/agents.map || fail "$f is not listed in @guides (kit/agents.map)" ;;
    esac
  done
  ok "every prompts/ file is listed in kit/agents.map"
}

check_templates() {
  for t in ProjectDashboard_Template.html ScreenIndex_Template.html; do
    if cmp -s "prompts/$t" ".kiro/steering/templates/$t"; then
      ok "$t identical in prompts/ and .kiro/steering/templates/"
    else
      fail "$t differs between prompts/ and .kiro/steering/templates/ (they must be byte-identical)"
    fi
  done
}

check_prompt_refs() {
  find CLAUDE.md .cursorrules .claude -type f \( -name '*.md' -o -name .cursorrules \) > "$TMPF.files"
  : > "$TMPF.raw"
  bt=$(printf '\140')
  while IFS= read -r f; do
    grep -o "${bt}prompts/[A-Za-z0-9_. -]*${bt}" "$f" >> "$TMPF.raw" || true
  done < "$TMPF.files"
  tr -d "$bt" < "$TMPF.raw" | sort -u > "$TMPF.refs"
  _n=0
  while IFS= read -r r; do
    _n=$((_n + 1))
    [ -f "$r" ] || fail "referenced but missing: $r"
  done < "$TMPF.refs"
  ok "$_n prompts/ references in CLAUDE.md, .cursorrules, .claude/ resolve"
}

check_skills() {
  for s in .claude/skills/*/SKILL.md; do
    d=$(basename "$(dirname "$s")")
    n=$(sed -n '2,10s/^name: *//p' "$s" | sed -n '1p')
    [ "$(sed -n '1p' "$s")" = "---" ] || fail "$s: missing front matter"
    [ "$n" = "$d" ] || fail "$s: name '$n' does not match directory '$d'"
    sed -n '2,10p' "$s" | grep -q '^description: ..' || fail "$s: missing description"
  done
  ok "skill front matter"
}

check_steering() {
  for s in .kiro/steering/*.md; do
    [ "$(sed -n '1p' "$s")" = "---" ] || { fail "$s: steering front matter must be the first line"; continue; }
    inc=$(sed -n '2,6s/^inclusion: *//p' "$s" | sed -n '1p')
    case $inc in
      always | manual | auto) ;;
      fileMatch) sed -n '2,6p' "$s" | grep -q '^fileMatchPattern:' || fail "$s: fileMatch without fileMatchPattern" ;;
      *) fail "$s: invalid inclusion '$inc'" ;;
    esac
  done
  ok "Kiro steering front matter"
}

check_invariants() {
  for v in 'all 5 checks' '120+ sources' '[Type]_[Product]_[YYYY-MM-DD].html' \
    '[PRODUCT_NAME]' '[PRODUCT_SLUG]' '[CUSTOMER_LOGO]' '[BRAND_PRIMARY]' '[BRAND_SECONDARY]' \
    '[BRAND_ACCENT]' '[DATE]' '[PROGRESS_PERCENT]' '[SCREEN_COUNT]' '[SCREEN_CARDS]'; do
    for f in CLAUDE.md .cursorrules; do
      grep -qF -- "$v" "$f" || fail "$f is missing shared invariant: $v"
    done
  done
  ok "CLAUDE.md and .cursorrules agree on the shared invariants"
}

main() {
  cd "$(dirname "$0")/.."
  TMPF=$(mktemp "${TMPDIR:-/tmp}/ptak-check.XXXXXX")
  trap 'rm -f "$TMPF" "$TMPF".*' EXIT
  grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$' VERSION || fail "VERSION must be MAJOR.MINOR.PATCH"
  check_map
  check_guides_listed
  check_templates
  check_prompt_refs
  check_skills
  check_steering
  check_invariants
  if [ "$FAILS" -gt 0 ]; then
    printf '\n%d check(s) failed. See CONTRIBUTING.md -> "Editing the workflow content".\n' "$FAILS"
    exit 1
  fi
  printf '\nAll content checks passed.\n'
}

main "$@"
