#! /bin/bash

if ! command -v glab 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] GitLab CLI"
    wget --progress=dot:giga -O glab_1.67.0_linux_amd64.deb https://gitlab.com/gitlab-org/cli/-/releases/v1.67.0/downloads/glab_1.67.0_linux_amd64.deb
    sudo dpkg -i glab_1.67.0_linux_amd64.deb

    echo "[INFO] >>>> Clean Up"
    rm glab_1.67.0_linux_amd64.deb

    if ! command -v glab &> /dev/null; then
        echo "[FAIL ❌] glab installation failed!"
        exit 1
    fi

    echo "- [CHECKED ✅] glab command installed!"
else
    echo "- [CHECKED ✅] glab command exists"
fi