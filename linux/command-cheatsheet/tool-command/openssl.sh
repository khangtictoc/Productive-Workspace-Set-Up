# Create PFX file with CA AUTHORIZATION
openssl pkcs12 -export -out STAR.relationshop.net.pfx -inkey STAR.relationshop.net_key -in STAR.relationshop.net.crt -certfile STAR.relationshop.net.ca-bundle

## PFX FILE ##

# get encrypted private key
openssl pkcs12 -in STAR.relationshop.net.pfx -nocerts -out STAR.relationshop.net.encrypted.key
# decrypt private key
openssl rsa -in STAR.relationshop.net.encrypted.key --out STAR.relationshop.net.key
# get certificate file
openssl pkcs12 -in STAR.relationshop.net.pfx -clcerts -nokeys -out STAR.relationshop.net.crt