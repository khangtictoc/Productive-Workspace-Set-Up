#! /bin/bash

####### Run for ZSH only ######
# Recommend theme
# https://ohmyposh.dev/docs/themes
# 'craver', 'easy-term', 'kushal'


# Check if .zshrc file exists, if not, create it
if [ ! -f ~/.zshrc ]; then
    touch ~/.zshrc
fi

# Write the theme configuration to .zshrc
if grep -Fxq "OH_MY_POSH_THEME" ~/.zshrc; then
    echo "ZSH file config has already set the OH_MY_POSH_THEME variable. NO MODIFY !!!"
else
    cat << 'EOF' >> ~/.zshrc
OH_MY_POSH_THEME="kushal"
eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/$OH_MY_POSH_THEME.omp.json)"
EOF
    echo "ZSH file config will set the OH_MY_POSH_THEME variable. MODIFY SUCCESSFULLY !!!"
fi

# Check if .zshrc already sources .oh-my-posh-init
if grep -Fxq "[ -f ~/.oh-my-posh-init ] && source ~/.oh-my-posh-init" ~/.zshrc; then
    echo "ZSH file config has already source the ~/.oh-my-posh-init at zsh startup. NO MODIFY !!!"
else
    echo "ZSH file config will source the ~/.oh-my-posh-init at zsh startup. MODIFY SUCCESSFULLY !!!"
fi