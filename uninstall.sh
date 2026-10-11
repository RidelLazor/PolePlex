#!/bin/bash
# PolePlex Uninstallation Script
# Usage: bash uninstall.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}PolePlex Uninstaller${NC}"
echo "===================="

# Get PREFIX from environment or use default
PREFIX="${PREFIX:-/usr/local}"
BINDIR="${PREFIX}/bin"
MANDIR="${PREFIX}/share/man/man1"
DOCDIR="${PREFIX}/share/doc/poleplex"
LICDIR="${PREFIX}/share/licenses/poleplex"
BASHCOMP="${PREFIX}/share/bash-completion/completions"
ZSHCOMP="${PREFIX}/share/zsh/site-functions"
FISHCOMP="${PREFIX}/share/fish/vendor_completions.d"

echo -e "${YELLOW}Removing PolePlex from ${PREFIX}...${NC}"

# Determine if we need sudo
if [[ "$BINDIR" == /usr/* ]] || [[ "$BINDIR" == /opt/* ]]; then
    if command -v sudo &> /dev/null && [[ $EUID -ne 0 ]]; then
        SUDO="sudo"
    else
        SUDO=""
    fi
else
    SUDO=""
fi

# Remove files
$SUDO rm -f "$BINDIR/poleplex" && echo -e "${GREEN}✓${NC} Removed binary"
$SUDO rm -f "$LICDIR/LICENSE" && echo -e "${GREEN}✓${NC} Removed license"
$SUDO rm -f "$DOCDIR/README.md" && echo -e "${GREEN}✓${NC} Removed documentation"
$SUDO rm -f "$MANDIR/poleplex.1" && echo -e "${GREEN}✓${NC} Removed man page"
$SUDO rm -f "$BASHCOMP/poleplex" && echo -e "${GREEN}✓${NC} Removed bash completion"
$SUDO rm -f "$ZSHCOMP/_poleplex" && echo -e "${GREEN}✓${NC} Removed zsh completion"
$SUDO rm -f "$FISHCOMP/poleplex.fish" && echo -e "${GREEN}✓${NC} Removed fish completion"

echo -e "${GREEN}✓ PolePlex uninstalled successfully!${NC}"
