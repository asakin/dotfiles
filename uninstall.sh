#!/bin/bash
# dotfiles uninstaller — removes symlinks created by install.sh
# Restores .backup files if they exist.

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

unlink_file() {
    local rel="$1"
    local dst="$HOME/$rel"

    if [[ -L "$dst" ]]; then
        rm "$dst"
        echo -e "${GREEN}✓${NC} Removed symlink ~/$rel"
    fi

    if [[ -e "${dst}.backup" ]]; then
        mv "${dst}.backup" "$dst"
        echo -e "${YELLOW}↩${NC}  Restored ~/$rel from backup"
    fi
}

echo "Uninstalling dotfiles symlinks..."
echo ""

unlink_file ".zshrc"
unlink_file ".zsh_plugins.txt"
unlink_file ".config/starship.toml"

echo ""
echo "Done. Your previous config has been restored where backups existed."
echo "The dotfiles repo at ~/.config/dotfiles was not deleted."
echo "To fully remove it: rm -rf ~/.config/dotfiles"
