# Detect secrets
echo "==== INSTALLING DETECT SECRETS ===="
wget "https://codeload.github.com/Yelp/detect-secrets/zip/refs/tags/v1.5.0" -O detect-secrets.zip
unzip detect-secrets.zip
cd detect-secrets-1.5.0
python3 setup.py install
cd .. && rm -rf detect-secrets-1.5.0 detect-secrets.zip
echo "==== CLEAN UP ===="

