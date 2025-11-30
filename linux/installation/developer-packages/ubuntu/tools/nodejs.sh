#! /bin/bash

NODEJS_VERSION=22

if ! command -v node 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Node.js"

    # Download and install nvm:
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    # in lieu of restarting the shell
    \. "$HOME/.nvm/nvm.sh"
    # Download and install Node.js:
    nvm install ${NODEJS_VERSION}
    echo "==== CLEAN UP ===="
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.5.linux-amd64.tar.gz
    echo "- [CHECKED ✅] node command installed!"
else
    echo "- [CHECKED ✅] node command exists"
fi