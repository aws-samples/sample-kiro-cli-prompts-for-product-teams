#!/bin/sh
# Release guards, run by .github/workflows/release.yml before anything is built:
#
#   scripts/check-release-tag.sh <tag>
#
#   1. <tag> matches ^v[0-9]+\.[0-9]+\.[0-9]+$ (no pre-release suffixes).
#   2. The VERSION file at the tagged commit equals <tag> without the "v",
#      so a release can never ship a CLI that reports a different version.
#   3. The tagged commit is reachable from main (PTAK_MAIN_REF, default
#      origin/main), so only merged, reviewed code is released.
set -eu

die() { printf 'check-release-tag: FAIL: %s\n' "$*" >&2; exit 1; }

main() {
  [ $# -eq 1 ] || die "usage: check-release-tag.sh <tag>"
  tag=$1
  main_ref=${PTAK_MAIN_REF:-origin/main}

  printf '%s\n' "$tag" | grep -Eq '^v[0-9]+\.[0-9]+\.[0-9]+$' ||
    die "tag '$tag' is not of the form vMAJOR.MINOR.PATCH (pre-release tags are not supported)"
  echo "ok: tag format $tag"

  commit=$(git rev-parse --verify --quiet "refs/tags/$tag^{commit}") || die "tag $tag does not exist locally"
  git cat-file -e "$commit:VERSION" 2>/dev/null || die "VERSION file missing at $tag"
  file_version=$(git show "$commit:VERSION" | sed -n '1p')
  [ "v$file_version" = "$tag" ] || die "VERSION file says '$file_version' but the tag is '$tag'; bump VERSION and re-tag"
  echo "ok: VERSION $file_version matches"

  git rev-parse --verify --quiet "$main_ref^{commit}" >/dev/null || die "cannot resolve $main_ref (fetch main first)"
  git merge-base --is-ancestor "$commit" "$main_ref" || die "tag $tag ($commit) is not on $main_ref"
  echo "ok: $commit is reachable from $main_ref"
}

main "$@"
