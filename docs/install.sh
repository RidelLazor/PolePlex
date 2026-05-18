#!/usr/bin/env bash
# PolePlex installer
# Usage: curl -fsSL https://raw.githubusercontent.com/RidelLazor/PolePlex/main/install.sh | bash
#        curl -fsSL https://raw.githubusercontent.com/RidelLazor/PolePlex/main/install.sh | bash -s -- -p /custom/path

set -euo pipefail

REPO="https://github.com/RidelLazor/PolePlex"
TARGET="${POLEPLEX_DIR:-${HOME}/poleplex}"
INSTALL_SYSTEM=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -p|--path) TARGET="$2"; shift 2 ;;
    -s|--system) INSTALL_SYSTEM=true; shift ;;
    *) echo "Unknown: $1"; exit 1 ;;
  esac
done

color() { local c="$1"; shift; printf "\033[%sm%s\033[0m" "$c" "$*"; }
info()  { printf "%s %s\n" "$(color '1;34' '::')" "$*"; }
ok()    { printf "%s %s\n" "$(color '1;32' '=>')" "$*"; }
err()   { printf "%s %s\n" "$(color '1;31' '!!')" "$*" >&2; }

if ! command -v git &>/dev/null; then
  err "git is required but not installed."
  command -v pacman &>/dev/null && info "Install it: sudo pacman -S git"
  command -v apt &>/dev/null && info "Install it: sudo apt install git"
  command -v dnf &>/dev/null && info "Install it: sudo dnf install git"
  exit 1
fi

if [[ -d "$TARGET/.git" ]]; then
  info "PolePlex already installed at $TARGET, updating..."
  (cd "$TARGET" && git pull --ff-only) || { err "Update failed."; exit 1; }
  ok "Updated to latest version"
else
  info "Downloading PolePlex to $TARGET..."
  git clone --depth 1 "$REPO" "$TARGET"
  ok "Downloaded PolePlex"
fi

POLEPLEX_BIN="${TARGET}/poleplex"
[[ -f "$POLEPLEX_BIN" ]] || { err "poleplex not found at $POLEPLEX_BIN"; exit 1; }

if $INSTALL_SYSTEM; then
  command -v sudo &>/dev/null || { err "sudo not available"; exit 1; }
  (cd "$TARGET" && sudo make install)
  ok "PolePlex installed to /usr/local/bin/poleplex"
else
  for rc in "${ZSH_VERSION:+$HOME/.zshrc}" "${BASH_VERSION:+$HOME/.bashrc}" "$HOME/.bashrc" "$HOME/.zshrc"; do
    [[ -f "$rc" ]] && SHELL_CONFIG="$rc" && break
  done
  if [[ -n "${SHELL_CONFIG:-}" ]] && ! grep -q "poleplex" "$SHELL_CONFIG" 2>/dev/null; then
    { echo; echo "# Added by PolePlex installer"; echo "export PATH=\"\$PATH:${TARGET}\""; } >> "$SHELL_CONFIG"
    ok "Added poleplex to PATH in $SHELL_CONFIG"
  fi
fi

echo ""
info "PolePlex is ready!"
echo "    ${TARGET}/poleplex h"
echo "    ${TARGET}/poleplex i spotify"
if ! $INSTALL_SYSTEM; then
  echo ""
  echo "    Restart your shell or:  export PATH=\"\$PATH:${TARGET}\""
fi
echo ""
