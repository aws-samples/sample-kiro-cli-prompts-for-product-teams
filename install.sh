#!/bin/sh
# install.sh: install the product-team-ai-kit command from a GitHub release.
#
#   curl -fsSL https://github.com/aws-samples/sample-kiro-cli-prompts-for-product-teams/releases/latest/download/install.sh | sh
#
# What it does (read it first: it is short):
#   1. Resolves the latest release tag from the releases/latest redirect (no API
#      call, no token), or uses PTAK_VERSION=vX.Y.Z if you set it.
#   2. Downloads product-team-ai-kit-<tag>.tar.gz and checksums.txt from that
#      release over HTTPS and verifies the SHA-256. Any mismatch, or a missing
#      checksums.txt, aborts the install.
#   3. Unpacks it to ${XDG_DATA_HOME:-$HOME/.local/share}/product-team-ai-kit/<tag>
#      and links ${PTAK_BIN_DIR:-$HOME/.local/bin}/product-team-ai-kit to it.
#   4. Never uses sudo and never edits your shell rc files unless you set
#      PTAK_MODIFY_PATH=1. Re-run it to upgrade; `--uninstall` removes it.
#
# Environment:
#   PTAK_VERSION=vX.Y.Z         install a specific release instead of the latest
#   PTAK_BIN_DIR=<dir>          where to put the command link (default ~/.local/bin)
#   XDG_DATA_HOME=<dir>         data root (default ~/.local/share)
#   PTAK_MODIFY_PATH=1          append a PATH line to your shell rc file
#   PTAK_BASE_URL=<url>         release mirror laid out as <url>/<tag>/<asset> and
#                               <url>/latest; https:// or file:// (for offline tests)
#   Development only, NOT verified:
#   PTAK_REF=<branch|sha> PTAK_INSECURE_SKIP_VERIFY=1
#                               install an unreleased git ref from codeload.github.com
#
# Source: https://github.com/aws-samples/sample-kiro-cli-prompts-for-product-teams
# License: MIT-0
set -eu

NAME=product-team-ai-kit
REPO=aws-samples/sample-kiro-cli-prompts-for-product-teams

say() { printf '%s\n' "$*"; }
warn() { printf '%s: warning: %s\n' "$NAME-install" "$*" >&2; }
die() { printf '%s: error: %s\n' "$NAME-install" "$*" >&2; exit 1; }

usage() {
  cat <<'EOF'
Usage: install.sh [--uninstall | --help]

Installs product-team-ai-kit from the latest GitHub release (or PTAK_VERSION),
verifying the SHA-256 checksum. See the comments at the top of this file.
EOF
}

need() {
  for _t in "$@"; do
    command -v "$_t" >/dev/null 2>&1 || die "required tool not found: $_t"
  done
}

pick_tools() {
  need tar mkdir ln mv rm cp mktemp awk sed grep dirname
  if command -v curl >/dev/null 2>&1; then
    DL=curl
  elif command -v wget >/dev/null 2>&1; then
    DL=wget
  else
    die "need curl or wget to download the kit"
  fi
}

sha256_of() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    die "need sha256sum or shasum to verify the download"
  fi
}

fetch() {
  case $1 in
    https://*) ;;
    file://*) cp "${1#file://}" "$2" 2>/dev/null; return ;;
    *) die "refusing non-HTTPS URL: $1" ;;
  esac
  if [ "$DL" = curl ]; then
    curl --proto '=https' --proto-redir '=https' --tlsv1.2 -fsSL -o "$2" "$1"
  else
    wget --https-only -q -O "$2" "$1"
  fi
}

latest_tag() {
  if [ -n "${PTAK_BASE_URL:-}" ]; then
    fetch "$PTAK_BASE_URL/latest" "$TMP/latest" || die "cannot read $PTAK_BASE_URL/latest"
    sed -n '1p' "$TMP/latest"
    return
  fi
  _u=https://github.com/$REPO/releases/latest
  if [ "$DL" = curl ]; then
    _loc=$(curl --proto '=https' --tlsv1.2 -fsS -o /dev/null -w '%{redirect_url}' "$_u") ||
      die "cannot reach $_u"
  else
    _loc=$(wget --https-only --max-redirect=0 -S -O /dev/null "$_u" 2>&1 |
      sed -n 's/^ *[Ll]ocation: *//p' | tr -d '\r' | sed -n '1p')
  fi
  case $_loc in
    */releases/tag/*) printf '%s\n' "${_loc##*/releases/tag/}" ;;
    *) die "no GitHub release of $REPO has been published yet (see the README for the development install)" ;;
  esac
}

valid_tag() {
  printf '%s\n' "$1" | grep -Eq '^v[0-9]+\.[0-9]+\.[0-9]+$'
}

asset_url() {
  if [ -n "${PTAK_BASE_URL:-}" ]; then
    printf '%s/%s/%s\n' "$PTAK_BASE_URL" "$1" "$2"
  else
    printf 'https://github.com/%s/releases/download/%s/%s\n' "$REPO" "$1" "$2"
  fi
}

paths_init() {
  [ -n "${HOME:-}" ] || die "HOME is not set"
  case $HOME in /*) ;; *) die "HOME must be an absolute path" ;; esac
  _xdg=${XDG_DATA_HOME:-}
  case $_xdg in /*) ;; *) _xdg=$HOME/.local/share ;; esac
  DATA_ROOT=$_xdg/$NAME
  BIN_DIR=${PTAK_BIN_DIR:-$HOME/.local/bin}
  case $BIN_DIR in /*) ;; *) die "PTAK_BIN_DIR must be an absolute path" ;; esac
  LINK=$BIN_DIR/$NAME
}

# Reject archive members that are absolute, contain '..', or are not plain
# files/directories (no symlinks, hard links or devices).
check_archive() {
  tar -tzf "$1" > "$TMP/members" || die "downloaded archive is not a valid .tar.gz"
  while IFS= read -r _e; do
    case $_e in
      /* | .. | ../* | */../* | */..) die "unsafe path in archive: $_e" ;;
    esac
  done < "$TMP/members"
  tar -tvzf "$1" | awk '{t = substr($1, 1, 1); if (t != "-" && t != "d") {print; bad = 1}} END {exit bad}' ||
    die "archive contains links or special files; refusing to install"
}

do_uninstall() {
  paths_init
  if [ -L "$LINK" ]; then
    _t=$(readlink "$LINK")
    case $_t in
      "$DATA_ROOT"/*) rm -f "$LINK"; say "Removed $LINK" ;;
      *) warn "leaving $LINK: it points to $_t, not to this kit" ;;
    esac
  elif [ -e "$LINK" ]; then
    warn "leaving $LINK: it is not a link created by this installer"
  fi
  if [ -L "$DATA_ROOT" ]; then
    warn "leaving $DATA_ROOT: it is a symlink"
  elif [ -d "$DATA_ROOT" ]; then
    rm -rf "$DATA_ROOT"
    say "Removed $DATA_ROOT"
  fi
  say "Uninstalled $NAME. Project files it wrote, and any PATH line you added, are left as they are."
}

path_hint() {
  case ":${PATH:-}:" in
    *":$BIN_DIR:"*) return 0 ;;
  esac
  say ""
  say "$BIN_DIR is not on your PATH. Add it with one of:"
  say "  bash:  echo 'export PATH=\"$BIN_DIR:\$PATH\"' >> ~/.bashrc"
  say "  zsh:   echo 'export PATH=\"$BIN_DIR:\$PATH\"' >> ~/.zshrc"
  say "  fish:  fish_add_path $BIN_DIR"
  say "then open a new terminal. Or run it directly: $LINK"
  [ "${PTAK_MODIFY_PATH:-}" = 1 ] || return 0
  case $BIN_DIR in
    *[\"\$\`\\]*) warn "not editing rc files: PTAK_BIN_DIR contains shell metacharacters"; return 0 ;;
  esac
  case ${SHELL:-} in
    */fish) _rc=$HOME/.config/fish/conf.d/$NAME.fish; _line="fish_add_path $BIN_DIR" ;;
    */zsh) _rc=${ZDOTDIR:-$HOME}/.zshrc; _line="export PATH=\"$BIN_DIR:\$PATH\"" ;;
    */bash) _rc=$HOME/.bashrc; _line="export PATH=\"$BIN_DIR:\$PATH\"" ;;
    *) _rc=$HOME/.profile; _line="export PATH=\"$BIN_DIR:\$PATH\"" ;;
  esac
  if [ -f "$_rc" ] && grep -qF "$_line" "$_rc"; then
    say "PATH line already present in $_rc"
    return 0
  fi
  mkdir -p "$(dirname "$_rc")"
  printf '\n# added by the %s installer\n%s\n' "$NAME" "$_line" >> "$_rc"
  say "Added to $_rc: $_line"
}

do_install() {
  pick_tools
  paths_init
  TMP=$(mktemp -d "${TMPDIR:-/tmp}/ptak-install.XXXXXX") || die "mktemp failed"
  trap 'rm -rf "$TMP"' EXIT
  trap 'exit 1' HUP INT TERM

  if [ -n "${PTAK_REF:-}" ]; then
    [ "${PTAK_INSECURE_SKIP_VERIFY:-}" = 1 ] ||
      die "PTAK_REF installs unreleased code without checksum verification; set PTAK_INSECURE_SKIP_VERIFY=1 to confirm"
    case $PTAK_REF in
      *[!A-Za-z0-9._/-]* | *..* | /* | -*) die "invalid PTAK_REF: $PTAK_REF" ;;
    esac
    _label=ref-$(printf '%s' "$PTAK_REF" | tr '/' '-')
    _archive=$TMP/kit.tar.gz
    warn "!!! DEVELOPMENT INSTALL !!!"
    warn "git ref '$PTAK_REF' is NOT a release and is NOT checksum-verified."
    warn "Use this only to test a branch you trust. Normal installs: unset PTAK_REF and PTAK_INSECURE_SKIP_VERIFY."
    fetch "https://codeload.github.com/$REPO/tar.gz/$PTAK_REF" "$_archive" ||
      die "cannot download ref $PTAK_REF"
  else
    [ -z "${PTAK_INSECURE_SKIP_VERIFY:-}" ] ||
      die "PTAK_INSECURE_SKIP_VERIFY only applies to PTAK_REF development installs; releases are always verified"
    if [ -n "${PTAK_VERSION:-}" ]; then _tag=$PTAK_VERSION; else _tag=$(latest_tag); fi
    valid_tag "$_tag" || die "invalid version '$_tag' (expected vMAJOR.MINOR.PATCH, e.g. v0.1.0)"
    _label=$_tag
    _asset=$NAME-$_tag.tar.gz
    _archive=$TMP/$_asset
    say "Downloading $NAME $_tag ..."
    fetch "$(asset_url "$_tag" checksums.txt)" "$TMP/checksums.txt" ||
      die "checksums.txt is missing for release $_tag; refusing to install unverified files"
    fetch "$(asset_url "$_tag" "$_asset")" "$_archive" || die "cannot download $_asset for release $_tag"
    _want=$(awk -v f="$_asset" '$2 == f || $2 == "*" f {print $1}' "$TMP/checksums.txt")
    [ -n "$_want" ] || die "$_asset is not listed in checksums.txt; refusing to install"
    _got=$(sha256_of "$_archive")
    [ "$_want" = "$_got" ] || die "SHA-256 mismatch for $_asset (expected $_want, got $_got); refusing to install"
    say "Verified SHA-256 $_got"
  fi

  check_archive "$_archive"
  mkdir "$TMP/x"
  tar -xzf "$_archive" -C "$TMP/x" || die "cannot unpack archive"
  _top=
  for _d in "$TMP/x"/*; do
    [ -z "$_top" ] || die "unexpected archive layout (more than one top-level entry)"
    _top=$_d
  done
  [ -n "$_top" ] && [ -f "$_top/bin/$NAME" ] && [ -f "$_top/VERSION" ] && [ -f "$_top/kit/agents.map" ] ||
    die "archive does not contain a $NAME kit"
  chmod 755 "$_top/bin/$NAME"

  [ ! -L "$DATA_ROOT" ] || die "refusing to install into symlinked $DATA_ROOT"
  mkdir -p "$DATA_ROOT"
  _dest=$DATA_ROOT/$_label
  rm -rf "$_dest.new"
  mv "$_top" "$_dest.new"
  rm -rf "$_dest"
  mv "$_dest.new" "$_dest"

  mkdir -p "$BIN_DIR"
  if [ -e "$LINK" ] && [ ! -L "$LINK" ]; then
    die "$LINK exists and is not a symlink; move it away and re-run"
  fi
  ln -sfn "$_dest/bin/$NAME" "$LINK"

  # Keep only the version just installed.
  for _old in "$DATA_ROOT"/*; do
    [ -d "$_old" ] || continue
    [ "$_old" = "$_dest" ] && continue
    case ${_old##*/} in
      v[0-9]* | ref-*) rm -rf "$_old" ;;
    esac
  done

  say "Installed $NAME $(sed -n '1p' "$_dest/VERSION") ($_label) to $_dest"
  say "Command: $LINK"
  path_hint
  say ""
  say "Next: cd into a project folder and run:  $NAME --agent claude   (or --list)"
}

main() {
  umask 022
  case ${1:-} in
    '') do_install ;;
    --uninstall) paths_init; do_uninstall ;;
    -h | --help) usage ;;
    *) usage >&2; die "unknown option: $1" ;;
  esac
}

main "$@"
