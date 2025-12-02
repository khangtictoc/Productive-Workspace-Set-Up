#! /bin/bash

RUBY_VERSION=3.4.4

if ! command -v ruby 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Ruby"
    # Using rbenv. Reference: https://github.com/rbenv/rbenv?tab=readme-ov-file#basic-github-checkout

    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    ~/.rbenv/bin/rbenv init
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
    git -C "$(rbenv root)"/plugins/ruby-build pull
    sudo apt-get install -y \
        build-essential \
        autoconf \
        libssl-dev \
        libyaml-dev \
        zlib1g-dev \
        libffi-dev \
        libgmp-dev \
        rustc
    rbenv install $RUBY_VERSION

    if ! command -v ruby &> /dev/null; then
        echo "[FAIL ❌] ruby installation failed!"
        exit 1
    fi
    
    echo "- [CHECKED ✅] ruby command installed!"
else
    echo "- [CHECKED ✅] ruby command exists"
fi