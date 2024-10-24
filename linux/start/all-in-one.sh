#! /usr/bin/fish

set DOTFILES_DIRNAME dotfiles

mkdir ~/$DOTFILES_DIRNAME

wget https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/advance_function/.utilities_fish -P ~/$DOTFILES_DIRNAME
wget https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/command_extension/.extension_aliases -P ~/$DOTFILES_DIRNAME
wget https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/git/.git_aliases -P ~/$DOTFILES_DIRNAME
wget https://raw.githubusercontent.com/khangatmercatus/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/kubernetes/helm-aliases/.helm_aliases -P ~/$DOTFILES_DIRNAME
wget https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/kubernetes/kubectl-aliases/.kubectl_aliases -P ~/$DOTFILES_DIRNAME
wget https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/system-aliases/.system_aliases -P ~/$DOTFILES_DIRNAME


find ~/$DOTFILES_DIRNAME -type f | xargs -I {} bash -c "source {}"