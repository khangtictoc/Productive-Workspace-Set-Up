#! /bin/bash

DETECT_SECRETS_VERSION="1.5.0"

if ! command -v detect-secrets 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] detect-secrets"
    echo "==== INSTALLING detect-secrets ===="
    wget --progress=dot:giga "https://codeload.github.com/Yelp/detect-secrets/zip/refs/tags/v${DETECT_SECRETS_VERSION}" -O detect-secrets.zip
    unzip detect-secrets.zip
    cd detect-secrets-${DETECT_SECRETS_VERSION}
    python3 setup.py install
    cd .. && rm -rf detect-secrets-${DETECT_SECRETS_VERSION} detect-secrets.zip
    echo "==== CLEAN UP ===="
else
    echo "- [CHECKED ✅] detect-secrets command exists"
fi