# dotfiles

A minimal, opinionated zsh environment for macOS.

**What's included:** zsh with a 10M-line history, [Starship](https://starship.rs) prompt, [Antidote](https://github.com/mattmc3/antidote) plugin manager, [zoxide](https://github.com/ajeetdsouza/zoxide) smart navigation, and [fzf](https://github.com/junegunn/fzf) fuzzy finder.

**How it works:** files live in `~/.config/dotfiles`. Symlinks point from your home directory into the repo. Your existing files are backed up before anything is replaced. To undo, run `dotfiles-uninstall`.

---

## Install

### One-liner

```bash
git clone https://github.com/asakin/dotfiles.git ~/.config/dotfiles
~/.config/dotfiles/setup.sh
~/.config/dotfiles/install.sh
source ~/.zshrc
```

### Via Homebrew tap

```bash
brew tap asakin/dotfiles
brew install dotfiles
dotfiles-install
source ~/.zshrc
```

---

## What gets installed

| File | Symlinked to |
|---|---|
| `home/.zshrc` | `~/.zshrc` |
| `home/.zsh_plugins.txt` | `~/.zsh_plugins.txt` |
| `home/.config/starship.toml` | `~/.config/starship.toml` |

Tools installed by `setup.sh`: `starship`, `zoxide`, `fzf`. Antidote is bootstrapped automatically on first `source ~/.zshrc`.

---

## Customization

**Add plugins:** edit `~/.zsh_plugins.txt` (the symlink). Changes apply on next shell start.

**Customize the prompt:** edit `~/.config/starship.toml`. See [starship.rs/config](https://starship.rs/config/) for options.

**Add aliases:** append to `~/.zshrc` — or better, create `~/.zshrc.local` and source it from `.zshrc` (add `[ -f ~/.zshrc.local ] && source ~/.zshrc.local` at the bottom).

---

## Update

```bash
cd ~/.config/dotfiles && git pull
```

Symlinks don't need to be re-created after pulling. The files they point to update in place.

---

## Uninstall

```bash
dotfiles-uninstall
```

Removes symlinks and restores any backed-up originals. The repo at `~/.config/dotfiles` is left in place — delete it manually if you want a clean slate.

---

## What's not included

This config is intentionally stripped down. No AWS, no cloud CLIs, no AI tool integrations. Those belong in your own layer on top. See the `home/.zshrc` comments for suggested extension points.

---

## License

MIT
