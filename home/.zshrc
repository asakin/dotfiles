# ============================================================================
# DOTFILES API CONTRACT
# ============================================================================
# This environment variable signals to extension layers that this base 
# environment is installed and honors a specific set of guarantees.
# 
# CONTRACT TRUTHS (v1.0):
# 1. The shell is Zsh.
# 2. The following core binaries are installed and available in the PATH:
#    - starship
#    - zoxide
#    - fzf
# 3. An extension hook file exists at ~/.zshrc.extension and will be sourced
#    if present (this allows layers to inject their code silently).
#
# If you fork this repository and break backwards compatibility by removing 
# or renaming ANY of the above requirements, you MUST advance the version 
# number (e.g., to "2.0") to protect child extensions from failing.
# ============================================================================
export DOTFILES_BASE_API_VERSION="1.0"


# ============================================================================
# Completion System Configuration
# ============================================================================
# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Menu selection for completions
zstyle ':completion:*' menu select

# Initialize completion system BEFORE plugins load
autoload -Uz compinit
compinit -d ~/.zcompdump

# ============================================================================
# oh-my-zsh plugin compatibility — ZSH_CACHE_DIR must exist before plugins load
# ============================================================================
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
mkdir -p "$ZSH_CACHE_DIR/completions"

# ============================================================================
# Antidote - Fast zsh plugin manager
# ============================================================================
if [[ ! -d ${ZDOTDIR:-~}/.antidote ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# Re-initialize completion system after plugins load to pick up plugin completions
compinit -u -d ~/.zcompdump

# ============================================================================
# History Substring Search Configuration
# ============================================================================
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down

# ============================================================================
# History Configuration
# ============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_BEEP

# ============================================================================
# Zoxide Configuration (smarter cd)
# ============================================================================
eval "$(zoxide init zsh)"

# ============================================================================
# FZF Configuration (fuzzy finder)
# ============================================================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ============================================================================
# Starship Prompt
# ============================================================================
eval "$(starship init zsh)"

# ============================================================================
# Aliases — Git
# ============================================================================
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'

# ============================================================================
# Aliases — Navigation
# ============================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -lah'

# ============================================================================
# Environment
# ============================================================================
export EDITOR='vim'
export VISUAL='vim'

# ============================================================================
# Personal layer
# ============================================================================
[ -f ~/.zshrc.extension ] && source ~/.zshrc.extension

# OLLAMA_HOST moved to ~/.zshenv so non-interactive zsh inherits it (2026-04-29)


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# Load Compiled Dotfiles
[ -f ~/.zshrc.compiled ] && source ~/.zshrc.compiled

# Added by Antigravity
export PATH="/Users/arielsakin/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Added by Antigravity IDE
export PATH="/Users/arielsakin/.antigravity-ide/antigravity-ide/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/Users/arielsakin/.local/bin:$PATH"

# BEGIN SIGLIFY-ENV
# Sourced by siglify — vars configured by: siglify configure
[ -f "$HOME/.siglify/env" ] && . "$HOME/.siglify/env"
# END SIGLIFY-ENV
