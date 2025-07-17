#! /bin/bash

####### Run for ZSH only ######
# Recommend theme
# https://ohmyposh.dev/docs/themes
# 'craver', 'easy-term'

# Check if .zshrc file exists, if not, create it
if [ ! -f ~/.zshrc ]; then
    touch ~/.zshrc
fi

# Write the theme configuration to .zshrc
cat << 'EOF' >> ~/.zshrc
OH_MY_POSH_THEME="kushal"
eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/$OH_MY_POSH_THEME.omp.json)"
EOF



# Check if .bashrc already sources .oh-my-posh-init
if grep -Fxq "[ -f ~/.oh-my-posh-init ] && source ~/.oh-my-posh-init" ~/.bashrc; then
    echo "Bash file config has already source the ~/.oh-my-posh-init at bash startup. NO MODIFY !!!"
else
    echo "exec zsh" | tee -a ~/.bashrc
    echo "\nFish file config will source the ~/.oh-my-posh-init at fish startup". MODIFY SUCCESSFULLY !!!"
fi