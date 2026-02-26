# dotfiles

My terminal dev environment. iTerm2 + zsh + tmux + delta.

## What's included

- **zshrc** — oh-my-zsh with git aliases, autosuggestions, syntax highlighting
- **tmux.conf** — Ctrl+A prefix, mouse support, session persistence via resurrect/continuum
- **gitconfig** — delta for side-by-side diffs, useful aliases
- **tmuxinator/** — named project sessions with claude + git panes

## Setup on a new machine

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
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

## Adding a new project

Create `tmuxinator/my-project.yml`:

```yaml
name: my-project
root: ~/dev/my-project

windows:
  - dev:
      layout: even-horizontal
      panes:
        - claude:
            - echo "my-project — run 'claude' to start"
        - git:
            - git status
```

Add an alias to `zshrc` if you want a shortcut.
