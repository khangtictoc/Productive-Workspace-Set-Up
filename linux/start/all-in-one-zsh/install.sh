# --- Prerequisites ----------------------------------------------

prerequisite_install() {
    log_info "Installing prerequisites for $OS..."

    if [[ "$OS" == "macos" ]]; then
        # Ensure Homebrew is installed first
        if ! command -v brew &>/dev/null; then
            log_info "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

            # Add brew to PATH for Apple Silicon; Intel Macs already have it
            if [[ "$(uname -m)" == "arm64" ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
                echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$SHELL_PROFILE"
            fi
        else
            log_info "Homebrew already installed. Skipping."
        fi

        brew update
        # coreutils provides greadlink (needed for readlink -f on macOS)
        brew install zsh curl unzip vim python3 coreutils yq

    elif [[ "$OS" == "ubuntu" ]]; then
        sudo apt update
        sudo apt install -y dos2unix zsh curl unzip vim python3-pip yq
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
    log_info "Downloading Dotfiles..."
    mkdir -p ~/"$DOTFILES_DIRNAME"

    for url in "${DOTFILES_URLS[@]}"; do
        filename=$(basename "$url")
        echo "- Downloading 🔨 $filename..."
        download_file "$url" ~/"$DOTFILES_DIRNAME/$filename"
    done
    echo

    log_info "Converting files for compatibility..."
    find ~/"$DOTFILES_DIRNAME" -iname ".*" -type f | while read -r f; do
        convert_line_endings "$f"
    done

    log_info "Adding source script to shell startup..."
    if ! grep -Fxq '# --- SOURCE DOTFILES SCRIPT ----------------------------' "$SHELL_PROFILE"; then
        cat <<EOF >> "$SHELL_PROFILE"
$DOTFILES_SOURCE_SCRIPT
EOF
        log_success "Dotfiles have been sourced successfully!"
    else
        log_success "Dotfiles have already been sourced!"
    fi
}

# --- Git --------------------------------------------------------

setup_git_profile() {
    log_info "Configuring Git Profile (Default Workspace)..."
    curl -sL "$DEFAULT_GITPROFILE_URL" | bash

    log_info "Default profile ${CYAN}${DEFAULT_GITPROFILE_NAME}${NC} is selected!"
    sleep 1
}

setup_git_hooks() {
    log_info "Configuring client-side Git Hook - Prevent critical/leaked data..."
    mkdir -p ~/"$GITCONFIG_DIRNAME/hooks"

    git config --global core.hooksPath ~/"$GITCONFIG_DIRNAME/hooks"
    git config --global credential.helper store
    git config --global core.editor "vim"
    git config --global include.path "~/$GITCONFIG_DIRNAME/alias/git_aliases.txt"

    download_file \
        "$GITHOOK_PREPUSH_SCRIPT" \
        ~/"$GITCONFIG_DIRNAME/hooks/pre-push"
    chmod +x ~/"$GITCONFIG_DIRNAME/hooks/pre-push"

    log_success "Git hook configured at ${CYAN}~/$GITCONFIG_DIRNAME/hooks/pre-push${NC}!"
}

setup_git_alias() {
    log_info "Configuring Git Aliases..."
    mkdir -p ~/"$GITCONFIG_DIRNAME/alias/"
    download_file \
        "$GIT_ALIAS_FOLDER_URL/git/git_aliases.txt" \
        ~/"$GITCONFIG_DIRNAME/alias/git_aliases.txt"

    log_success "Git aliases configured at ${CYAN}~/$GITCONFIG_DIRNAME/alias/git_aliases.txt${NC}!"
}

# --- Shell Profile Config ---------------------------------------

shell_config_profile__expose_browser() {
    # WSL-only: expose browser via wslview
    if [[ "$IS_WSL" == true ]]; then
        if ! grep -Fxq "export BROWSER=wslview" "$SHELL_PROFILE"; then

            echo "####### Expose Browser Window in WSL #######" >> "$SHELL_PROFILE"
            echo "export BROWSER=wslview" >> "$SHELL_PROFILE"
            echo >> "$SHELL_PROFILE"

            log_success "Added 'wslview' as browser (WSL)"
        else
            log_check "(EXISTED) 'wslview' already set in $SHELL_PROFILE"
        fi
    fi

    # macOS: open command is the native browser launcher
    if [[ "$OS" == "macos" ]]; then
        if ! grep -Fxq "export BROWSER=open" "$SHELL_PROFILE"; then

            echo "####### Expose Browser Window in macOS #######" >> "$SHELL_PROFILE"
            echo "export BROWSER=open" >> "$SHELL_PROFILE"
            echo >> "$SHELL_PROFILE"

            log_success "Added 'open' as browser (macOS)"
        else
            log_check "(EXISTED) 'open' already set in $SHELL_PROFILE"
        fi
    fi
}

shell_config_profile__secure_kubeconfig() {
    if [ -f "$HOME/.kube/config" ]; then
        if ! grep -Fxq "chmod 600 \"$HOME/.kube/config\"" "$SHELL_PROFILE"; then

            echo "####### Secure Kubernetes Config #######" >> "$SHELL_PROFILE"
            echo "chmod 600 \"$HOME/.kube/config\"" >> "$SHELL_PROFILE"
            echo >> "$SHELL_PROFILE"

            log_success "Added permission 600 for ~/.kube/config"
        else
            log_check "(EXISTED) Permission 600 for ~/.kube/config already set"
        fi
    else
        log_warn "[Skipped] - '~/.kube/config' does not exist. No changes made."
    fi
}

shell_config_profile__add_local_bin_executable() {
    if ! grep -Fq 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_PROFILE"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_PROFILE"
        log_success "Added \$HOME/.local/bin to PATH"
    else
        log_check "(EXISTED) \$HOME/.local/bin already in PATH"
    fi
}

shell_config_profile__add_cloud_credentials() {
    if ! grep -Fxq '# --- ENVIRONMENT CREDENTIALS ----------------------------' "$SHELL_PROFILE"; then
        cat <<EOF >> "$SHELL_PROFILE"
$SHELL_EXPORTS
EOF
        log_success "Set 'DummyValue' for Cloud Credentials"
        log_success "Set up configuration "
    else
        log_check "(EXISTED) Cloud credentials already set"
    fi
}

# --- MOTD -------------------------------------------------------

shell_config_motd() {
    local option="$1"

    echo
    echo "============ MOTD ============"

    if [ ! -d "$MOTD_DIR" ]; then
        mkdir -p "$MOTD_DIR"
        log_success "Created MOTD directory at $MOTD_DIR"
    fi

    case "$option" in
        "fastfetch")   shell_config_motd_fastfetch   ;;
        "self-custom") shell_config_motd_self_custom ;;
        *)             log_warn "[WARN] No MOTD option provided or unrecognized. Skipping MOTD setup." ;;
    esac
}

shell_config_motd_self_custom() {
    download_file \
        "https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/ui/startup/self-customed/motd.sh" \
        "$MOTD_DIR/motd.sh"
    chmod +x "$MOTD_DIR/motd.sh"

    local SOURCE_MOTD_TXT="zsh $MOTD_DIR/motd.sh | lolcat"
    if ! grep -Fxq "$SOURCE_MOTD_TXT" "$SHELL_PROFILE"; then
        echo "$SOURCE_MOTD_TXT" >> "$SHELL_PROFILE"
        log_success "MOTD script sourced in $SHELL_PROFILE"
    else
        log_check "(EXISTED) MOTD script already sourced"
    fi
}

shell_config_motd_fastfetch() {

    # Install fastfetch if missing
    if ! command -v fastfetch &>/dev/null; then
        log_info "Installing fastfetch..."
        if [[ "$OS" == "macos" ]]; then
            brew install fastfetch
        elif [[ "$OS" == "ubuntu" ]]; then
            sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
            sudo apt update
            sudo apt install -y fastfetch
        fi
    fi

    download_file \
        "https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/ui/startup/fastfetch/motd.sh" \
        "$MOTD_DIR/motd.sh"
    chmod +x "$MOTD_DIR/motd.sh"
    log_success "Fastfetch MOTD script downloaded!"

    download_file \
        "$MOTD_IMAGE_URL" \
        "$MOTD_DIR/ascii_image.txt"
    log_success "ASCII art theme downloaded!"

    mkdir -p "$HOME/.config/fastfetch"
    download_file \
        "https://raw.githubusercontent.com/khangtictoc/$TOOLING_REPO/refs/heads/main/linux/installation/terminal/ui/startup/fastfetch/config.jsonc" \
        "$HOME/.config/fastfetch/config.jsonc"
    log_success "Fastfetch is configured!"

    local SOURCE_MOTD_TXT="zsh $MOTD_DIR/motd.sh $MOTD_DIR/ascii_image.txt"
    
    if ! grep -Fxq "$SOURCE_MOTD_TXT" "$SHELL_PROFILE"; then

        echo "####### Fastfetch MOTD #######" >> "$SHELL_PROFILE"
        echo "$SOURCE_MOTD_TXT" >> "$SHELL_PROFILE"
        echo >> "$SHELL_PROFILE"

        log_success "Fastfetch MOTD script sourced in $SHELL_PROFILE"
    else
        log_check "(EXISTED) Fastfetch MOTD script already sourced"
    fi
}

# --- Command Autocompletion -------------------------------------

setup_command_autocompletion() {
    if ! grep -Fxq '# --- COMMAND AUTOCOMPLETION ----------------------------' "$SHELL_PROFILE"; then

        echo "# --- COMMAND AUTOCOMPLETION ----------------------------" >> "$SHELL_PROFILE"
        echo >> "$SHELL_PROFILE"

        local COMPLETIONS=(
            "source <(kubectl completion zsh)"
            "source <(helm completion zsh)"
            "source <(oh-my-posh completion zsh)"
            "complete -C $(which aws_completer) aws"
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
                log_check "(EXISTED) $NAME completion already configured. No changes."
            else
                echo "$LINE" >> "$SHELL_PROFILE"
                log_success "$NAME completion configured!"
            fi
        done
    fi
    
}