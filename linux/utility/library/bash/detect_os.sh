#!/usr/bin/env bash

# detect_os - Sets OS, ARCH, and PKG_MGMT variables
# Usage:
#   source <(curl -sS "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/library/bash/detect_os.sh")
#   detect_os

detect_os() {
    case "$(uname -s)" in
        Darwin)
            OS="darwin"
            PKG_MGMT="brew"
            ;;
        Linux)
            OS="linux"
            if command -v apt-get &>/dev/null; then
                PKG_MGMT="apt"
            elif command -v dnf &>/dev/null; then
                PKG_MGMT="dnf"
            elif command -v yum &>/dev/null; then
                PKG_MGMT="yum"
            else
                PKG_MGMT="unknown"
            fi
            ;;
        *)
            echo "[ERROR] Unsupported OS: $(uname -s)"
            exit 1
            ;;
    esac

    case "$(uname -m)" in
        x86_64)          ARCH="amd64" ;;
        arm64 | aarch64) ARCH="arm64" ;;
        *)
            echo "[ERROR] Unsupported architecture: $(uname -m)"
            exit 1
            ;;
    esac

    export OS ARCH PKG_MGMT
}