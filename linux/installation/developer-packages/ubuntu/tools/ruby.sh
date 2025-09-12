#! /bin/bash

# Using rbenv. Reference: https://github.com/rbenv/rbenv?tab=readme-ov-file#basic-github-checkout

RUBY_VERSION=3.4.4

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
~/.rbenv/bin/rbenv init
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
git -C "$(rbenv root)"/plugins/ruby-build pull
sudo apt-get install build-essential autoconf libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc
rbenv install $RUBY_VERSION