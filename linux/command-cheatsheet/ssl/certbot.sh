sudo certbot --nginx -d zhubliberal.cloud

sudo certbot certonly --manual --preferred-challenges dns \
    -d "zhubliberal.cloud" -d \*.zhubliberal.cloud \
    -m tranhoangkhang09112001@gmail.com \
    --agree-tos

sudo certbot certificates