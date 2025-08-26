#! /bin/bash

# Check System OS
current_shell=$(basename "$SHELL")

if [[ "$current_shell" == "zsh" ]]; then
    rc_file="$HOME/.zshrc"
fi
if [[ "$current_shell" == "bash" ]]; then
    rc_file="$HOME/.bashrc"
fi

if [[ -z "$rc_file" ]]; then
    echo "Unsupported shell: $current_shell"
    exit 1
fi

if [[ ! -f "$rc_file" ]]; then
    echo "$rc_file not found!"
    exit 1
fi

isGNUsed=false
isBSDsed=false
if sed --version >/dev/null 2>&1; then
    isGNUsed=true
fi
if ! sed --version >/dev/null 2>&1; then
    isBSDsed=true
fi

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
# Apply sed command based on sed type
if [[ "$isGNUsed" == true ]]; then
    sed -i '/^plugins=(/ s/)/ zsh-syntax-highlighting)/' "$rc_file"
fi

if [[ "$isBSDsed" == true ]]; then
    sed -i '' '/^plugins=(/ s/)/ zsh-syntax-highlighting)/' "$rc_file"
fi

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" | tee -a ${ZDOTDIR:-$HOME}/.zshrc
# Apply sed command based on sed type
if [[ "$isGNUsed" == true ]]; then
    sed -i '/^plugins=(/ s/)/ zsh-autosuggestions)/' "$rc_file"
fi

if [[ "$isBSDsed" == true ]]; then
    sed -i '' '/^plugins=(/ s/)/ zsh-autosuggestions)/' "$rc_file"
fi

echo "Updated $rc_file"