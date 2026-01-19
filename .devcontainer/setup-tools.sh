#!/bin/bash
set -e

echo "📦 Installing tools..."

# k3d (not in features)
if ! command -v k3d &> /dev/null; then
    echo "Installing k3d..."
    curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
fi

# 1Password CLI
if ! command -v op &> /dev/null; then
    echo "Installing 1Password CLI..."
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
        gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
        sudo tee /etc/apt/sources.list.d/1password.list
    sudo apt-get update && sudo apt-get install -y 1password-cli
fi

echo "✅ Tools installed!"

