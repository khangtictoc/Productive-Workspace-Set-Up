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
    wget "$url" -O ~/$DOTFILES_DIRNAME/$filename
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

echo "============ FINISH SOURCING DOTFILES ============"

## SET UP GIT
echo "============ SET UP GIT ============"

# Aliases
GITCONFIG_DIRNAME=git_config
GITCONFIG_PROFILE=khangtictoc
mkdir -p ~/$GITCONFIG_DIRNAME
wget "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/git/git_aliases.txt" -O ~/$GITCONFIG_DIRNAME/git_aliases.txt
wget "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/gitconfig_profile/$GITCONFIG_PROFILE" -O ~/.gitconfig

sed -i "s|git_config_dir_name|$GITCONFIG_DIRNAME|g" ~/.gitconfig
echo "The default git profile $GITCONFIG_PROFILE is selected!"

echo "============ FINISH SET UP GIT  ============"