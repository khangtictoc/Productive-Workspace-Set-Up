##### INSPECT #####
# List contents of a JKS file
keytool -list -v -keystore mykeystore.jks

# Export a certificate
keytool -exportcert -alias myalias -keystore mykeystore.jks -file mycert.cer

# Export Certificate chains
keytool -exportcert \
-alias myalias \
-keystore mykeystore.jks \
-rfc \
-file fullchain.pem

# Export Private Key
# NOTE: You can not directly extract the private key from a JKS keystore.
# This is by design for security reasons by `keytool`

# [1]: Convert JKS to PKCS12 (.pfx)
keytool -importkeystore -srckeystore mykeystore.jks -destkeystore mykeystore.p12 -deststoretype PKCS12
# [2]: Extract Private Key
openssl pkcs12 -in mykeystore.p12 -nocerts -nodes -out private.key