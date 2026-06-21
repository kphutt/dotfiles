#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "📦 Installing dotfiles from $DOTFILES_DIR"

# ── Homebrew ────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✓ Homebrew already installed"
fi

# ── Brew packages ───────────────────────────────
# tmux + delta = multiplexer + nicer diffs; zoxide/fzf/ripgrep/fd = the fast inner loop
# (smart cd, fuzzy find, fast search — ripgrep is also what Claude Code searches with).
echo "🍺 Installing brew packages..."
brew install tmux git-delta zoxide fzf ripgrep fd 2>/dev/null || true
brew install --cask iterm2 2>/dev/null || true

# ── Oh My Zsh ──────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "🐚 Installing Oh My Zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✓ Oh My Zsh already installed"
fi

# ── Zsh plugins ─────────────────────────────────
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "🔌 Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  echo "✓ zsh-autosuggestions already installed"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "🔌 Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
  echo "✓ zsh-syntax-highlighting already installed"
fi

# ── Tmux Plugin Manager ────────────────────────
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "🔌 Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "✓ tmux plugin manager already installed"
fi

# ── Symlinks ────────────────────────────────────
echo "🔗 Creating symlinks..."

ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"

# ── Verify ──────────────────────────────────────
echo ""
echo "✅ Done! Installed:"
echo "   zshrc     → ~/.zshrc"
echo "   tmux.conf → ~/.tmux.conf"
echo "   gitconfig → ~/.gitconfig"
echo ""
echo "Next steps:"
echo "  1. Run: source ~/.zshrc"
echo "  2. Open tmux and press Ctrl+A then I to install tmux plugins"
echo "  3. Set your git identity: git config --global user.email you@example.com"
echo ""
echo "Navigate: cd into a repo once, then 'z <name>' jumps back to it; 'zi' to fuzzy-pick."
