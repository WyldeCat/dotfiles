#!/usr/bin/env bash
set -euo pipefail

if command -v apt-get >/dev/null 2>&1; then
    echo "Detected apt-get. Installing packages..."
    sudo apt-get update -y
    sudo apt-get install -y git git-lfs fzf tmux less
    git lfs install --system || true
else
    echo "apt-get not found. Skipping installation (add other package managers here)."
    # Example:
    # elif command -v brew >/dev/null 2>&1; then
    #     echo "Detected Homebrew. Installing packages..."
    #     brew install git git-lfs fzf tmux less
fi

echo "Setup complete."
