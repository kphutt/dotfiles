#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_NAME="$1"
ALIAS_NAME="$2"

# ── Validate ───────────────────────────────────
if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: ./new-project.sh <project-name> [alias]"
  echo "  e.g. ./new-project.sh my-cool-app mca"
  exit 1
fi

if [ -f "$DOTFILES_DIR/tmuxinator/$PROJECT_NAME.yml" ]; then
  echo "Error: tmuxinator/$PROJECT_NAME.yml already exists"
  exit 1
fi

# ── Generate alias ─────────────────────────────
if [ -z "$ALIAS_NAME" ]; then
  ALIAS_NAME=$(echo "$PROJECT_NAME" | sed 's/[^a-z-]//g' | tr '-' '\n' | sed 's/\(.\).*/\1/' | tr -d '\n')
fi

if grep -q "^alias $ALIAS_NAME=" "$DOTFILES_DIR/zshrc"; then
  echo "Error: alias '$ALIAS_NAME' already exists in zshrc"
  exit 1
fi

# ── Title-case the display name ────────────────
DISPLAY_NAME=$(echo "$PROJECT_NAME" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')

# ── Create tmuxinator config ──────────────────
cat > "$DOTFILES_DIR/tmuxinator/$PROJECT_NAME.yml" <<EOF
name: $PROJECT_NAME
root: ~/dev/$PROJECT_NAME

windows:
  - dev:
      layout: even-horizontal
      panes:
        - claude:
            - echo "🚀 $DISPLAY_NAME — run 'claude' to start"
        - git:
            - git status
EOF

# ── Add alias to zshrc ────────────────────────
sed -i '' "/^alias ta=/a\\
alias $ALIAS_NAME=\"tmuxinator start $PROJECT_NAME\"
" "$DOTFILES_DIR/zshrc"

# ── Update start-all alias ────────────────────
sed -i '' "s|^alias start-all=\"\(.*\)\"|alias start-all=\"\1 \&\& tmuxinator start $PROJECT_NAME\"|" "$DOTFILES_DIR/zshrc"

# ── Done ──────────────────────────────────────
echo "Created tmuxinator/$PROJECT_NAME.yml"
echo "Added alias: $ALIAS_NAME → tmuxinator start $PROJECT_NAME"
echo "Updated start-all to include $PROJECT_NAME"
echo ""
echo "Run 'source ~/.zshrc' to activate."
