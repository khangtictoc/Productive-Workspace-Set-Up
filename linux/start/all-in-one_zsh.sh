#!/usr/bin/env bash

set -e

# --- Global variables --------------------------

SHELL_PROFILE="$HOME/.zshrc"
GITCONFIG_DIRNAME=git_config
DOTFILES_DIRNAME=dotfiles
MOTD_DIR="$HOME/.my-motd"
DEFAULT_GIT_PROFILE=khangtictoc
GIT_ALIAS_FOLDER_URL=https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias

DOTFILES_URLS=(
    "$GIT_ALIAS_FOLDER_URL/command_extension/.extension_aliases"
    "$GIT_ALIAS_FOLDER_URL/command_extension/.misc_aliases"
    "$GIT_ALIAS_FOLDER_URL/git/.git_aliases"
    "$GIT_ALIAS_FOLDER_URL/kubernetes/helm-aliases/.helm_aliases"
    "$GIT_ALIAS_FOLDER_URL/kubernetes/kubectl-aliases/.kubectl_aliases"
    "$GIT_ALIAS_FOLDER_URL/system-aliases/.system_aliases"
    "$GIT_ALIAS_FOLDER_URL/iac/terraform/.terraform_aliases"
    "$GIT_ALIAS_FOLDER_URL/iac/terraform/.terragrunt_aliases"
    "$GIT_ALIAS_FOLDER_URL/kubernetes/docker/.docker_aliases"
    "$GIT_ALIAS_FOLDER_URL/cloud/aws/.aws_aliases"
    "https://raw.githubusercontent.com/rupa/z/refs/heads/master/z.sh"
)

DOTFILES_SOURCE_SCRIPT="

# --- SOURCE DOTFILES SCRIPT ----------------------------

# Source dotfiles if the shell is 'interactive'
if [[ -n \$PS1 ]]; then
    DOTFILES_DIRNAME=dotfiles
    for file in ~/$DOTFILES_DIRNAME/{*,.*}; do
        if [[ -r \$file ]]; then
            source \$file
        fi
    done
fi

"

SHELL_EXPORTS='

# --- ENVIRONMENT CREDENTIALS ----------------------------

export AWS_ACCESS_KEY_ID="DummyValue"
export AWS_SECRET_ACCESS_KEY="DummyValue"

export ARM_TENANT_ID="DummyValue"
export ARM_SUBSCRIPTION_ID="DummyValue"
export ARM_CLIENT_ID="DummyValue"
export ARM_CLIENT_SECRET="DummyValue"

export HCP_CLIENT_ID=DummyValue
export HCP_CLIENT_SECRET=DummyValue

export VAULT_ADDR="DummyValue"
export VAULT_NAMESPACE="DummyValue"
export VAULT_TOKEN=DummyValue

export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
export M2_HOME=/opt/maven
export PATH="$M2_HOME/bin:$PATH"

'

# --- Functions  --------------------------

function prerequite-install(){
    sudo apt update
    sudo apt install -y dos2unix zsh curl unzip vim
}

function zsh-theme-install(){
    curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/theme/oh-my-posh/install.sh | bash
    curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/theme/oh-my-posh/configure-zsh.sh | bash
}

function zsh-plugins-install(){
    curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/plugins/fzf/install.sh | bash 
    curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/shell/zsh/plugins.sh | bash
}

## SOURCE DOTFILES
function source-dotfiles() {
    
    echo "[INFO] Downloading Dotfiles ..."
    mkdir -p ~/$DOTFILES_DIRNAME

    for url in "${DOTFILES_URLS[@]}"; do
        filename=$(basename "$url")
        echo "- Downloading 🔨 $filename..."
        wget -q "$url" -O ~/$DOTFILES_DIRNAME/$filename
    done
    echo

    echo "[INFO] Convert Files For Linux compatibility"
    find ~/$DOTFILES_DIRNAME -iname ".*" -type f | xargs -I {} bash -c "dos2unix {}"

    echo "[INFO] Add Script For Shell Startup"
    if ! grep -Fxq '# --- SOURCE DOTFILES SCRIPT ----------------------------' $SHELL_PROFILE; then
        cat <<EOF >> $SHELL_PROFILE
$DOTFILES_SOURCE_SCRIPT
EOF
        log_success "✅ - Dotfiles have been sourced successfully!${NC}"
    else
        log_success "✅ - Dotfiles have already been sourced!${NC}"
    fi

    
}


function setup-git--profile(){
    echo "[INFO] Configuring Git Profile (Default Workspace) ... "
    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/profile/$DEFAULT_GIT_PROFILE.sh" | bash

    log_info "Default profile ${CYAN}$DEFAULT_GIT_PROFILE${NC} is selected!"
    sleep 1
}

function setup-git--hooks(){
    echo
    echo "[INFO] Configure client-side Git Hook - Prevent critical/leaked data"
    mkdir -p ~/$GITCONFIG_DIRNAME/hooks

    git config --global core.hooksPath ~/$GITCONFIG_DIRNAME/hooks
    git config --global credential.helper store
    git config --global core.editor "vim"
    git config --global include.path "~/$GITCONFIG_DIRNAME/alias/git_aliases.txt"

    wget -q "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/hook/pre-push" -O ~/$GITCONFIG_DIRNAME/hooks/pre-push
    #sudo chown $(whoami):$(whoami) ~/$GITCONFIG_DIRNAME/hooks/pre-push
    chmod +x ~/$GITCONFIG_DIRNAME/hooks/pre-push

    log_success "✅ - Git hook has been configured at path ${CYAN}~/$GITCONFIG_DIRNAME/hooks/pre-push${NC}!"
}

function setup-git--alias(){
    echo
    echo "[Configure: Git Aliases] Manual script"

    mkdir -p ~/$GITCONFIG_DIRNAME/alias/
    wget -q "$GIT_ALIAS_FOLDER_URL/git/git_aliases.txt" -O ~/$GITCONFIG_DIRNAME/alias/git_aliases.txt

    log_success "✅ - Git aliases have been configured at path ${CYAN}~/$GITCONFIG_DIRNAME/alias/git_aliases.txt${NC}!"
}

function setup-git(){
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
        log_success "✅ - Added 'wslview' as browser's view"
    else
        log_info "Existed ℹ️ - Already allowed 'wslview' as browser's view in ${SHELL_PROFILE}"
    fi

    # Ensure security for ~/.kube/config
    if [ -f "$HOME/.kube/config" ]; then
        if ! grep -Fxq "chmod 600 \"$HOME/.kube/config\"" ${SHELL_PROFILE}; then
            echo "chmod 600 \"$HOME/.kube/config\"" >> ${SHELL_PROFILE}
            log_success "✅ - Added permission 600 for ~/.kube/config in ${SHELL_PROFILE}"
        else
            log_info "Existed ℹ️ - Permission 600 for ~/.kube/config is already set in ${SHELL_PROFILE}"
        fi
    else
        log_warn "Skipped! ⚠️ - '~/.kube/config' does not exist. No changes made."
    fi


    # Add "$HOME/.local/bin" as executable path to PATH
    if ! grep -Fxq 'export PATH="$HOME/.local/bin:$PATH"' ${SHELL_PROFILE}; then
        echo "export PATH="$HOME/.local/bin:$PATH"" >> ${SHELL_PROFILE}
        log_success "✅ - Add "$HOME/.local/bin" as executable path to PATH"
    else
        log_info "Existed ℹ️ - Already added "$HOME/.local/bin" as executable path to PATH"
    fi

    # To provide credentials to some cloud platforms

    if ! grep -Fxq '# --- ENVIRONMENT CREDENTIALS ----------------------------' ${SHELL_PROFILE}; then
        cat <<EOF >> $SHELL_PROFILE
$SHELL_EXPORTS
EOF
        log_success "✅ - Set 'DummyValue' for Cloud Credentials"
    else
        log_info "Existed ℹ️ - Already Set 'DummyValue' for Cloud Credentials"
    fi
}



function shell-config--motd(){
    option=$1

    echo
    echo "============ MOTD ============"
    if [ ! -d "$MOTD_DIR" ]; then
        mkdir -p "$MOTD_DIR"
        log_success "✅ - Created MOTD directory at $MOTD_DIR"
    fi
    
    case $option in
        "neofetch")
            shell-config--motd--neofetch
            ;;
        "self-custom")
            shell-config--motd--self-custom
            ;;
        *)
            log_warn "No MOTD option provided or unrecognized option. Skipping MOTD setup.${NC}"
            ;;
    esac
}

function shell-config--motd--self-custom(){
    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/startup/self-customed/motd.sh" -o "$MOTD_DIR/motd.sh"
    chmod +x "$MOTD_DIR/motd.sh"

    SOURCE_MOTD_TXT="bash $MOTD_DIR/motd.sh | lolcat"
    if ! grep -Fxq "$SOURCE_MOTD_TXT" "$SHELL_PROFILE"; then
        echo "$SOURCE_MOTD_TXT" >> "$SHELL_PROFILE"
        log_success "✅ - MOTD script has been sourced in $SHELL_PROFILE"
    else
        log_info "Existed ℹ️ - MOTD script is already sourced in $SHELL_PROFILE"
    fi
}

function shell-config--motd--neofetch(){
    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/startup/neofetch/motd.sh" -o "$MOTD_DIR/motd.sh"
    chmod +x "$MOTD_DIR/motd.sh"
    log_success "✅ - Neofetch MOTD script downloaded!"

    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/startup/neofetch/cat_in_the_box.txt" -o "$MOTD_DIR/cat_in_the_box.txt"
    log_success "✅ - ASCII art theme downloaded!"

    curl -sL "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/terminal/ui/startup/neofetch/config.conf" -o "$HOME/.config/neofetch/config.conf"
    log_success "✅ - Config Installed"
    
    SOURCE_MOTD_TXT="bash $MOTD_DIR/motd.sh $MOTD_DIR/cat_in_the_box.txt"
    if ! grep -Fxq "$SOURCE_MOTD_TXT" "$SHELL_PROFILE"; then
        echo "$SOURCE_MOTD_TXT" >> "$SHELL_PROFILE"
        log_success "✅ - Neofetch MOTD script has been sourced in $SHELL_PROFILE"
    else
        log_info "Existed ℹ️ - Neofetch MOTD script is already sourced in $SHELL_PROFILE"
    fi
}

function shell-config(){
    shell-config--profile
    shell-config--motd "neofetch"
}

function setup-command-autocompletion() {

    # Define list (array)
    COMPLETIONS=(
        "source <(kubectl completion zsh)"
        "source <(helm completion zsh)"
        "source <(oh-my-posh completion zsh)"
    )

    # Optional: Friendly names for logging
    NAMES=(
        "Kubectl"
        "Helm"
        "Oh-My-Posh"
    )

    # Loop through array
    for i in "${!COMPLETIONS[@]}"; do
        LINE="${COMPLETIONS[$i]}"
        NAME="${NAMES[$i]}"

        if grep -Fxq "$LINE" "$SHELL_PROFILE"; then
            echo "[INFO] Existed ℹ️ - $NAME completion has already been configured! No changes"
        else
            echo "$LINE" >> "$SHELL_PROFILE"
            log_success "✅ - $NAME completion has been configured!"
        fi
    done
}

function post-actions(){
    log_highlight "Please restart your terminal or run 'source $SHELL_PROFILE' to apply the changes.${NC}"
    echo
    log_highlight "What's next?${NC}"
    log_highlight "  - Set up Cloud Credentials${NC}"
    log_highlight "  - Install your tools${NC}"
}


# --- MAIN function --------------------------

function main(){
    echo
    echo "============ PREREQUITES INSTALLTIONS ============"
    echo
    prerequite-install

    echo
    echo "============ IMPORT EXTERNAL LIBS ============"
    echo
    source <(curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/library/bash/ansi_color.sh)
    init-ansicolor

    echo
    echo "============ ZSH THEME INSTALLATION ============"
    echo
    zsh-theme-install

    echo
    echo "============ ZSH PLUGINS INSTALLATION ============"
    echo
    zsh-plugins-install

    echo
    echo "============ SOURCE DOTFILES ============"
    echo
    source-dotfiles

    echo
    echo "============ GIT SETUP ============"
    echo
    setup-git

    echo
    echo "============ CONFIGURE SHELL ============"
    echo
    shell-config

    echo
    echo "============ COMMAND AUTOCOMPLETION ============"
    echo
    setup-command-autocompletion

    echo
    echo "============ POST ACTIONS ============"
    echo
    post-actions
    
}

main "$@" 