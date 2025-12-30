#!/usr/bin/env bash

set -e

function init-config(){
    SHELL_PROFILE="$HOME/.zshrc"
    GITCONFIG_DIRNAME=git_config
    DOTFILES_DIRNAME=dotfiles
    DEFAULT_GIT_PROFILE=khangtictoc
    DOTFILES_URLS=(
        "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/command_extension/.extension_aliases"
        "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/command_extension/.misc_aliases"
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

function zsh-theme-install(){
    echo
    echo "============ ZSH THEME INSTALLATION ============"
    curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/theme/oh-my-posh/install.sh | bash
    curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/theme/oh-my-posh/configure-zsh.sh | bash
}

function zsh-plugins-install(){
    echo
    echo "============ ZSH PLUGINS INSTALLATION ============"
    curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/plugins/fzf/install.sh | bash 
    curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/shell/zsh/plugins.sh | bash
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
    echo "[INFO] Convert EOL for OS compatibility"
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

echo -e "${GREEN}[SUCCESS] ✅ Dotfiles have been sourced successfully!${NC}"
}


function setup-git--profile(){
    echo "[INFO] Configuring Git Profile (Default Workspace) ... "
    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/profile/$DEFAULT_GIT_PROFILE.sh" | bash

    echo -e "[INFO] Default profile ${GREEN}$DEFAULT_GIT_PROFILE${NC} is selected!"
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
    #sudo chown $(whoami):$(whoami) ~/$GITCONFIG_DIRNAME/hooks/pre-push
    chmod +x ~/$GITCONFIG_DIRNAME/hooks/pre-push

    echo -e "[INFO] ✅ Git hook has been configured at path ${YELLOW}~/$GITCONFIG_DIRNAME/hooks/pre-push${NC}!"
}

function setup-git--alias(){
    echo
    echo "[Configure: Git Aliases] Manual script"

    mkdir -p ~/$GITCONFIG_DIRNAME/alias/
    wget -q "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/git/git_aliases.txt" -O ~/$GITCONFIG_DIRNAME/alias/git_aliases.txt

    echo -e "✅ Git aliases have been configured at path ${YELLOW}~/$GITCONFIG_DIRNAME/alias/git_aliases.txt${NC}!"
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
        echo -e "[INFO] Update: Added 'wslview' as browser's view"
    else
        echo -e "[INFO] Existed: Already allowed 'wslview' as browser's view in ${SHELL_PROFILE}"
    fi

    # Ensure security for ~/.kube/config
    if [ -f "$HOME/.kube/config" ]; then
        if ! grep -Fxq "chmod 600 \"$HOME/.kube/config\"" ${SHELL_PROFILE}; then
            echo "chmod 600 \"$HOME/.kube/config\"" >> ${SHELL_PROFILE}
            echo -e "[INFO] Update: Added permission 600 for ~/.kube/config in ${SHELL_PROFILE}"
        else
            echo -e "[INFO] Existed: Permission 600 for ~/.kube/config is already set in ${SHELL_PROFILE}"
        fi
    else
        echo -e "${YELLOW}[WARNING]${NC}Skipped! '~/.kube/config' does not exist. No changes made."
    fi


    # Add "$HOME/.local/bin" as executable path to PATH
    if ! grep -Fxq 'export PATH="$HOME/.local/bin:$PATH"' ${SHELL_PROFILE}; then
        echo "export PATH="$HOME/.local/bin:$PATH"" >> ${SHELL_PROFILE}
        echo -e "[INFO] Update: Add "$HOME/.local/bin" as executable path to PATH"
    else
        echo -e "[INFO] Existed: Already added "$HOME/.local/bin" as executable path to PATH"
    fi
}



function shell-config--motd(){
    option=$1

    echo
    echo "============ MOTD ============"
    MOTD_DIR="$HOME/.my-motd"
    if [ ! -d "$MOTD_DIR" ]; then
        mkdir -p "$MOTD_DIR"
        echo "[INFO] Created MOTD directory at $MOTD_DIR"
    fi
    
    case $option in
        "neofetch")
            shell-config--motd--neofetch
            ;;
        "self-custom")
            shell-config--motd--self-custom
            ;;
        *)
            echo -e "${YELLOW}[WARNING] No MOTD option provided or unrecognized option. Skipping MOTD setup.${NC}"
            ;;
    esac
}

function shell-config--motd--self-custom(){
    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/startup/self-customed/motd.sh" -o "$MOTD_DIR/motd.sh"
    chmod +x "$MOTD_DIR/motd.sh"

    SOURCE_MOTD_TXT="bash $MOTD_DIR/motd.sh | lolcat"
    if ! grep -Fxq "" "$SHELL_PROFILE"; then
        echo "$SOURCE_MOTD_TXT" >> "$SHELL_PROFILE"
        echo -e "[INFO] Update: MOTD script has been sourced in $SHELL_PROFILE"
    else
        echo -e "[INFO] Existed: MOTD script is already sourced in $SHELL_PROFILE"
    fi
}

function shell-config--motd--neofetch(){
    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/startup/neofetch/motd.sh" -o "$MOTD_DIR/motd.sh"
    chmod +x "$MOTD_DIR/motd.sh"
    echo "[INFO] Neofetch MOTD script downloaded!"

    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/startup/neofetch/cat_in_the_box.txt" -o "$MOTD_DIR/cat_in_the_box.txt"
    echo "[INFO] ASCII art theme downloaded!"

    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/startup/neofetch/config.conf" -o "$HOME/.config/neofetch/config.conf"
    echo "[INFO] Config Installed"
    
    SOURCE_MOTD_TXT="bash $MOTD_DIR/motd.sh $MOTD_DIR/cat_in_the_box.txt"
    if ! grep -Fxq "$SOURCE_MOTD_TXT" "$SHELL_PROFILE"; then
        echo "$SOURCE_MOTD_TXT" >> "$SHELL_PROFILE"
        echo -e "${GREEN}[UPDATE]${NC} Neofetch MOTD script has been sourced in $SHELL_PROFILE"
    else
        echo -e "${GREEN}[EXIST]${NC} Neofetch MOTD script is already sourced in $SHELL_PROFILE"
    fi
}

function shell-config(){
    shell-config--profile
    shell-config--motd "neofetch"
}

function setup-command-autocompletion(){
    echo
    echo "============ COMMAND AUTOCOMPLETION ============"
    KUBECTL_COMPL_TXT="source <(kubectl completion zsh)"
    HELM_COMPL_TXT="source <(helm completion zsh)"


    if grep -Fxq "$KUBECTL_COMPL_TXT" "$SHELL_PROFILE"; then
        echo -e "[INFO] Kubectl completion has already been configured! No changes"
    else
        echo "$KUBECTL_COMPL_TXT" >> "$SHELL_PROFILE"
        echo -e "[INFO] Kubectl completion has been configured!"
    fi


    if grep -Fxq "$HELM_COMPL_TXT" "$SHELL_PROFILE"; then
        echo -e "[INFO] Helm completion has already been configured! No changes"
    else
        echo "$HELM_COMPL_TXT" >> "$SHELL_PROFILE"
        echo -e "[INFO] Helm completion has been configured!"
    fi
}

function main(){
    source <(curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/library/bash/ansi_color.sh)
    init-ansicolor
    init-config
    zsh-theme-install
    zsh-plugins-install
    source-dotfiles
    setup-git
    shell-config
    setup-command-autocompletion

    echo
    echo "${YELLOW}Please restart your terminal or run 'source $SHELL_PROFILE' to apply the changes.${NC}"
}

main "$@" 