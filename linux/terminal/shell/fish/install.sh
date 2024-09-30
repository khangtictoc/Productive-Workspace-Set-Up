#! /bin/bash

sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt update
sudo apt install fish -y
echo "fish" | tee -a $HOME/.bashrc