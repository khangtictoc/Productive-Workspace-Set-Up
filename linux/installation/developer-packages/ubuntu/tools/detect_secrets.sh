#! /bin/bash

DETECT_SECRETS_VERSION=""1.5.0"
echo "==== INSTALLING detect-secrets ===="
wget "https://codeload.github.com/Yelp/detect-secrets/zip/refs/tags/v${DETECT_SECRETS_VERSION}" -O detect-secrets.zip
unzip detect-secrets.zip
cd detect-secrets-${DETECT_SECRETS_VERSION}
python3 setup.py install
cd .. && rm -rf detect-secrets-${DETECT_SECRETS_VERSION} detect-secrets.zip
echo "==== CLEAN UP ===="