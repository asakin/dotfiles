#!/bin/bash
# dotfiles installer — symlink-based, non-destructive
# Files stay in the repo. Symlinks are created in your home directory.
# Existing files are backed up, never overwritten.

set -e

DOTFILES_DIR="$HOME/.config/dotfiles"
REPO_URL="https://github.com/asakin/dotfiles.git"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "Installing dotfiles..."
echo ""

# Clone or update the repo
if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "Cloning dotfiles to $DOTFILES_DIR..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
else
    echo "Dotfiles already installed. Pulling latest..."
    git -C "$DOTFILES_DIR" pull
fi

echo ""

# Symlink a file from home/ into $HOME
link() {
    local rel="$1"
    local src="$DOTFILES_DIR/home/$rel"
    local dst="$HOME/$rel"
    local dst_dir
    dst_dir="$(dirname "$dst")"

    mkdir -p "$dst_dir"

    # Back up existing non-symlink files
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        echo -e "${YELLOW}⚠${NC}  Backing up $dst → ${dst}.backup"
        mv "$dst" "${dst}.backup"
    fi

    ln -sf "$src" "$dst"
    echo -e "${GREEN}✓${NC} Linked ~/$rel"
}

link ".zshrc"
link ".zsh_plugins.txt"
link ".config/starship.toml"

echo ""
echo -e "${GREEN}Dotfiles installed.${NC}"
echo ""
echo "Next: run setup.sh to install required tools, then:"
echo "  source ~/.zshrc"
