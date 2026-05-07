#!/bin/bash
# dotfiles installer — symlink-based, non-destructive
# Files stay in the repo. Symlinks are created in your home directory.
# Existing files are backed up, never overwritten.
#
# Self-detects its own location — clone this repo wherever (recommended:
# ~/projects/dotfiles/) and run install.sh from there.

set -e

# Self-detect: DOTFILES_DIR is wherever this script lives.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "Installing dotfiles from: $DOTFILES_DIR"
echo ""

# Symlink a file from home/ into $HOME
link() {
    local rel="$1"
    local src="$DOTFILES_DIR/home/$rel"
    local dst="$HOME/$rel"
    local dst_dir
    dst_dir="$(dirname "$dst")"

    mkdir -p "$dst_dir"

    # Back up existing non-symlink. Timestamp the backup if one already exists
    # so we never overwrite previous rescue copies.
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        local backup="${dst}.backup"
        if [[ -e "$backup" ]]; then
            backup="${dst}.backup.$(date +%Y%m%d-%H%M%S)"
        fi
        echo -e "${YELLOW}⚠${NC}  Backing up $dst → $backup"
        mv "$dst" "$backup"
    fi

    # -sfn: treat $dst as a regular file even if it's a symlink-to-directory,
    # so we replace it cleanly instead of creating a nested link inside.
    ln -sfn "$src" "$dst"
    echo -e "${GREEN}✓${NC} Linked ~/$rel"
}

link ".zshrc"
link ".zsh_plugins.txt"
link ".config/starship.toml"
link ".tmux.conf"
link ".zshrc.compiled"

echo ""
echo -e "${GREEN}Dotfiles installed.${NC}"
echo ""
echo "Next: install sakinrc (the personal layer) per its README, or just"
echo "      reload your shell:"
echo "  source ~/.zshrc"
