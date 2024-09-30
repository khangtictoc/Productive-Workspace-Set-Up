#! /usr/bin/fish

####### Run for FISH only ######
# Recommend theme
# https://ohmyposh.dev/docs/themes
# 'craver', 'easy-term'
set THEME "easy-term"
set APPLIED_SHELL "fish"
oh-my-posh init $APPLIED_SHELL --config ~/.cache/oh-my-posh/themes/$THEME.omp.json > ~/.oh-my-posh-init
source ~/.oh-my-posh-init
echo -n "[ -f ~/.oh-my-posh-init ] && source ~/.oh-my-posh-init" | tee -a ~/.config/fish/config.fish