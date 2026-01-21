#!/bin/bash
set -e

echo "📦 Setting up user environment..."

DOTFILES_DIR="/workspaces/devlab/.devcontainer/dotfiles"

# Install user tools
echo "📦 Installing user tools..."
sudo apt-get update
sudo apt-get install -y \
    neovim \
    vim \
    tmux \
    ripgrep \
    fd-find \
    fzf

# Verify it exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "❌ ERROR: Dotfiles not found at $DOTFILES_DIR"
    echo "Current directory: $(pwd)"
    echo "Home directory: $HOME"
    echo "Contents of /workspaces:"
    ls -la /workspaces/
    exit 1
fi

# Copy dotfiles
echo "📝 Copying dotfiles..."
cp "${DOTFILES_DIR}/.bashrc" ~/.bashrc
cp "${DOTFILES_DIR}/.tmux.conf" ~/.tmux.conf
cp "${DOTFILES_DIR}/.vimrc" ~/.vimrc 2>/dev/null || true

# Neovim config
mkdir -p ~/.config/nvim

if [ -f "${DOTFILES_DIR}/nvim/init.lua" ]; then
    cp "${DOTFILES_DIR}/nvim/init.lua" ~/.config/nvim/init.lua
    echo "  ✓ Copied nvim/init.lua"
fi

if [ -d "${DOTFILES_DIR}/nvim/lua" ]; then
    cp -r "${DOTFILES_DIR}/nvim/lua" ~/.config/nvim/
    echo "  ✓ Copied nvim/lua directory"
fi

# FZF installation
if [ ! -d ~/.fzf ]; then
    echo "📦 Installing FZF..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    # Install binaries only (skip shell modifications)
    ~/.fzf/install --bin --no-update-rc --no-bash --no-zsh --no-fish
fi

# Copy our pre-configured .fzf.bash (no bugs!)
if [ -f "${DOTFILES_DIR}/.fzf.bash" ]; then
    echo "  ✓ Copied .fzf.bash"
    cp "${DOTFILES_DIR}/.fzf.bash" ~/.fzf.bash
fi

# Fix ownership
sudo chown -R dev:dev /home/dev

echo "✅ User environment ready!"

