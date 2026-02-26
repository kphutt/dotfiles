export PATH="/opt/homebrew/bin:$PATH"

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme - clean, shows git branch and status
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git                      # git aliases: gst, gd, gco, gp, etc.
  zsh-autosuggestions      # fish-like suggestions from history
  zsh-syntax-highlighting  # valid commands green, typos red
  tmux                     # auto-start tmux, aliases
)

source $ZSH/oh-my-zsh.sh

# ── Editor ──────────────────────────────────────
export EDITOR='vim'

# ── Aliases ─────────────────────────────────────
# Project launchers
alias start-all="tmuxinator start inbox-shepherd && tmuxinator start identity-lab && tmuxinator start interview-prep && tmuxinator start prompt-lenses && tmuxinator start ai-toolkit && tmuxinator start text-adventure-v2"
alias is="tmuxinator start inbox-shepherd"
alias il="tmuxinator start identity-lab"
alias ip="tmuxinator start interview-prep"
alias pl="tmuxinator start prompt-lenses"
alias at="tmuxinator start ai-toolkit"
alias ta="tmuxinator start text-adventure-v2"

# Quick tmux session switching
alias ts="tmux switch -t"
alias tls="tmux ls"

# Git extras (on top of oh-my-zsh git plugin)
alias gdiff="git diff --stat"
alias greview="git diff --cached"  # what's staged
alias glast="git log --oneline -10"

# ── Path ────────────────────────────────────────
# Add any custom paths here
# export PATH="$HOME/.npm-global/bin:$PATH"
