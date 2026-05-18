#!/usr/bin/env bash
# PolePlex installer
# Usage: curl -fsSL https://anomalyco.github.io/poleplex/install.sh | bash
#        curl -fsSL https://anomalyco.github.io/poleplex/install.sh | bash -s -- -p /custom/path

set -euo pipefail

REPO="https://github.com/anomalyco/poleplex"
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
  if command -v pacman &>/dev/null; then
    info "Install it: sudo pacman -S git"
  elif command -v apt &>/dev/null; then
    info "Install it: sudo apt install git"
  elif command -v dnf &>/dev/null; then
    info "Install it: sudo dnf install git"
  fi
  exit 1
fi

if [[ -d "$TARGET/.git" ]]; then
  info "PolePlex already installed at $TARGET, updating..."
  (cd "$TARGET" && git pull --ff-only) || {
    err "Update failed. Try: rm -rf $TARGET && curl -fsSL https://anomalyco.github.io/poleplex/install.sh | bash"
    exit 1
  }
  ok "Updated to latest version"
else
  info "Downloading PolePlex to $TARGET..."
  git clone --depth 1 "$REPO" "$TARGET"
  ok "Downloaded PolePlex"
fi

POLEPLEX_BIN="${TARGET}/poleplex"
if [[ ! -f "$POLEPLEX_BIN" ]]; then
  err "Something went wrong - poleplex script not found at $POLEPLEX_BIN"
  exit 1
fi

if $INSTALL_SYSTEM; then
  if command -v sudo &>/dev/null; then
    info "Installing system-wide..."
    (cd "$TARGET" && sudo make install)
    ok "PolePlex installed to /usr/local/bin/poleplex"
  else
    err "sudo not available, cannot install system-wide"
    exit 1
  fi
else
  SHELL_CONFIG=""
  if [[ -n "${ZSH_VERSION:-}" ]]; then
    SHELL_CONFIG="${HOME}/.zshrc"
  elif [[ -n "${BASH_VERSION:-}" ]]; then
    SHELL_CONFIG="${HOME}/.bashrc"
  elif [[ -f "${HOME}/.bashrc" ]]; then
    SHELL_CONFIG="${HOME}/.bashrc"
  elif [[ -f "${HOME}/.zshrc" ]]; then
    SHELL_CONFIG="${HOME}/.zshrc"
  fi

  if [[ -n "$SHELL_CONFIG" ]]; then
    if ! grep -q "poleplex" "$SHELL_CONFIG" 2>/dev/null; then
      echo >> "$SHELL_CONFIG"
      echo "# Added by PolePlex installer" >> "$SHELL_CONFIG"
      echo "export PATH=\"\$PATH:${TARGET}\"" >> "$SHELL_CONFIG"
      ok "Added poleplex to PATH in $SHELL_CONFIG"
    fi
  fi
fi

echo ""
info "PolePlex is ready!"
echo ""
echo "    Run:  ${TARGET}/poleplex h"
echo "    Try:  ${TARGET}/poleplex i spotify"
echo ""
if ! $INSTALL_SYSTEM; then
  echo "    PolePlex was added to your PATH."
  echo "    Restart your terminal or run:"
  echo "      export PATH=\"\$PATH:${TARGET}\""
  echo "    Then just type: poleplex"
fi
echo ""
