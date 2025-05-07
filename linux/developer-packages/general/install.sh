#! /usr/bin/fish

# ++++++++++ KUBECTL KREW ++++++++++
begin
  set -x; set temp_dir (mktemp -d); cd "$temp_dir" &&
  set OS (uname | tr '[:upper:]' '[:lower:]') &&
  set ARCH (uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/') &&
  set KREW krew-$OS"_"$ARCH &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/$KREW.tar.gz" &&
  tar zxvf $KREW.tar.gz &&
  ./$KREW install krew &&
  set -e KREW temp_dir &&
  cd -
end

set -gx PATH $PATH $HOME/.krew/bin


# Detect secrets
echo "==== INSTALLING DETECT SECRETS ===="
wget "https://codeload.github.com/Yelp/detect-secrets/zip/refs/tags/v1.5.0" -O detect-secrets.zip
unzip detect-secrets.zip
cd detect-secrets-1.5.0
python3 setup.py install
cd .. && rm -rf detect-secrets-1.5.0 detect-secrets.zip
echo "==== CLEAN UP ===="
