#! /usr/bin/fish

# Array of URLs
set -l urls "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/advance_function/.utilities_fish" "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/command_extension/.extension_aliases" "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/git/.git_aliases_fish" "https://raw.githubusercontent.com/khangatmercatus/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/kubernetes/helm-aliases/.helm_aliases" "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/kubernetes/kubectl-aliases/.kubectl_aliases" "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/system-aliases/.system_aliases"

set DOTFILES_DIRNAME dotfiles
mkdir -p ~/$DOTFILES_DIRNAME

for i in (seq $(count $urls))
    set filename (basename "$urls[$i]")
    wget $urls[$i] -O ~/$DOTFILES_DIRNAME/$filename
end

echo "if status is-interactive
    set DOTFILES_DIRNAME dotfiles
    for file in ~/\$DOTFILES_DIRNAME/.*
        if test -r \$file
            source \$file
        end
    end
end
[ -f ~/.oh-my-posh-init ] && source ~/.oh-my-posh-init" > ~/.config/fish/config.fish
