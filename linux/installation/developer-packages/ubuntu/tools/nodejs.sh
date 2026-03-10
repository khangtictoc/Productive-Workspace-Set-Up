#!/usr/bin/env bash

NODEJS_VERSION=22

if ! command -v node &>/dev/null; then
    echo "[INSTALLING ⬇️] Node.js v${NODEJS_VERSION} (via nvm)"

    # Unset NVM_DIR in case runner pre-sets it to a non-existent path
    unset NVM_DIR

    curl --retry 3 --retry-delay 5 --connect-timeout 30 --max-time 120 -fsSL --retry 3 --retry-delay 5 --connect-timeout 30 --max-time 120  \
        https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    # Source nvm explicitly after install
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    nvm install ${NODEJS_VERSION}

    if ! command -v node &>/dev/null || ! command -v npm &>/dev/null; then
        echo "[FAIL ❌] node installation failed!"
        exit 1
    fi

    echo "[CHECKED ✅] node command installed!"
else
    echo "[CHECKED ✅] node command exists"
fi