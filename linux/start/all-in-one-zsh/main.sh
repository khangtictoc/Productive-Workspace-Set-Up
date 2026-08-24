#!/usr/bin/env bash

set -e

# ================================================================
# Unified Workstation Setup Script
# Supports: macOS | Ubuntu
# Shell:    Zsh
# ================================================================

# --- MAIN FEATURES -----------------------

setup_git() {
    setup_git_profile
    setup_git_hooks
    setup_git_alias
}

shell_config_profile() {
    echo
    echo "=== SHELL PROFILES ==="

    # Expose browser command (wslview for WSL, open for macOS)
    shell_config_profile__expose_browser

    # Secure ~/.kube/config
    shell_config_profile__secure_kubeconfig

    # Add binaries be available at ~/.local/bin to PATH (universal convention, works on both OS)
    shell_config_profile__add_local_bin_executable

    # Cloud credentials (dummy values placeholder)
    shell_config_profile__add_cloud_credentials
}

shell_config() {
    shell_config_profile
    shell_config_motd "fastfetch"
}

install_my_tools() {
    install_tools "${TOOLS[@]}"
}

# ================================================================
# MAIN
# ================================================================

main() {
    
    # --- Import External Scripts -----------------------

    # ANSI color
    echo "1. Importing ANSI color library"
    source <(curl -sS "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/library/bash/init-ansi-color.sh")
    init-ansi-color

    # Initialize global variables (OS-aware)
    echo "2. Importing global variables"
    source <(curl -sS "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/start/all-in-one-zsh/init.sh")

    # Initialize utility functions
    echo "3. Importing utility functions"
    source <(curl -sS "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/start/all-in-one-zsh/utils.sh")

    # Initialize configuration functions
    echo "4. Importing configuration functions"
    source <(curl -sS "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/start/all-in-one-zsh/install.sh")

    # --- Start the setup process -----------------------

    detect_os
    init_globals

    print_section "PREREQUISITES INSTALLATION"
    prerequisite_install

    confirm_parameters

    print_section "ZSH THEME INSTALLATION"
    zsh_theme_install

    print_section "ZSH PLUGINS INSTALLATION"
    zsh_plugins_install

    print_section "SOURCE DOTFILES"
    source_dotfiles

    print_section "GIT SETUP"
    setup_git

    print_section "CONFIGURE SHELL"
    shell_config

    print_section "COMMAND AUTOCOMPLETION"
    setup_command_autocompletion

    print_section "INSTALL FAVORITE TOOLS"
    install_my_tools

    print_section "POST ACTIONS"
    post_actions
}

main "$@"