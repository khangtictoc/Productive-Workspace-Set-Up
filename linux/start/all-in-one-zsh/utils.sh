# --- Utility: Download file from URL ----------------------------

download_file() {
    local url="$1"
    local dest="$2"
    if command -v curl &>/dev/null; then
        curl -fsSL "$url" -o "$dest"
    elif command -v wget &>/dev/null; then
        wget -q "$url" -O "$dest"
    else
        log_error "🚨 [ERROR] Neither curl nor wget found. Cannot download files."
        exit 1
    fi
}

# --- Utility: Install favorite tools ----------------------------

install_tools() {
    local tools=("$@")
    
    for tool in "${tools[@]}"; do
        curl -sS https://raw.githubusercontent.com/khangtictoc/DevOps-Tools-Installation-Scripts/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/${tool}.sh | SHELL_PROFILE=$SHELL_PROFILE bash
    done
}

# --- Utility: Convert line endings (dos2unix) ----------------------------
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

# --- Utility: Print section header ----------------------------

print_section() {
    local title="$1"
    echo
    echo "============ ${title} ============"
    echo
}


# --- Post Actions -----------------------------------------------

post_actions() {
    log_highlight "Please restart your terminal or run 'source $SHELL_PROFILE' to apply changes."
    echo
    log_highlight "What's next?"
    log_highlight "  - Set up Cloud Credentials"
    log_highlight "  - Install your tools"
    echo
}