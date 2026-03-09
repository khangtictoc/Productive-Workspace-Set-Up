#! /bin/bash

ANSIBLE_VERSION="6.7.0"

# Note: Remember to "export $SHELLRC_FILE", i.e '$HOME/.bashrc'. Depend on your favorite shell

if ! python3 -m ansible playbook -h &> /dev/null
then
    pip install ansible==$ANSIBLE_VERSION

    # Add "$HOME/.local/bin" as executable path to PATH
    if ! grep -Fxq "export PATH=$HOME/.local/bin:$PATH" ${SHELLRC_FILE}; then
        echo "export PATH=$HOME/.local/bin:$PATH" >> ${SHELLRC_FILE}
        echo -e "[INFO] Update: Add "$HOME/.local/bin" as executable path to PATH"
    else
        echo -e "[INFO] Existed: Already added "$HOME/.local/bin" as executable path to PATH"
    fi

    if ! python3 -m ansible playbook -h &> /dev/null; then
        echo "[FAIL ❌] ansible installation failed!"
        exit 1
    fi

    echo "[CHECKED ✅] ansible command installed!. Reload shell to see changes"
else
    echo "[CHECKED ✅] ansible command exists"
fi


