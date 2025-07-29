
if command -v nvim > /dev/null 2>&1; then
    echo "✅ nvim is already installed: $(command -v nvim)"
else
    # Install nvim
    ./install_nvim.sh
fi

# Install nvim plugins
mkdir -p ~/.config
cp -r ./nvim ~/.config/nvim

if command -v node > /dev/null 2>&1; then
    echo "✅ node is already installed: $(command -v node)"
else
    # Install nodejs
    ./install_nodejs.sh
fi


if command -v uv > /dev/null 2>&1; then
    echo "✅ uv is already installed: $(command -v uv)"
else
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi
