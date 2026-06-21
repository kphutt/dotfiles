# dotfiles

My terminal dev environment. iTerm2 + zsh + tmux + delta.

## What's included

- **zshrc** — oh-my-zsh + **zoxide** (smart `cd`) + **fzf** (fuzzy find); autosuggestions, syntax highlighting
- **tmux.conf** — Ctrl+A prefix, mouse support, session persistence via resurrect/continuum
- **gitconfig** — delta for side-by-side diffs, useful aliases

## Setup on a new machine

```bash
git clone https://github.com/kphutt/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
source ~/.zshrc
```

Then open tmux and press `Ctrl+A` then `I` to install tmux plugins.

## Daily usage

```bash
# Jump to any repo you've visited (zoxide learns dirs as you cd — no per-project aliases)
z myrepo          # smart-jumps to the best match
zi                # interactive fuzzy picker

# Switch between sessions
Ctrl+A then s     # session picker
Ctrl+A then d     # detach

# Pane navigation
Alt+←/→/↑/↓       # move between panes
Ctrl+A then z     # zoom/unzoom pane

# Git review workflow
gst               # git status
gd                # git diff (with delta)
git add -p        # interactive staging
```

## Scaffolding a new project

```bash
./new-project.sh my-cool-app       # creates ~/dev/my-cool-app + git init
```

No aliases or per-project config — `z my-cool-app` jumps there once you've `cd`'d in. Scaffold docs (README / CLAUDE.md / ROADMAP) with the `/bootstrap` skill.
