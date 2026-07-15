#! /bin/bash

# --- Global Variables (OS-aware) --------------------------------
# NOTE: These are set AFTER detect_os() is called in main()

init_globals() {
    # Recommended
    SHELL_PROFILE="$HOME/.zshrc"
    GITCONFIG_DIRNAME=git_config
    DOTFILES_DIRNAME=dotfiles
    MOTD_DIR="$HOME/.my_motd"
    TOOLING_REPO="DevOps-Tools-Installation-Scripts"
    ASCII_ART_FILE="cat_in_the_box.txt" # Reference: https://github.com/khangtictoc/DevOps-Tools-Installation-Scripts/tree/main/linux/installation/terminal/ui/startup/fastfetch
    
    # Customizable
    DEFAULT_GITPROFILE_NAME=khangtictoc
    DEFAULT_GITPROFILE_URL="https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/profile/khangtictoc.sh"
    MOTD_IMAGE_URL="https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/ui/startup/fastfetch/$ASCII_ART_FILE"
    GITHOOK_PREPUSH_SCRIPT="https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/hook/pre-push"

    # Base URL for alias files (linux aliases work on macOS zsh too)
    GIT_ALIAS_FOLDER_URL=https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias

    # Tools to install
    TOOLS=(
        asciinema
        aws_cli
        fd
        helm
        k9s
        kubectl
        kubectl_plugins
        ls_extended
        nodejs
        rustnet
        terraform
        terragrunt
        velero_cli
    )

    DOTFILES_URLS=(
        "$GIT_ALIAS_FOLDER_URL/utilities/.api_aliases"
        "$GIT_ALIAS_FOLDER_URL/utilities/.misc_aliases"
        "$GIT_ALIAS_FOLDER_URL/utilities/.tool_aliases"
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

    # JAVA_HOME: macOS and Ubuntu resolve differently
    if [[ "$OS" == "macos" ]]; then
        JAVA_HOME_EXPORT='export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null || echo "")'
    else
        JAVA_HOME_EXPORT='export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java) 2>/dev/null)) 2>/dev/null || echo "")'
    fi

    SHELL_EXPORTS="

# --- ENVIRONMENT CREDENTIALS ----------------------------

export AWS_PAGER=""
export AWS_ACCESS_KEY_ID=\"DummyValue\"
export AWS_SECRET_ACCESS_KEY=\"DummyValue\"

export ARM_TENANT_ID=\"DummyValue\"
export ARM_SUBSCRIPTION_ID=\"DummyValue\"
export ARM_CLIENT_ID=\"DummyValue\"
export ARM_CLIENT_SECRET=\"DummyValue\"

export HCP_CLIENT_ID=DummyValue
export HCP_CLIENT_SECRET=DummyValue

export VAULT_ADDR=\"DummyValue\"
export VAULT_NAMESPACE=\"DummyValue\"
export VAULT_TOKEN=DummyValue

$JAVA_HOME_EXPORT
export M2_HOME=/opt/maven
export PATH=\"\$M2_HOME/bin:\$PATH\"

"
}
confirm_parameters() {
    echo
    echo "============ IMPORTANT SETUP PARAMETERS ============"
    echo
    printf "%-24s | %s\n" "Parameter" "Value"
    printf '%s\n' "-------------------------+--------------------------------------------------"
    printf "%-24s | %s\n" "SHELL_PROFILE" "$SHELL_PROFILE"
    printf "%-24s | %s\n" "GITCONFIG_DIRNAME" "$GITCONFIG_DIRNAME"
    printf "%-24s | %s\n" "DOTFILES_DIRNAME" "$DOTFILES_DIRNAME"
    printf "%-24s | %s\n" "MOTD_DIR" "$MOTD_DIR"
    printf "%-24s | %s\n" "TOOLING_REPO" "$TOOLING_REPO"
    printf "%-24s | %s\n" "ASCII_ART_FILE" "$ASCII_ART_FILE"
    printf "%-24s | %s\n" "DEFAULT_GITPROFILE_NAME" "$DEFAULT_GITPROFILE_NAME"
    printf "%-24s | %s\n" "DEFAULT_GITPROFILE_URL" "$DEFAULT_GITPROFILE_URL"
    printf "%-24s | %s\n" "MOTD_IMAGE_URL" "$MOTD_IMAGE_URL"
    printf "%-24s | %s\n" "GITHOOK_PREPUSH_SCRIPT" "$GITHOOK_PREPUSH_SCRIPT"
    printf "%-24s | %s\n" "GIT_ALIAS_FOLDER_URL" "$GIT_ALIAS_FOLDER_URL"
    printf "%-24s | %s\n" "TOOLS" "${TOOLS[*]}"
    echo
    echo "✅ Setup parameters listed above for review. Adjust the values in the script if needed before continuing."

    while true; do
        read -rp "Continue with these setup values? (y/N): " confirmation
        case "$confirmation" in
            [Yy])
                break
                ;;
            ""|[Nn]*)
                echo "Setup cancelled by user."
                exit 1
                ;;
            *)
                echo "Please enter y or N."
                ;;
        esac
    done
}

# --- OS Detection -------

detect_os() {
    case "$(uname -s)" in
        Darwin)
            OS="macos"
            ;;
        Linux)
            if grep -qi "ubuntu" /etc/os-release 2>/dev/null; then
                OS="ubuntu"
            else
                log_error "🚨 [ERROR] Unsupported Linux distro. Only Ubuntu is supported."
                exit 1
            fi
            ;;
        *)
            log_error "🚨 [ERROR] Unsupported OS: $(uname -s)"
            exit 1
            ;;
    esac

    # Detect WSL (Ubuntu running inside Windows)
    if [[ "$OS" == "ubuntu" ]] && grep -qi "microsoft" /proc/version 2>/dev/null; then
        IS_WSL=true
    else
        IS_WSL=false
    fi

    log_info "Detected OS: $OS | WSL: $IS_WSL"
}