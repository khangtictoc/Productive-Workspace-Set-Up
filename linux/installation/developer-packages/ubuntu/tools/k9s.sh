#! /bin/bash

THEME='catppuccin-mocha'
CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/k9s/config.yml"

if ! command -v k9s 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] k9s"
      https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb
    sudo apt install ./k9s_linux_amd64.deb

    echo "[INFO] >>>> Clean Up"
    rm k9s_linux_amd64.deb

    if ! command -v k9s &> /dev/null; then
        echo "[FAIL ❌] k9s installation failed!"
        exit 1
    fi

    echo "- [THEME] Config K9s Skin"
    OUT="${XDG_CONFIG_HOME:-$HOME/.config}/k9s/skins"
    mkdir -p "$OUT"
    curl -L https://github.com/catppuccin/k9s/archive/main.tar.gz | tar xz -C "$OUT" --strip-components=2 k9s-main/dist
    yq -i ".k9s.ui.skin = $THEME" "$CONFIG_FILE"

    echo "- [CHECKED ✅] k9s command installed!"
else
    echo "- [CHECKED ✅] k9s command exists"
fi