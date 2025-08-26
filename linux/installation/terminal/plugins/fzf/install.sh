#! /bin/bash

sudo apt install git -y
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install << EOF
y
y
y
EOF

# Detect current shell
current_shell=$(basename "$SHELL")

# Determine RC file
if [[ "$current_shell" == "zsh" ]]; then
    rc_file="$HOME/.zshrc"
fi

if [[ "$current_shell" == "bash" ]]; then
    rc_file="$HOME/.bashrc"
fi

# Exit if unsupported shell
if [[ -z "$rc_file" ]]; then
    echo "Unsupported shell: $current_shell"
    exit 1
fi

# Check RC file existence
if [[ ! -f "$rc_file" ]]; then
    echo "$rc_file not found!"
    exit 1
fi

# Detect sed type
isGNUsed=false
isBSDsed=false

if sed --version >/dev/null 2>&1; then
    isGNUsed=true
fi

if ! sed --version >/dev/null 2>&1; then
    isBSDsed=true
fi

# Apply sed command based on sed type
if [[ "$isGNUsed" == true ]]; then
    sed -i '/^plugins=(/ s/)/ fzf)/' "$rc_file"
fi

if [[ "$isBSDsed" == true ]]; then
    sed -i '' '/^plugins=(/ s/)/ fzf)/' "$rc_file"
fi

echo "Updated $rc_file"