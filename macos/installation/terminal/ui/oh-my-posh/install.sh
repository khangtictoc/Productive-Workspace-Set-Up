####### Run for BASH only ######
#! /bin/bash

sudo apt install -y unzip curl
curl -s https://ohmyposh.dev/install.sh | bash -s

#### To list all available fonts
# oh-my-posh font install
# oh-my-posh font install <font-name>

#### If command is not executable
if ! grep -Fxq "export PATH=\$PATH:/Users/trankhang/.local/bin" ~/.zshrc; then
    echo 'export PATH=$PATH:/Users/trankhang/.local/bin' >> ~/.zshrc
fi

