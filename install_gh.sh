#!/usr/bin/env bash
set -xeuo pipefail

# -----------------------------------------------------------------------------
# This script installs GitHub CLI (gh) into ~/.local/bin without using package managers.
# It works on Ubuntu (Linux x86_64) and macOS (Darwin arm64/x86_64).
# -----------------------------------------------------------------------------

# Create ~/.local/bin if not exists
mkdir -p "$HOME/.local/bin"

# Detect OS and architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Linux)
    PLATFORM="linux"
    case "$ARCH" in
      x86_64) ARCH="amd64" ;;
      aarch64 | arm64) ARCH="arm64" ;;
      *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
    esac
    ;;
  Darwin)
    PLATFORM="macOS"
    case "$ARCH" in
      x86_64) ARCH="amd64" ;;
      arm64)  ARCH="arm64" ;;
      *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
    esac
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

# Get latest GitHub CLI release tag from GitHub API
LATEST_TAG=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')

if [ -z "$LATEST_TAG" ]; then
  echo "Failed to get latest GitHub CLI release."
  exit 1
fi

echo "Latest GitHub CLI version: $LATEST_TAG"

# Build download URL
TARBALL="gh_${LATEST_TAG#v}_${PLATFORM}_${ARCH}.tar.gz"
URL="https://github.com/cli/cli/releases/download/${LATEST_TAG}/${TARBALL}"

# Download and extract
TMPDIR=$(mktemp -d)
cd "$TMPDIR"
echo "Downloading $URL ..."
curl -sL "$URL" -o "$TARBALL"

tar -xzf "$TARBALL"

# Move binary to ~/.local/bin
BIN_PATH=$(find . -type f -path "*/bin/gh" | head -n 1)
if [ ! -f "$BIN_PATH" ]; then
  echo "Failed to find gh binary inside tarball"
  exit 1
fi

mv "$BIN_PATH" "$HOME/.local/bin/gh"

# Cleanup
cd -
rm -rf "$TMPDIR"

echo "GitHub CLI installed to $HOME/.local/bin/gh"
echo "Make sure $HOME/.local/bin is in your PATH."
