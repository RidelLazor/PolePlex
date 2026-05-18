#!/usr/bin/env bash
# PolePlex installer
# Usage: curl -fsSL https://ridellazor.github.io/PolePlex/install.sh | bash

set -euo pipefail

REPO="https://github.com/RidelLazor/PolePlex"
REPO_DIR="${POLEPLEX_DIR:-${HOME}/poleplex}"
BIN_DIR="${HOME}/.local/bin"
BIN_PATH="${BIN_DIR}/poleplex"
INSTALL_SYSTEM=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -p|--path) REPO_DIR="$2"; shift 2 ;;
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

# ── Clone or pull the repo ──────────────────────────────────
if [[ -d "$REPO_DIR/.git" ]]; then
  info "PolePlex repo found at $REPO_DIR, updating..."
  (cd "$REPO_DIR" && git pull --ff-only) || { err "Update failed."; exit 1; }
  ok "Repo updated"
else
  info "Downloading PolePlex to $REPO_DIR..."
  git clone --depth 1 "$REPO" "$REPO_DIR"
  ok "Repo downloaded"
fi

[[ -f "${REPO_DIR}/poleplex" ]] || { err "poleplex script not found"; exit 1; }

# ── Install the binary ──────────────────────────────────────
if $INSTALL_SYSTEM; then
  command -v sudo &>/dev/null || { err "sudo not available"; exit 1; }
  (cd "$REPO_DIR" && sudo make install)
  ok "PolePlex installed system-wide to /usr/local/bin/poleplex"
else
  mkdir -p "$BIN_DIR"
  install -m755 "${REPO_DIR}/poleplex" "$BIN_PATH"
  ok "PolePlex installed to $BIN_PATH"
fi

# ── Install completions ─────────────────────────────────────
if [[ -d "${REPO_DIR}/completions" ]]; then
  mkdir -p "${HOME}/.local/share/bash-completion/completions" 2>/dev/null || true
  mkdir -p "${HOME}/.local/share/zsh/site-functions" 2>/dev/null || true
  mkdir -p "${HOME}/.config/fish/completions" 2>/dev/null || true

  [[ -f "${REPO_DIR}/completions/poleplex.bash" ]] && \
    cp "${REPO_DIR}/completions/poleplex.bash" "${HOME}/.local/share/bash-completion/completions/poleplex" 2>/dev/null || true
  [[ -f "${REPO_DIR}/completions/poleplex.zsh" ]] && \
    cp "${REPO_DIR}/completions/poleplex.zsh" "${HOME}/.local/share/zsh/site-functions/_poleplex" 2>/dev/null || true
  [[ -f "${REPO_DIR}/completions/poleplex.fish" ]] && \
    cp "${REPO_DIR}/completions/poleplex.fish" "${HOME}/.config/fish/completions/poleplex.fish" 2>/dev/null || true
fi

# ── Install man page ────────────────────────────────────────
if [[ -f "${REPO_DIR}/man/poleplex.1" ]]; then
  mkdir -p "${HOME}/.local/share/man/man1" 2>/dev/null || true
  cp "${REPO_DIR}/man/poleplex.1" "${HOME}/.local/share/man/man1/poleplex.1" 2>/dev/null || true
fi

# ── Add to PATH in shell config ─────────────────────────────
SHELL_CONFIG=""
for rc in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.config/fish/config.fish"; do
  [[ -f "$rc" ]] && SHELL_CONFIG="$rc" && break
done

if [[ -z "${SHELL_CONFIG:-}" ]]; then
  SHELL_CONFIG="$HOME/.bashrc"
fi

if ! grep -qF "$BIN_DIR" "$SHELL_CONFIG" 2>/dev/null; then
  case "$SHELL_CONFIG" in
    *.fish)
      echo >> "$SHELL_CONFIG"
      echo "# Added by PolePlex installer" >> "$SHELL_CONFIG"
      echo "set -gx PATH \$PATH $BIN_DIR" >> "$SHELL_CONFIG"
      ;;
    *)
      echo >> "$SHELL_CONFIG"
      echo "# Added by PolePlex installer" >> "$SHELL_CONFIG"
      echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$SHELL_CONFIG"
      ;;
  esac
  ok "Added $BIN_DIR to PATH in $SHELL_CONFIG"
else
  info "$BIN_DIR already in PATH in $SHELL_CONFIG"
fi

# ── Done ────────────────────────────────────────────────────
echo ""
info "PolePlex is ready!"
echo ""
echo "    poleplex h               # show help"
echo "    poleplex i spotify       # package info"
echo "    poleplex d yay           # download a package"
echo "    poleplex r yay           # remove from cache"
echo "    poleplex u               # update all"
echo ""
echo "    Restart your terminal or run:"
echo "      source $SHELL_CONFIG"
echo ""
