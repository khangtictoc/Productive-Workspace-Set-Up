#!/bin/bash

SHELL_PROFILE="$HOME/.bashrc"

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
    "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/cloud/aws/.aws_aliases"
    "https://raw.githubusercontent.com/rupa/z/refs/heads/master/z.sh"
)

DOTFILES_DIRNAME=dotfiles
mkdir -p ~/$DOTFILES_DIRNAME

for url in "${repo_urls[@]}"; do
    filename=$(basename "$url")
    echo "🔨 Downloading $filename..."
    wget -q "$url" -O ~/$DOTFILES_DIRNAME/$filename
done

find ~/$DOTFILES_DIRNAME -iname ".*" -type f | xargs -I {} bash -c "dos2unix {}"

if ! grep -Fxq '###### START CUSTOM SCRIPT ######' ~/.zshrc; then
    cat << EOF >> ~/.zshrc
###### START CUSTOM SCRIPT ######
# Source dotfiles if the shell is interactive
if [[ -n \$PS1 ]]; then
    DOTFILES_DIRNAME=dotfiles
    for file in ~/\$DOTFILES_DIRNAME/{*,.*}; do
        if [[ -r \$file ]]; then
            source \$file
        fi
    done
fi

# Print system information
macchina --theme Hydrogen

EOF
fi

echo "✅ Dotfiles have been applied successfully!"

## SET UP GIT
echo "============ SET UP GIT ============"
# Aliases
echo "[Install] Configuration files for git..."
GITCONFIG_DIRNAME=git_config
GITPROFILE=khangtictoc
mkdir -p ~/$GITCONFIG_DIRNAME
echo "Configuring Git Aliases ..."
mkdir -p ~/$GITCONFIG_DIRNAME/alias/
wget -q "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/git/git_aliases.txt" -O ~/$GITCONFIG_DIRNAME/alias/git_aliases.txt
echo "✅ Git aliases have been configured successfully!"
echo "Configure Default Git Workspace ..."
curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/profile/$GITPROFILE.sh" | bash

echo "The default git profile $GITPROFILE is selected!"
sleep 1
echo "Configuring Global Client-side Git Hook ..."
mkdir -p ~/$GITCONFIG_DIRNAME/hooks
git config --global core.hooksPath ~/$GITCONFIG_DIRNAME/hooks
git config --global credential.helper store
git config --global core.editor "vim"
git config --global include.path "~/$GITCONFIG_DIRNAME/git_aliases.txt"
wget -q "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/hook/pre-push" -O ~/$GITCONFIG_DIRNAME/hooks/pre-push
sudo chown $(whoami):$(whoami) ~/$GITCONFIG_DIRNAME/hooks/pre-push
chmod +x ~/$GITCONFIG_DIRNAME/hooks/pre-push
echo "✅ Git hook has been configured successfully!"

## SET UP ZSH PROFILES
echo "============ SET UP ZSH PROFILES ============"
# Allow exposing browser in terminal
if ! grep -Fxq "export BROWSER=wslview" ~/.zshrc; then
    echo "export BROWSER=wslview" >> ~/.zshrc
    echo "✅ Added 'wslview' as browser's view"
else
    echo "✅ 'BROWSER=wslview' already exists in ~/.zshrc"
fi

## SET UP MESSAGE OF THE DAY (MOTD)
echo "============ SET UP MOTD ============"
MOTD_DIR="$HOME/.my-motd"
if [ ! -d "$MOTD_DIR" ]; then
    mkdir -p "$MOTD_DIR"
    echo "Created MOTD directory at $MOTD_DIR"
fi
curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/terminal-startup/self-customed/motd.sh" -o "$MOTD_DIR/motd.sh"
chmod +x "$MOTD_DIR/motd.sh"
if ! grep -Fxq "source $MOTD_DIR/motd.sh" "$SHELL_PROFILE"; then
    echo "bash $MOTD_DIR/motd.sh | lolcat" >> "$SHELL_PROFILE"
    echo "✅ MOTD script has been sourced in ~/.zshrc"
else
    echo "✅ MOTD script is already sourced in ~/.zshrc"
fi

## SET UP COMMAND AUTOCOMPLETION
echo "============ SET UP COMMAND AUTOCOMPLETION ============"
KUBECTL_COMPL="source <(kubectl completion zsh)"
HELM_COMPL="source <(helm completion zsh)"


if grep -Fxq "$KUBECTL_COMPL" "$SHELL_PROFILE"; then
    echo "✅ Kubectl completion has already been configured! No changes"
else
    echo "$KUBECTL_COMPL" >> "$SHELL_PROFILE"
    echo "✅ Kubectl completion are configured!"
fi


if grep -Fxq "$HELM_COMPL" "$SHELL_PROFILE"; then
    echo "✅ Helm completion has already been configured! No changes"
else
    echo "$HELM_COMPL" >> "$SHELL_PROFILE"
    echo "✅ Helm completion are configured!"
fi