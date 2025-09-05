#!/bin/bash
set -xeuo pipefail

mkdir -p $HOME/.local

INSTALL_DIR="$HOME/.local/bin"
LINE_TO_ADD="export PATH=\"\$HOME/.local/bin:\$PATH\"; alias vi='nvim'; alias vim='nvim'"

if ! grep -Fxq "$LINE_TO_ADD" "$HOME/.bashrc" && ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "$LINE_TO_ADD" >> "$HOME/.bashrc"
    echo "Added $HOME/.local/bin to PATH in .bashrc"
else
    echo "$HOME/.local/bin is already in PATH or .bashrc"
fi

NVIM_URL=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
    | grep browser_download_url \
    | grep 'linux-x86_64.tar.gz' \
    | cut -d '"' -f 4)

TMP_DIR=$(mktemp -d)
echo "📦 Downloading Neovim from $NVIM_URL"

curl -L "$NVIM_URL" -o "$TMP_DIR/nvim.tar.gz"
tar -xzf "$TMP_DIR/nvim.tar.gz" -C "$TMP_DIR"

cp -r "$TMP_DIR"/nvim-linux-x86_64/* $HOME/.local

echo "✅ Installed Neovim to $INSTALL_DIR/nvim"

if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo "⚠️  $INSTALL_DIR is not in your PATH. Add this to your shell config:"
    echo "    export PATH=\"$INSTALL_DIR:\$PATH\""
fi

"$INSTALL_DIR/nvim" --version | head -n 1

rm -rf "$TMP_DIR"
