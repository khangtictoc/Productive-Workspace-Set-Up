#! /usr/bin/fish

####### Run for FISH only ######
# Recommend theme
# https://ohmyposh.dev/docs/themes
# 'craver', 'easy-term'
cat << EOF > ~/.zshrc
THEME="easy-term"
eval "\$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/\$THEME.omp.json)"
EOF

echo "exec zsh" | tee -a ~/.bashrc