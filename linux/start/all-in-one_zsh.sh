# Update & Upgrade system

# Install necessary packages

# Install Oh-my-posh

#!/bin/bash

## SOURCE DOTFILES
echo "============ START SOURCING DOTFILES ============"
# Array of URLs
urls=(
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/advance_function/.utilities"
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/command_extension/.extension_aliases"
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/git/.git_aliases"
    "https://raw.githubusercontent.com/khangatmercatus/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/kubernetes/helm-aliases/.helm_aliases"
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/kubernetes/kubectl-aliases/.kubectl_aliases"
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/system-aliases/.system_aliases"
)

DOTFILES_DIRNAME=dotfiles
mkdir -p ~/$DOTFILES_DIRNAME

for url in "${urls[@]}"; do
    filename=$(basename "$url")
    wget "$url" -O ~/$DOTFILES_DIRNAME/$filename
done

cat << EOF >> ~/.zshrc
if [[ -n $PS1 ]]; then
    DOTFILES_DIRNAME=dotfiles
    for file in ~/$DOTFILES_DIRNAME/.*; do
        if [[ -r $file ]]; then
            source $file
        fi
    done
fi
EOF

echo "============ FINISH SOURCING DOTFILES ============"

## SET UP GIT
echo "============ SET UP GIT ============"

# Aliases
GITCONFIG_DIRNAME=git_config
mkdir -p ~/$GITCONFIG_DIRNAME
wget "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/git/git_aliases.txt" -O ~/$GITCONFIG_DIRNAME/git_aliases.txt
git config --global include.path ~/$GITCONFIG_DIRNAME/git_aliases.txt

git config --global user.email "tranhoangkhang09112001@gmail.com"
git config --global user.name "khangtictoc"
git config --global credential.helper store

echo "============ FINISH SET UP GIT  ============"