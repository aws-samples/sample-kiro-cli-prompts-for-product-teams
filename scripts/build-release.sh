#!/bin/sh
# Build the release assets for one tag, reproducibly, from a git commit:
#
#   scripts/build-release.sh <vX.Y.Z> <outdir> [<commit>]
#
# Writes <outdir>/product-team-ai-kit-<tag>.tar.gz, <outdir>/install.sh and
# <outdir>/checksums.txt (sha256sum format). The tarball holds only what the
# installer needs, under one top-level directory. `git archive` stamps every
# member with the commit time and gzip -n drops the name/timestamp, so the same
# commit always yields the same bytes (with the same gzip implementation).
# Used unchanged by .github/workflows/release.yml and by tests/run.sh.
set -eu

die() { printf 'build-release: error: %s\n' "$*" >&2; exit 1; }

sha256_line() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1"
  else
    shasum -a 256 "$1"
  fi
}

main() {
  [ $# -ge 2 ] || die "usage: build-release.sh <vX.Y.Z> <outdir> [<commit>]"
  tag=$1 out=$2 rev=${3:-HEAD}
  printf '%s\n' "$tag" | grep -Eq '^v[0-9]+\.[0-9]+\.[0-9]+$' || die "invalid tag: $tag"
  root=$(git rev-parse --show-toplevel) || die "not inside a git checkout"
  commit=$(git -C "$root" rev-parse --verify "$rev^{commit}") || die "unknown commit: $rev"
  name=product-team-ai-kit-$tag

  mkdir -p "$out"
  out=$(cd -P "$out" && pwd -P)
  rm -f "$out/$name.tar.gz" "$out/install.sh" "$out/checksums.txt"

  # Content the CLI installs (see kit/agents.map) plus the CLI and installer.
  set -- bin install.sh VERSION LICENSE kit prompts samples \
    CLAUDE.md .cursorrules .claude/agents .claude/skills .claude/settings.json \
    .kiro/steering .kiro/hooks.json
  git -C "$root" archive --format=tar --prefix="$name/" "$commit" -- "$@" | gzip -n -9 > "$out/$name.tar.gz"
  git -C "$root" show "$commit:install.sh" > "$out/install.sh"

  (cd "$out" && sha256_line "$name.tar.gz" && sha256_line install.sh) > "$out/checksums.txt"
  printf 'Built %s from %s\n' "$name" "$commit"
  cat "$out/checksums.txt"
}

main "$@"
