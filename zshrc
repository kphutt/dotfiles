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
# Project navigation is zoxide now — `z <name>` jumps anywhere (see Navigation block at bottom).
# No per-project launchers here: nothing in this file names a repo, so nothing can leak.

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
export PATH="$HOME/.local/bin:$PATH"

# ── Navigation: smart cd + fuzzy find ───────────
# zoxide learns dirs as you `cd`; then `z <name>` jumps to any of them — replaces the old
# per-project aliases AND the ~/dev hardcoding. `zi` = interactive fuzzy picker.
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
# fzf keybindings: Ctrl-R (history search), Ctrl-T (file picker). Needs fzf 0.48+.
command -v fzf >/dev/null && source <(fzf --zsh)
