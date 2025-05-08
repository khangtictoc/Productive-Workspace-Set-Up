#!/bin/bash

## SOURCE DOTFILES
echo "============ START SOURCING DOTFILES ============"
# Array of repo_urls
repo_urls=(
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/command_extension/.extension_aliases"
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/git/.git_aliases"
    "https://raw.githubusercontent.com/khangatmercatus/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/kubernetes/helm-aliases/.helm_aliases"
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/kubernetes/kubectl-aliases/.kubectl_aliases"
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/system-aliases/.system_aliases"
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/iac/terraform/.terraform_aliases"
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/iac/terraform/.terragrunt_aliases"
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/kubernetes/docker/.docker_aliases"
)

DOTFILES_DIRNAME=dotfiles
mkdir -p ~/$DOTFILES_DIRNAME

for url in "${repo_urls[@]}"; do
    filename=$(basename "$url")
    echo "Downloading $filename..."
    wget -q "$url" -O ~/$DOTFILES_DIRNAME/$filename
done

find ~/$DOTFILES_DIRNAME -iname ".*" -type f | xargs -I {} bash -c "dos2unix {}"

if ! grep -Fxq 'if [[ -n $PS1 ]]; then' ~/.zshrc; then
    cat << EOF >> ~/.zshrc
if [[ -n \$PS1 ]]; then
    DOTFILES_DIRNAME=dotfiles
    for file in ~/\$DOTFILES_DIRNAME/.*; do
        if [[ -r \$file ]]; then
            source \$file
        fi
    done
fi
EOF
fi

## SET UP GIT
echo "============ SET UP GIT ============"
# Aliases
echo "Configuring Git Aliases ..."
GITCONFIG_DIRNAME=git_config
GITCONFIG_PROFILE=khangtictoc
mkdir -p ~/$GITCONFIG_DIRNAME
echo "Installing configuration files for git..."
mkdir -p ~/$GITCONFIG_DIRNAME/alias/git_aliases.txt
wget -q "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/git/git_aliases.txt" -O ~/$GITCONFIG_DIRNAME/alias/git_aliases.txt
wget -q "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/git/profile/$GITCONFIG_PROFILE" -O ~/.gitconfig

echo "The default git profile $GITCONFIG_PROFILE is selected!"
sleep 1
echo "Configuring Global Client-side Git Hook ..."
mkdir -p ~/$GITCONFIG_DIRNAME/hooks
git config --global core.hooksPath ~/$GITCONFIG_DIRNAME/hooks
wget -q "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/git/hook/pre-push" -O ~/$GITCONFIG_DIRNAME/hooks/pre-push
sudo chown $(whoami):$(whoami) ~/$GITCONFIG_DIRNAME/hooks/pre-push
chmod +x ~/$GITCONFIG_DIRNAME/hooks/pre-push

## SET UP ZSH PROFILES
echo "============ SET UP ZSH PROFILES ============"
# Check if the line exists in ~/.zshrc
if ! grep -Fxq "export BROWSER=wslview" ~/.zshrc; then
    echo "export BROWSER=wslview" >> ~/.zshrc
    echo "Added 'wslview' as browser's view"
else
    echo "'BROWSER=wslview' already exists in ~/.zshrc"
fi