# Checking Webhook's Injection Successful ?

env | grep -i azure

FEDERATED_TOKEN=$(cat $AZURE_FEDERATED_TOKEN_FILE)
FEDERATED_TOKEN=$(cat /var/run/secrets/azure/tokens/azure-identity-token)

# Checking running workload using Workload Identity ? 

kubectl get pods -l azure.workload.identity/use=true -A


# Login using Workload Identity

az login --federated-token $(cat $AZURE_FEDERATED_TOKEN_FILE) --service-principal -u $AZURE_CLIENT_ID -t $AZURE_TENANT_ID

# Manual 'curl' testing

curl --location --request POST "https://login.microsoftonline.com/$AZURE_TENANT_ID/oauth2/v2.0/token" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "grant_type=client_credentials" \
    --data-urlencode "client_id=$AZURE_CLIENT_ID" \
    --data-urlencode 'client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer' \
    --data-urlencode "client_assertion=$(cat $AZURE_FEDERATED_TOKEN_FILE)" \
    --data-urlencode 'scope=https://management.azure.com/.default'


TOKEN=$(curl --location --request POST "https://login.microsoftonline.com/$AZURE_TENANT_ID/oauth2/v2.0/token" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "grant_type=client_credentials" \
    --data-urlencode "client_id=$AZURE_CLIENT_ID" \
    --data-urlencode 'client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer' \
    --data-urlencode "client_assertion=$(cat $AZURE_FEDERATED_TOKEN_FILE)" \
    --data-urlencode 'scope=https://management.azure.com/.default' | jq -r '.access_token')

curl -s -H "Authorization: Bearer $TOKEN" https://management.azure.com/subscriptions?api-version=2020-01-01

---

## --- Testing with ACR Authentication

REGISTRY="<your_acr_name>.azurecr.io"

AAD_TOKEN=$(curl -sS -X POST \
    -H "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "grant_type=client_credentials" \
    --data-urlencode "client_id=$AZURE_CLIENT_ID" \
    --data-urlencode "client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer" \
    --data-urlencode "client_assertion=$(cat $AZURE_FEDERATED_TOKEN_FILE)" \
    --data-urlencode "scope=https://containerregistry.azure.net/.default" \
    "https://login.microsoftonline.com/$AZURE_TENANT_ID/oauth2/v2.0/token" | jq -r '.access_token')

echo "AAD Token: $AAD_TOKEN"

REFRESH_TOKEN=$(curl -sS -X POST \
    -H "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "grant_type=access_token" \
    --data-urlencode "service=$REGISTRY" \
    --data-urlencode "access_token=$AAD_TOKEN" \
    "https://$REGISTRY/oauth2/exchange" | jq -r '.refresh_token')

echo "Refresh Token: $REFRESH_TOKEN"

# Get ACR Access Token

SCOPE="repository:$REGISTRY/<my_repository>:pull,push"

ACCESS_TOKEN=$(curl -sS -X POST \
    -H "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "grant_type=refresh_token" \
    --data-urlencode "service=$REGISTRY" \
    --data-urlencode "scope=$SCOPE" \
    --data-urlencode "refresh_token=$REFRESH_TOKEN" \
    "https://$REGISTRY/oauth2/token" | jq -r '.access_token')

echo "Access Token: $ACCESS_TOKEN"

sudo docker login $REGISTRY -u 00000000-0000-0000-0000-000000000000 -p $ACCESS_TOKEN


## --- Testing with Postgresql Authentication

az login --federated-token $(cat $AZURE_FEDERATED_TOKEN_FILE) --service-principal -u $AZURE_CLIENT_ID -t $AZURE_TENANT_ID

az account get-access-token --resource https://ossrdbms.database.windows.net