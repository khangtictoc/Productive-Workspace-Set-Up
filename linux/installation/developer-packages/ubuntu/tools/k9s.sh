#! /bin/bash

wget https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb
sudo apt install ./k9s_linux_amd64.deb
echo "==== CLEAN UP ===="
rm k9s_linux_amd64.deb