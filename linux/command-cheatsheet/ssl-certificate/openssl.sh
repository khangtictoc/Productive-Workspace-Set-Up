
##### P12 file #####
openssl pkcs12 -inkey key.pem -in certificate.pem -export -out certificate.p12


###### JKS file (Keystore - Cert for JAVA App) #####

# GENERATE
# --- From P12 file
keytool -importkeystore -srckeystore ./certificate.p12 -srcstoretype pkcs12 -destkeystore jenkinsserver.jks -deststoretype JKS
# --- From PFX file
keytool -importkeystore -srckeystore _.relationshop.net.pfx -srcstoretype pkcs12 -destkeystore jenkinsserver.jks -deststoretype JKS 

####### PFX FILE #####

# GET
# --- Encrypted private key
openssl pkcs12 -in STAR.relationshop.net.pfx -nocerts -out STAR.relationshop.net.encrypted.key
# --- Decrypted private key
openssl rsa -in STAR.relationshop.net.encrypted.key --out STAR.relationshop.net.key
# --- Certificate file
openssl pkcs12 -in STAR.relationshop.net.pfx -clcerts -nokeys -out STAR.relationshop.net.crt
# --- CA certificate chain file
openssl pkcs12 -in STAR.relationshop.net.pfx -cacerts -nokeys -out STAR.relationshop.net.ca-bundle

# GENERATE
openssl pkcs12 -export -out STAR.relationshop.net.pfx -inkey STAR.relationshop.net_key -in STAR.relationshop.net.crt -certfile STAR.relationshop.net.ca-bundle


##### SELF-SIGNED CERTIFICATE #####
# Generate private key and certificate
openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem

##### DEBUG #####  
# Verify domain's certificates
openssl s_client -showcerts -connect <DOMAIN>:443