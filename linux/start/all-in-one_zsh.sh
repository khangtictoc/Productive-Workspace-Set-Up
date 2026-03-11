#!/usr/bin/env bash

set -e

# ================================================================
# Unified Workstation Setup Script
# Supports: macOS | Ubuntu
# Shell:    Zsh
# ================================================================

# --- OS Detection (run first, everything depends on this) -------

detect_os() {
    case "$(uname -s)" in
        Darwin)
            OS="macos"
            ;;
        Linux)
            if grep -qi "ubuntu" /etc/os-release 2>/dev/null; then
                OS="ubuntu"
            else
                echo "[ERROR] Unsupported Linux distro. Only Ubuntu is supported."
                exit 1
            fi
            ;;
        *)
            echo "[ERROR] Unsupported OS: $(uname -s)"
            exit 1
            ;;
    esac

    # Detect WSL (Ubuntu running inside Windows)
    if [[ "$OS" == "ubuntu" ]] && grep -qi "microsoft" /proc/version 2>/dev/null; then
        IS_WSL=true
    else
        IS_WSL=false
    fi

    echo "[INFO] Detected OS: $OS | WSL: $IS_WSL"
}

# --- Global Variables (OS-aware) --------------------------------
# NOTE: These are set AFTER detect_os() is called in main()

init_globals() {
    SHELL_PROFILE="$HOME/.zshrc"
    GITCONFIG_DIRNAME=git_config
    DOTFILES_DIRNAME=dotfiles
    MOTD_DIR="$HOME/.my_motd"
    TOOLING_REPO="DevOps-Tools-Installation-Scripts"
    
    # Customizable
    DF_GITPROFILE_NAME=khangtictoc
    DF_GITPROFILE_URL="https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/profile/khangtictoc.sh"
    MOTD_IMAGE_URL="https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/ui/startup/neofetch/cat_in_the_box.txt"
    GITHOOK_PREPUSH_SCRIPT="https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/hook/pre-push"

    # Base URL for alias files (linux aliases work on macOS zsh too)
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

    # JAVA_HOME: macOS and Ubuntu resolve differently
    if [[ "$OS" == "macos" ]]; then
        JAVA_HOME_EXPORT='export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null || echo "")'
    else
        JAVA_HOME_EXPORT='export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java) 2>/dev/null)) 2>/dev/null || echo "")'
    fi

    SHELL_EXPORTS="

# --- ENVIRONMENT CREDENTIALS ----------------------------

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

# --- Utility: Download a file (curl everywhere, wget as fallback) -

download_file() {
    local url="$1"
    local dest="$2"
    if command -v curl &>/dev/null; then
        curl -fsSL "$url" -o "$dest"
    elif command -v wget &>/dev/null; then
        wget -q "$url" -O "$dest"
    else
        echo "[ERROR] Neither curl nor wget found. Cannot download files."
        exit 1
    fi
}

# --- Prerequisites ----------------------------------------------

prerequisite_install() {
    echo "[INFO] Installing prerequisites for $OS..."

    if [[ "$OS" == "macos" ]]; then
        # Ensure Homebrew is installed first
        if ! command -v brew &>/dev/null; then
            echo "[INFO] Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

            # Add brew to PATH for Apple Silicon; Intel Macs already have it
            if [[ "$(uname -m)" == "arm64" ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
                echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$SHELL_PROFILE"
            fi
        else
            echo "[INFO] Homebrew already installed. Skipping."
        fi

        brew update
        # coreutils provides greadlink (needed for readlink -f on macOS)
        brew install zsh curl unzip vim python3 coreutils

    elif [[ "$OS" == "ubuntu" ]]; then
        sudo apt update
        sudo apt install -y dos2unix zsh curl unzip vim python3-pip
    fi
}

# --- Convert line endings (dos2unix) ----------------------------
# macOS doesn't ship dos2unix; use sed as a portable fallback

convert_line_endings() {
    local file="$1"
    if command -v dos2unix &>/dev/null; then
        dos2unix "$file" 2>/dev/null
    else
        # Portable CRLF → LF via sed (works on macOS and Ubuntu)
        sed -i'' -e 's/\r$//' "$file"
    fi
}

# --- Zsh Theme --------------------------------------------------

zsh_theme_install() {
    curl -sS "https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/ui/theme/oh-my-posh/install.sh" | bash
    curl -sS "https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/ui/theme/oh-my-posh/configure-zsh.sh" | bash
}

# --- Zsh Plugins ------------------------------------------------

zsh_plugins_install() {
    curl -sS "https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/plugins/fzf/install.sh" | bash
    curl -sS "https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/shell/zsh/plugins.sh" | bash
}

# --- Dotfiles ---------------------------------------------------

source_dotfiles() {
    echo "[INFO] Downloading Dotfiles..."
    mkdir -p ~/"$DOTFILES_DIRNAME"

    for url in "${DOTFILES_URLS[@]}"; do
        filename=$(basename "$url")
        echo "- Downloading 🔨 $filename..."
        download_file "$url" ~/"$DOTFILES_DIRNAME/$filename"
    done
    echo

    echo "[INFO] Converting files for compatibility..."
    find ~/"$DOTFILES_DIRNAME" -iname ".*" -type f | while read -r f; do
        convert_line_endings "$f"
    done

    echo "[INFO] Adding source script to shell startup..."
    if ! grep -Fxq '# --- SOURCE DOTFILES SCRIPT ----------------------------' "$SHELL_PROFILE"; then
        cat <<EOF >> "$SHELL_PROFILE"
$DOTFILES_SOURCE_SCRIPT
EOF
        log_success "✅ - Dotfiles have been sourced successfully!"
    else
        log_success "✅ - Dotfiles have already been sourced!"
    fi
}

# --- Git --------------------------------------------------------

setup_git_profile() {
    echo "[INFO] Configuring Git Profile (Default Workspace)..."
    curl -sL "$DF_GITPROFILE_URL" | bash

    log_info "Default profile ${CYAN}$DF_GITPROFILE_NAME${NC} is selected!"
    sleep 1
}

setup_git_hooks() {
    echo
    echo "[INFO] Configuring client-side Git Hook - Prevent critical/leaked data..."
    mkdir -p ~/"$GITCONFIG_DIRNAME/hooks"

    git config --global core.hooksPath ~/"$GITCONFIG_DIRNAME/hooks"
    git config --global credential.helper store
    git config --global core.editor "vim"
    git config --global include.path "~/$GITCONFIG_DIRNAME/alias/git_aliases.txt"

    download_file \
        "$GITHOOK_PREPUSH_SCRIPT" \
        ~/"$GITCONFIG_DIRNAME/hooks/pre-push"
    chmod +x ~/"$GITCONFIG_DIRNAME/hooks/pre-push"

    log_success "✅ - Git hook configured at ${CYAN}~/$GITCONFIG_DIRNAME/hooks/pre-push${NC}!"
}

setup_git_alias() {
    echo
    echo "[INFO] Configuring Git Aliases..."
    mkdir -p ~/"$GITCONFIG_DIRNAME/alias/"
    download_file \
        "$GIT_ALIAS_FOLDER_URL/git/git_aliases.txt" \
        ~/"$GITCONFIG_DIRNAME/alias/git_aliases.txt"

    log_success "✅ - Git aliases configured at ${CYAN}~/$GITCONFIG_DIRNAME/alias/git_aliases.txt${NC}!"
}

setup_git() {
    setup_git_profile
    setup_git_hooks
    setup_git_alias
}

# --- Shell Profile Config ---------------------------------------

shell_config_profile() {
    echo
    echo "============ SHELL PROFILES ============"

    # WSL-only: expose browser via wslview
    if [[ "$IS_WSL" == true ]]; then
        if ! grep -Fxq "export BROWSER=wslview" "$SHELL_PROFILE"; then
            echo "export BROWSER=wslview" >> "$SHELL_PROFILE"
            log_success "✅ - Added 'wslview' as browser (WSL)"
        else
            log_info "Existed ℹ️ - 'wslview' already set in $SHELL_PROFILE"
        fi
    fi

    # macOS: open command is the native browser launcher
    if [[ "$OS" == "macos" ]]; then
        if ! grep -Fxq "export BROWSER=open" "$SHELL_PROFILE"; then
            echo "export BROWSER=open" >> "$SHELL_PROFILE"
            log_success "✅ - Added 'open' as browser (macOS)"
        else
            log_info "Existed ℹ️ - 'open' already set in $SHELL_PROFILE"
        fi
    fi

    # Secure ~/.kube/config
    if [ -f "$HOME/.kube/config" ]; then
        if ! grep -Fxq "chmod 600 \"$HOME/.kube/config\"" "$SHELL_PROFILE"; then
            echo "chmod 600 \"$HOME/.kube/config\"" >> "$SHELL_PROFILE"
            log_success "✅ - Added permission 600 for ~/.kube/config"
        else
            log_info "Existed ℹ️ - Permission 600 for ~/.kube/config already set"
        fi
    else
        log_warn "Skipped! ⚠️ - '~/.kube/config' does not exist. No changes made."
    fi

    # Add ~/.local/bin to PATH (universal convention, works on both OS)
    if ! grep -Fq 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_PROFILE"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_PROFILE"
        log_success "✅ - Added \$HOME/.local/bin to PATH"
    else
        log_info "Existed ℹ️ - \$HOME/.local/bin already in PATH"
    fi

    # Cloud credentials (dummy values placeholder)
    if ! grep -Fxq '# --- ENVIRONMENT CREDENTIALS ----------------------------' "$SHELL_PROFILE"; then
        cat <<EOF >> "$SHELL_PROFILE"
$SHELL_EXPORTS
EOF
        log_success "✅ - Set 'DummyValue' for Cloud Credentials"
    else
        log_info "Existed ℹ️ - Cloud credentials already set"
    fi
}

# --- MOTD -------------------------------------------------------

shell_config_motd() {
    local option="$1"

    echo
    echo "============ MOTD ============"

    if [ ! -d "$MOTD_DIR" ]; then
        mkdir -p "$MOTD_DIR"
        log_success "✅ - Created MOTD directory at $MOTD_DIR"
    fi

    case "$option" in
        "neofetch")    shell_config_motd_neofetch    ;;
        "self-custom") shell_config_motd_self_custom ;;
        *)             log_warn "No MOTD option provided or unrecognized. Skipping MOTD setup." ;;
    esac
}

shell_config_motd_self_custom() {
    download_file \
        "https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/ui/startup/self-customed/motd.sh" \
        "$MOTD_DIR/motd.sh"
    chmod +x "$MOTD_DIR/motd.sh"

    local SOURCE_MOTD_TXT="bash $MOTD_DIR/motd.sh | lolcat"
    if ! grep -Fxq "$SOURCE_MOTD_TXT" "$SHELL_PROFILE"; then
        echo "$SOURCE_MOTD_TXT" >> "$SHELL_PROFILE"
        log_success "✅ - MOTD script sourced in $SHELL_PROFILE"
    else
        log_info "Existed ℹ️ - MOTD script already sourced"
    fi
}

shell_config_motd_neofetch() {
    # Install neofetch if missing
    if ! command -v neofetch &>/dev/null; then
        echo "[INFO] Installing neofetch..."
        if [[ "$OS" == "macos" ]]; then
            brew install neofetch
        elif [[ "$OS" == "ubuntu" ]]; then
            sudo apt install -y neofetch
        fi
    fi

    download_file \
        "https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/ui/startup/neofetch/motd.sh" \
        "$MOTD_DIR/motd.sh"
    chmod +x "$MOTD_DIR/motd.sh"
    log_success "✅ - Neofetch MOTD script downloaded!"

    download_file \
        "$MOTD_IMAGE_URL" \
        "$MOTD_DIR/ascii_image.txt"
    log_success "✅ - ASCII art theme downloaded!"

    mkdir -p "$HOME/.config/neofetch"
    download_file \
        "https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/ui/startup/neofetch/config.conf" \
        "$HOME/.config/neofetch/config.conf"
    log_success "✅ - Neofetch config installed!"

    local SOURCE_MOTD_TXT="bash $MOTD_DIR/motd.sh $MOTD_DIR/ascii_image.txt"
    if ! grep -Fxq "$SOURCE_MOTD_TXT" "$SHELL_PROFILE"; then
        echo "$SOURCE_MOTD_TXT" >> "$SHELL_PROFILE"
        log_success "✅ - Neofetch MOTD script sourced in $SHELL_PROFILE"
    else
        log_info "Existed ℹ️ - Neofetch MOTD script already sourced"
    fi
}

shell_config() {
    shell_config_profile
    shell_config_motd "neofetch"
}

# --- Command Autocompletion -------------------------------------

setup_command_autocompletion() {
    local COMPLETIONS=(
        "source <(kubectl completion zsh)"
        "source <(helm completion zsh)"
        "source <(oh-my-posh completion zsh)"
    )
    local NAMES=(
        "Kubectl"
        "Helm"
        "Oh-My-Posh"
    )

    for i in "${!COMPLETIONS[@]}"; do
        local LINE="${COMPLETIONS[$i]}"
        local NAME="${NAMES[$i]}"

        if grep -Fxq "$LINE" "$SHELL_PROFILE"; then
            log_info "Existed ℹ️ - $NAME completion already configured. No changes."
        else
            echo "$LINE" >> "$SHELL_PROFILE"
            log_success "✅ - $NAME completion configured!"
        fi
    done
}

# --- Post Actions -----------------------------------------------

post_actions() {
    log_highlight "Please restart your terminal or run 'source $SHELL_PROFILE' to apply changes."
    echo
    log_highlight "What's next?"
    log_highlight "  - Set up Cloud Credentials"
    log_highlight "  - Install your tools"
}

# ================================================================
# MAIN
# ================================================================

main() {
    # Step 0: Detect OS — must be first
    detect_os
    init_globals

    echo
    echo "============ PREREQUISITES INSTALLATION ============"
    echo
    prerequisite_install

    echo
    echo "============ IMPORT EXTERNAL LIBS ============"
    echo
    source <(curl -sS "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/library/bash/ansi_color.sh")
    init-ansicolor

    echo
    echo "============ ZSH THEME INSTALLATION ============"
    echo
    zsh_theme_install

    echo
    echo "============ ZSH PLUGINS INSTALLATION ============"
    echo
    zsh_plugins_install

    echo
    echo "============ SOURCE DOTFILES ============"
    echo
    source_dotfiles

    echo
    echo "============ GIT SETUP ============"
    echo
    setup_git

    echo
    echo "============ CONFIGURE SHELL ============"
    echo
    shell_config

    echo
    echo "============ COMMAND AUTOCOMPLETION ============"
    echo
    setup_command_autocompletion

    echo
    echo "============ POST ACTIONS ============"
    echo
    post_actions
}

main "$@"