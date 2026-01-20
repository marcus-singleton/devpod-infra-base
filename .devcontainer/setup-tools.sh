#!/bin/bash
set -e

echo "📦 Installing optional tools..."

# k3d
if ! command -v k3d &> /dev/null; then
    echo "Installing k3d..."
    curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
fi

# 1Password CLI (optional - won't fail if errors)
if ! command -v op &> /dev/null; then
    echo "Installing 1Password CLI..."
    
    # Use set +e to not fail on errors for this section
    set +e
    
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
        sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
        sudo tee /etc/apt/sources.list.d/1password.list
    
    sudo apt-get update && sudo apt-get install -y 1password-cli
    
    # Re-enable exit on error
    set -e
    
    if command -v op &> /dev/null; then
        echo "✓ 1Password CLI installed"
    else
        echo "⚠️  1Password CLI installation failed (optional, continuing...)"
    fi
fi

# Fix permissions
sudo chown -R dev:dev /home/dev 2>/dev/null || true

echo "✅ Optional tools installed!"

