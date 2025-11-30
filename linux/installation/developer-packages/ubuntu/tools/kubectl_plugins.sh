#! /bin/bash

set -x; cd "$(mktemp -d)" &&
OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
KREW="krew-${OS}_${ARCH}" &&
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
tar zxvf "${KREW}.tar.gz" &&
./"${KREW}" install krew
echo "==== CLEAN UP ===="
rm -drf "$(pwd)"

EXPORT_KREW_PATH='export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"'
if grep -Fxq "$EXPORT_KREW_PATH" "$SHELLRC_FILE"; then
    echo "✅ Krew binary has been added to PATH! No changes"
else
    echo "$EXPORT_KREW_PATH" >> "$SHELLRC_FILE"
    echo "✅ Krew binary has been added to PATH\!"
fi

##  kubectl krew - Install useful plugins
kubectl krew install tree
kubectl krew install view-secret

## Kubectl Node Shell
curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
sudo chmod +x ./kubectl-node_shell
sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell
echo "- [CHECKED ✅] kubectl krew/plugins command installed!"