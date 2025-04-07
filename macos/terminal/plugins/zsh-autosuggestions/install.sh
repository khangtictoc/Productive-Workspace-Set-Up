#! /bin/bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i '' '/^plugins=(/ s/)/ zsh-autosuggestions)/' ~/.zshrc