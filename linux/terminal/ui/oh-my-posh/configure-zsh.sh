#! /bin/bash

####### Run for FISH only ######
# Recommend theme
# https://ohmyposh.dev/docs/themes
# 'craver', 'easy-term'
cat << EOF > ~/.zshrc
THEME="easy-term"
eval "\$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/\$THEME.omp.json)"
EOF

if grep -Fxq "[ -f ~/.oh-my-posh-init ] && source ~/.oh-my-posh-init" ~/.bashrc; then
    echo "Bash file config has already source the ~/.oh-my-posh-init at bash startup. NO MODIFY !!!"
else
    echo "exec zsh" | tee -a ~/.bashrc
    echo "\nFish file config will source the ~/.oh-my-posh-init at fish startup". MODIFY SUCCESSFULLY !!!
fi
