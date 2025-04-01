### EXPORT CERTIFICATE WITh SUPPORTED FORMAT ###
# Create PFX file 
openssl pkcs12 -export -out STAR.relationshop.net.pfx -inkey STAR.relationshop.net_key -in STAR.relationshop.net.crt -certfile STAR.relationshop.net.ca-bundle
# Create P12 file
openssl pkcs12 -inkey key.pem -in certificate.pem -export -out certificate.p12
# [Cert for JAVA App] Create JKS (keystore) from P12 file
keytool -importkeystore -srckeystore ./certificate.p12 -srcstoretype pkcs12 -destkeystore jenkinsserver.jks -deststoretype JKS
# [Cert for JAVA App] Create JKS (keystore) from PFX file
keytool -importkeystore -srckeystore _.relationshop.net.pfx -srcstoretype pkcs12 -destkeystore jenkinsserver.jks -deststoretype JKS 


### RETRIEVE CERTIFICATE INFO ### 
## PFX FILE
# Get encrypted private key
openssl pkcs12 -in STAR.relationshop.net.pfx -nocerts -out STAR.relationshop.net.encrypted.key
# Get decrypted private key
openssl rsa -in STAR.relationshop.net.encrypted.key --out STAR.relationshop.net.key
# get certificate file
openssl pkcs12 -in STAR.relationshop.net.pfx -clcerts -nokeys -out STAR.relationshop.net.crt


### CREATE SELF SIGNED CERTIFICATE ###
# Generate private key and certificate
openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem

### DEBUG ###  
# Verify domain's certificates
openssl s_client -showcerts -connect <DOMAIN>:443