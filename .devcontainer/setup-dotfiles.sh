#!/bin/bash
echo "📦 Setting up environment..."

sudo apt-get update
sudo apt-get install -y neovim vim tmux ripgrep fd-find

# Copy dotfiles
cp .devcontainer/dotfiles/.bashrc ~/
cp .devcontainer/dotfiles/.tmux.conf ~/
cp .devcontainer/dotfiles/.vimrc ~/
mkdir -p ~/.config/nvim
cp -r .devcontainer/dotfiles/nvim/* ~/.config/nvim/
mkdir -p ~/.vim/undodir

# Install FZF
if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi

echo "✅ Dotfiles ready!"

