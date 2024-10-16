#! /bin/bash

set DOTFILES_DIRNAME dotfiles
## advance_function
mkdir ~/$DOTFILES_DIRNAME
wget https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/advance_function/.utilities -P ~/$DOTFILES_DIRNAME

find ~/$DOTFILES_DIRNAME -type f | xargs -I {} bash -c "source {}"