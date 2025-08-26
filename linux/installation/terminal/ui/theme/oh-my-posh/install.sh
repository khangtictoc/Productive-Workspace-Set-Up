####### Run for BASH only ######
#! /bin/bash

sudo apt install -y unzip curl
curl -s https://ohmyposh.dev/install.sh | bash -s

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
fi


