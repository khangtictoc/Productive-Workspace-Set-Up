#!/bin/bash

function init-ansicolor(){
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color - resets to default
}

function init-config(){
    SHELL_PROFILE="$HOME/.bashrc"
    GITCONFIG_DIRNAME=git_config
    DOTFILES_DIRNAME=dotfiles
    DEFAULT_GIT_PROFILE=khangtictoc
    DOTFILES_URLS=(
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
}

function source-dotfiles() {
    ## SOURCE DOTFILES
    echo
    echo "============ SOURCING DOTFILES ============"
    mkdir -p ~/$DOTFILES_DIRNAME

    for url in "${DOTFILES_URLS[@]}"; do
        filename=$(basename "$url")
        echo "🔨 Downloading $filename..."
        wget -q "$url" -O ~/$DOTFILES_DIRNAME/$filename
    done
    echo

    echo
    echo "Convert EOL for OS compatibility"
    find ~/$DOTFILES_DIRNAME -iname ".*" -type f | xargs -I {} bash -c "dos2unix {}"
    echo

    if ! grep -Fxq '###### START CUSTOM SCRIPT ######' $SHELL_PROFILE; then
        cat << EOF >> $SHELL_PROFILE
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

EOF
    fi

echo "✅ ${GREEN}Dotfiles have been sourced successfully!${NC}"
}


function setup-git--profile(){
    echo "[Configure: Git Profile] Default Workspace"
    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/profile/$DEFAULT_GIT_PROFILE.sh" | bash

    echo "Default profile ${GREEN}$DEFAULT_GIT_PROFILE${NC} is selected!"
    sleep 1
}

function setup-git--hooks(){
    echo
    echo "[Configure: Client-side Git Hook] Prevent critical/leaked data"
    mkdir -p ~/$GITCONFIG_DIRNAME/hooks

    git config --global core.hooksPath ~/$GITCONFIG_DIRNAME/hooks
    git config --global credential.helper store
    git config --global core.editor "vim"
    git config --global include.path "~/$GITCONFIG_DIRNAME/alias/git_aliases.txt"

    wget -q "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/hook/pre-push" -O ~/$GITCONFIG_DIRNAME/hooks/pre-push
    sudo chown $(whoami):$(whoami) ~/$GITCONFIG_DIRNAME/hooks/pre-push
    chmod +x ~/$GITCONFIG_DIRNAME/hooks/pre-push

    echo "✅ Git hook has been configured at path ${GREEN}~/$GITCONFIG_DIRNAME/hooks/pre-push${NC}!"
}

function setup-git--alias(){
    echo
    echo "[Configure: Git Aliases] Manual script"

    mkdir -p ~/$GITCONFIG_DIRNAME/alias/
    wget -q "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/git/git_aliases.txt" -O ~/$GITCONFIG_DIRNAME/alias/git_aliases.txt

    echo "✅ Git aliases have been configured at path ${GREEN}~/$GITCONFIG_DIRNAME/alias/git_aliases.txt${NC}!"
}

function setup-git(){
    echo
    echo "============ GIT ============"
    setup-git--profile
    setup-git--hooks
    setup-git--alias
}

function shell-config--profile(){
    echo
    echo "============ SHELL PROFILES ============"
    # Allow exposing browser in terminal
    if ! grep -Fxq "export BROWSER=wslview" ${SHELL_PROFILE}; then
        echo "export BROWSER=wslview" >> ${SHELL_PROFILE}
        echo "✅ ${GREEN}Added 'wslview' as browser's view${NC}"
    else
        echo "✅ ${GREEN}'BROWSER=wslview' already exists in ${SHELL_PROFILE}${NC}"
    fi
}

function shell-config--motd(){
    echo
    echo "============ MOTD ============"
    MOTD_DIR="$HOME/.my-motd"
    if [ ! -d "$MOTD_DIR" ]; then
        mkdir -p "$MOTD_DIR"
        echo "Created MOTD directory at $MOTD_DIR"
    fi
    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/startup/self-customed/motd.sh" -o "$MOTD_DIR/motd.sh"
    chmod +x "$MOTD_DIR/motd.sh"

    SOURCE_MOTD_TXT="bash $MOTD_DIR/motd.sh | lolcat"
    if ! grep -Fxq "" "$SHELL_PROFILE"; then
        echo "$SOURCE_MOTD_TXT" >> "$SHELL_PROFILE"
        echo "✅ ${GREEN}MOTD script has been sourced in $SHELL_PROFILE${NC}"
    else
        echo "✅ ${GREEN}MOTD script is already sourced in $SHELL_PROFILE${NC}"
    fi
}

function shell-config(){
    shell-config--profile
    shell-config--motd
}

function setup-command-autocompletion(){
    echo
    echo "============ COMMAND AUTOCOMPLETION ============"
    KUBECTL_COMPL_TXT="source <(kubectl completion zsh)"
    HELM_COMPL_TXT="source <(helm completion zsh)"


    if grep -Fxq "$KUBECTL_COMPL_TXT" "$SHELL_PROFILE"; then
        echo "✅ ${GREEN}Kubectl completion has already been configured! No changes${NC}"
    else
        echo "$KUBECTL_COMPL_TXT" >> "$SHELL_PROFILE"
        echo "✅ ${GREEN}Kubectl completion has been configured!${NC}"
    fi


    if grep -Fxq "$HELM_COMPL_TXT" "$SHELL_PROFILE"; then
        echo "✅ ${GREEN}Helm completion has already been configured! No changes${NC}"
    else
        echo "$HELM_COMPL_TXT" >> "$SHELL_PROFILE"
        echo "✅ ${GREEN}Helm completion has been configured!${NC}"
    fi
}

function main(){
    init-ansicolor
    init-config
    source-dotfiles
    setup-git
    shell-config
    setup-command-autocompletion

    echo
    echo "Please restart your terminal or run 'source $SHELL_PROFILE' to apply the changes."
}

main "$@" 