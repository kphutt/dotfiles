# dotfiles

My cross-platform terminal dev environment, managed with [chezmoi](https://chezmoi.io): one source
renders **zsh** (macOS) and **PowerShell** (Windows) from shared templates, with a byte-identical
**starship** prompt on both.

## What's included

- **starship** — shared prompt (`dot_config/starship.toml`), identical on macOS + Windows
- **zsh** (`dot_zshrc`, macOS) / **PowerShell profile** (Windows) — zoxide (smart `cd`), fzf (fuzzy find), history predictions, syntax highlighting
- **gitconfig** (`dot_gitconfig.tmpl`) — delta diffs + aliases; identity lives in an untracked `~/.gitconfig.local` (kept out of this public repo)
- **tmux.conf** (macOS) — Ctrl+A prefix, mouse, session persistence
- **`run_once` installers** — winget (Windows) / brew (macOS) install starship, zoxide, fzf, ripgrep, fd, and a Nerd Font

## Setup on a new machine

```bash
# install chezmoi — macOS: brew install chezmoi · Windows: winget install twpayne.chezmoi
chezmoi init --apply kphutt
```

This clones the source, installs the toolkit, and writes your shell config. Then create
`~/.gitconfig.local` with your git identity (name/email). On macOS, open tmux and press `Ctrl+A` then
`I` to install tmux plugins.

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
