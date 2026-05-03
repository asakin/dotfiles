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
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# SakinOS API keys
[ -f ~/projects/SakinOS/.env ] && source ~/projects/SakinOS/.env
# OLLAMA_HOST moved to ~/.zshenv so non-interactive zsh inherits it (2026-04-29)


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# ============================================================================
# Claude Code — auto-worktree (any git repo)
# Each `claude` invocation from inside any git working tree gets its own
# worktree (--worktree). Solves multi-instance contention: parallel sessions
# don't share index.lock, don't sweep each other's untracked files (a real
# failure mode hit on 2026-04-30 — see _seeds/proposals/...session-replay).
#
# Skip rules:
#  • Session-resume / one-shot / meta flags → no fresh worktree
#    (-r, --resume, --continue, --fork-session, --from-pr, -p, --print,
#     --help, -h, --version, -v, --no-session-persistence)
#  • Custom escape hatch: pass --no-worktree (stripped before forwarding)
#  • Already inside .claude/worktrees/ → don't nest
#  • Not in a git repo (cd ~/Downloads etc.) → vanilla
#
# Symlinks resolved via ${PWD:A}.
# Remove this block to revert.
# ============================================================================
claude() {
  local skip_worktree=false
  local args=()

  for arg in "$@"; do
    case "$arg" in
      --no-worktree)
        skip_worktree=true
        ;;
      -r|--resume|--continue|--fork-session|--from-pr|-p|--print|\
--help|-h|--version|-v|--no-session-persistence)
        skip_worktree=true
        args+=("$arg")
        ;;
      *)
        args+=("$arg")
        ;;
    esac
  done

  if $skip_worktree; then
    command claude "${args[@]}"
    return
  fi

  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local pwd_resolved="${PWD:A}"
    if [[ "$pwd_resolved" == *"/.claude/worktrees/"* ]]; then
      command claude "${args[@]}"
    else
      command claude --worktree "${args[@]}"
    fi
  else
    command claude "${args[@]}"
  fi
}

alias claude-prune='git worktree prune && git worktree list | head -20'


# §concierge TTS — copy text, type: speak
# Optional flags: --voice shimmer --speed 1.5
speak() { pbpaste | python3 ~/scripts/tts.py "$@" }
