# dotfiles

My terminal dev environment. iTerm2 + zsh + tmux + delta.

## What's included

- **zshrc** — oh-my-zsh with git aliases, autosuggestions, syntax highlighting
- **tmux.conf** — Ctrl+A prefix, mouse support, session persistence via resurrect/continuum
- **gitconfig** — delta for side-by-side diffs, useful aliases
- **tmuxinator/** — named project sessions with claude + git panes

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
# Start a project session
tmuxinator start inbox-shepherd

# Or use aliases
is    # inbox-shepherd
il    # identity-lab
ip    # interview-prep
pl    # prompt-lenses
at    # ai-toolkit
ta    # text-adventure-v2
df    # dotfiles (shadows Unix df)

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
./new-project.sh my-cool-app       # alias auto-generated: mca
./new-project.sh my-cool-app mca   # or specify the alias
source ~/.zshrc
```

This creates a tmuxinator config, adds a launcher alias to zshrc, and updates `start-all`.
