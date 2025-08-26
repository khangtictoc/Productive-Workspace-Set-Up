##### GENERATE Private key, SSL Certificate #####

# --- Specific domain
sudo certbot --nginx -d zhubliberal.cloud

# --- Wildcard domain, Challenge method, Registration email
sudo certbot certonly --manual --preferred-challenges dns \
    -d "zhubliberal.cloud" -d \*.zhubliberal.cloud \
    -m tranhoangkhang09112001@gmail.com \
    --agree-tos

##### SHOW Certificates #####
sudo certbot certificates