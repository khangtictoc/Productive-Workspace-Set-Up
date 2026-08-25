#!/usr/bin/env bash

# get_os - Sets OS, ARCH, PKG_MGMT, and IS_WSL variables
# Usage:
#   source <(curl -sS "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/library/bash/get_os.sh")

## DEFINE

get_os() {
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

            if [[ -n "${WSL_DISTRO_NAME:-}" ]] || grep -qi "microsoft\|wsl" /proc/version 2>/dev/null; then
                IS_WSL=true
            else
                IS_WSL=false
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
}

## CALL

get_os