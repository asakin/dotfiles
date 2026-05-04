# dotfiles

A minimal, opinionated zsh environment for macOS.

**What's included:** zsh with a 10M-line history, [Starship](https://starship.rs) prompt, [Antidote](https://github.com/mattmc3/antidote) plugin manager, [zoxide](https://github.com/ajeetdsouza/zoxide) smart navigation, [fzf](https://github.com/junegunn/fzf) fuzzy finder, and a tmux base config.

**How it works:** files live in the repo. Symlinks point from `~/` into the repo. Existing files are backed up before anything is replaced. Run `./uninstall.sh` to undo.

---

## Install

Clone wherever you keep your projects, then run from there:

```bash
git clone https://github.com/asakin/dotfiles.git ~/projects/dotfiles
~/projects/dotfiles/setup.sh
~/projects/dotfiles/install.sh
source ~/.zshrc
```

`install.sh` self-detects its own location, so the clone path can be anywhere — adjust the commands accordingly. (Recommended: `~/projects/dotfiles/`.)

---

## What gets installed

| File | Symlinked to |
|---|---|
| `home/.zshrc` | `~/.zshrc` |
| `home/.zsh_plugins.txt` | `~/.zsh_plugins.txt` |
| `home/.config/starship.toml` | `~/.config/starship.toml` |
| `home/.tmux.conf` | `~/.tmux.conf` |

Tools installed by `setup.sh`: `starship`, `zoxide`, `fzf`. Antidote is bootstrapped automatically on first `source ~/.zshrc`.

---

## Customization

**Add plugins:** edit `~/.zsh_plugins.txt` (the symlink). Changes apply on next shell start.

**Customize the prompt:** edit `~/.config/starship.toml`. See [starship.rs/config](https://starship.rs/config/).

**Personal aliases / overrides:** create `~/.zshrc.local`. The base `.zshrc` already sources it on shell start (`[ -f ~/.zshrc.local ] && source ~/.zshrc.local`). The personal layer in [asakin/sakinrc](https://github.com/asakin/sakinrc) symlinks this file.

---

## Update

```bash
cd ~/projects/dotfiles && git pull
```

Symlinks don't need re-creation after pulling. Files update in place.

---

## Uninstall

```bash
~/projects/dotfiles/uninstall.sh
```

Removes symlinks and restores any backed-up originals. The repo itself is left in place — `rm -rf ~/projects/dotfiles` if you want a clean slate.

---

## Personal layer

This repo is the generic base. Personal tools, aliases, hotkeys, AI integrations live in [asakin/sakinrc](https://github.com/asakin/sakinrc), which builds on top. **Install dotfiles first, then sakinrc.**

---

## What's not included

Stripped-down on purpose. No AWS, no cloud CLIs, no AI integrations. Those belong in your own layer on top.

---

## License

MIT
