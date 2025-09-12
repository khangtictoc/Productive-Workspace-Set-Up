#! /bin/bash

wget https://github.com/imsnif/bandwhich/releases/download/v0.23.1/bandwhich-v0.23.1-x86_64-unknown-linux-gnu.tar.gz
tar -xzf bandwhich-v0.23.1-x86_64-unknown-linux-gnu.tar.gz
sudo cp bandwhich /usr/local/bin/bandwhich
echo "==== CLEAN UP ===="
rm -f bandwhich-v0.23.1-x86_64-unknown-linux-gnu.tar.gz bandwhich