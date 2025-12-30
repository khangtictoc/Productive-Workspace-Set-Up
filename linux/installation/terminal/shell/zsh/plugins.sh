#! /bin/bash

rc_file=$(source <(curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/library/bash/get_shell_startup_filename.sh))

source <(curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/library/bash/git_clone.sh)

function add_plugin_zsh(){
    isGNUsed=false
    isBSDsed=false
    local plugin_name="$1"

    if sed --version >/dev/null 2>&1; then
        isGNUsed=true
    fi
    if ! sed --version >/dev/null 2>&1; then
        isBSDsed=true
    fi

    # Apply sed command based on sed type
    if [[ "$isGNUsed" == true ]]; then
        sed -i "/^plugins=(/ s/)/ $plugin_name)/" "$rc_file"
    fi

    if [[ "$isBSDsed" == true ]]; then
        sed -i "" "/^plugins=(/ s/)/ $plugin_name)/" "$rc_file"
    fi
}

function main(){
    echo "[INFO] Installing zsh plugins..."

    if [[ ! -f "$rc_file" ]]; then
        echo "$rc_file not found!"
        exit 1
    fi

    # zsh-autosuggestions
    git_clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    add_plugin_zsh "zsh-autosuggestions"

    # zsh-syntax-highlighting
    git_clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
    add_plugin_zsh "zsh-syntax-highlighting"


    echo "Updated $rc_file successfully ✅"
}

main "$@"

