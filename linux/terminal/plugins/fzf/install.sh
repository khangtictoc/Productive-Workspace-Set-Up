#! /bin/bash

sudo apt install git -y
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install << EOF
y
y
y
EOF

sed -i '/^plugins=(/ s/)/ fzf)/' ~/.zshrc

# This will be automatically added when installing "fzf"
# If not, add it manually in ~/.bashrc
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash