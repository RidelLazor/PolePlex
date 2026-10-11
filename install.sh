#!/bin/bash
# PolePlex Installation Script
# One-liner: curl -fsSL https://raw.githubusercontent.com/RidelLazor/PolePlex/master/install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}PolePlex Installer${NC}"
echo "===================="

# Check for required tools
for cmd in git curl; do
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${RED}Error: $cmd is not installed${NC}"
        exit 1
    fi
done

# Create temporary directory
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

echo -e "${YELLOW}Downloading PolePlex...${NC}"
git clone https://github.com/RidelLazor/PolePlex.git "$TEMP_DIR" --depth 1 --quiet

cd "$TEMP_DIR"

echo -e "${YELLOW}Installing PolePlex...${NC}"
if command -v sudo &> /dev/null; then
    sudo make install
else
    make install
fi

echo -e "${GREEN}✓ PolePlex installed successfully!${NC}"
echo -e "Run ${YELLOW}poleplex --help${NC} to get started"
