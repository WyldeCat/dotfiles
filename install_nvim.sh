#!/bin/bash
set -euo pipefail

INSTALL_DIR="$HOME/.local/bin"
NVIM_URL=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
    | grep browser_download_url \
    | grep 'linux64.tar.gz' \
    | cut -d '"' -f 4)

TMP_DIR=$(mktemp -d)
echo "📦 Downloading Neovim from $NVIM_URL"

curl -L "$NVIM_URL" -o "$TMP_DIR/nvim.tar.gz"
tar -xzf "$TMP_DIR/nvim.tar.gz" -C "$TMP_DIR"

mkdir -p "$INSTALL_DIR"
cp "$TMP_DIR"/nvim-linux64/bin/nvim "$INSTALL_DIR/nvim"

echo "✅ Installed Neovim to $INSTALL_DIR/nvim"

if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo "⚠️  $INSTALL_DIR is not in your PATH. Add this to your shell config:"
    echo "    export PATH=\"$INSTALL_DIR:\$PATH\""
fi

"$INSTALL_DIR/nvim" --version | head -n 1

rm -rf "$TMP_DIR"
