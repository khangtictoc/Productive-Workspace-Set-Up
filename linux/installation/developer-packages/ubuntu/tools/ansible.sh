#! /bin/bash

ANSIBLE_VERSION="6.7.0"

if ! command -v ansible 2>&1 >/dev/null
then

    pip install ansible==$ANSIBLE_VERSION

    # Add "$HOME/.local/bin" as executable path to PATH
    if ! grep -Fxq 'export PATH="$HOME/.local/bin:$PATH"' ${SHELL_PROFILE}; then
        echo "export PATH="$HOME/.local/bin:$PATH"" >> ${SHELL_PROFILE}
        echo -e "[INFO] Update: Add "$HOME/.local/bin" as executable path to PATH"
    else
        echo -e "[INFO] Existed: Already added "$HOME/.local/bin" as executable path to PATH"
    fi

    if ! command -v ansible &> /dev/null; then
        echo "[FAIL ❌] ansible installation failed!"
        exit 1
    fi

    echo "[CHECKED ✅] ansible command installed!"
else
    echo "[CHECKED ✅] ansible command exists"
fi


