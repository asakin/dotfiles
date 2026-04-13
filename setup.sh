#!/bin/bash
# dotfiles tool installer — idempotent
# Installs Homebrew tools required by this dotfiles configuration.
# Safe to run multiple times.

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

check() { echo -e "${GREEN}✓${NC} $1"; }
install_msg() { echo "  Installing $1..."; }
skip() { echo -e "${YELLOW}⚠${NC}  $1 — skipping"; }

echo "Setting up dotfiles dependencies..."
echo ""

# Homebrew
if ! command -v brew &>/dev/null; then
    echo -e "${RED}Homebrew not found.${NC} Install it first:"
    echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
fi
check "Homebrew"

# Starship
if ! command -v starship &>/dev/null; then
    install_msg "Starship"
    brew install starship
fi
check "Starship"

# Zoxide
if ! command -v zoxide &>/dev/null; then
    install_msg "Zoxide"
    brew install zoxide
fi
check "Zoxide"

# fzf
if ! command -v fzf &>/dev/null; then
    install_msg "fzf"
    brew install fzf
    "$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish 2>/dev/null || true
fi
check "fzf"

echo ""
echo -e "${GREEN}All tools installed.${NC}"
echo ""
echo "If you haven't run install.sh yet, do that now:"
echo "  ./install.sh"
echo ""
echo "Then reload your shell:"
echo "  source ~/.zshrc"
