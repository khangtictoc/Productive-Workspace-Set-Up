#! /bin/bash

# Detect current shell
current_shell=$(basename "$SHELL")

# Determine RC file
case "$current_shell" in
    zsh)
        rc_file="${ZDOTDIR:-$HOME}/.zshrc"
        ;;
    bash)
        rc_file="$HOME/.bashrc"
        ;;
    *)
        echo "Unsupported shell: $current_shell"
        exit 1
        ;;
esac

echo "$rc_file"