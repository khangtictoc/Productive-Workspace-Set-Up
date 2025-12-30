#!/usr/bin/env bash

set -e

if command -v apt >/dev/null 2>&1; then
    echo "[CHECKED ✅] apt found."
    sudo apt install -y unzip curl
else
    echo "[WARNING ⚠️] This is not an Ubuntu-based system. No 'apt' found!"
fi

if command -v oh-my-posh >/dev/null 2>&1; then
    echo "[INFO] oh-my-posh is already installed."
else
    curl -s https://ohmyposh.dev/install.sh | bash -s
    echo "[INFO] oh-my-posh installation completed!"
fi

#### To list all available fonts
# oh-my-posh font install
# oh-my-posh font install <font-name>

# Check SystemOS
isGNUsed=false
isBSDsed=false
if sed --version >/dev/null 2>&1; then
    isGNUsed=true
fi
if ! sed --version >/dev/null 2>&1; then
    isBSDsed=true
fi

#### If command is not executable
if [[ "$isGNUsed" == true ]]; then
    BINARY_PATH="/usr/local/bin/"
    if ! command -v oh-my-posh &> /dev/null
    then
        echo "Command has not been executable, copy to $BINARY_PATH"
        sudo cp ~/.local/bin/oh-my-posh $BINARY_PATH
    else
        echo "Command has install successfully!"
    fi
fi

if [[ "$isBSDsed" == true ]]; then
    if ! grep -Fxq "export PATH=\$PATH:$HOME/.local/bin" ~/.zshrc; then
        echo "export PATH=\$PATH:$HOME/.local/bin" >> ~/.zshrc
    else
        echo "PATH already contains \$HOME/.local/bin"
    fi
fi


