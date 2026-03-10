#!/usr/bin/env bash

NODEJS_VERSION=22

if ! command -v node &>/dev/null; then
    echo "[INSTALLING ⬇️] Node.js v${NODEJS_VERSION} (via nvm)"

    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    \. "$HOME/.nvm/nvm.sh"

    nvm install ${NODEJS_VERSION}

    if ! command -v node &>/dev/null || ! command -v npm &>/dev/null; then
        echo "[FAIL ❌] node installation failed!"
        exit 1
    fi

    echo "[CHECKED ✅] node command installed!"
else
    echo "[CHECKED ✅] node command exists"
fi