## AZURE LOGIN

# Login with application/service principal
az login --service-principal -u <CLIENT_ID> -p <CLIENT_SECRET> --tenant <TENANT_ID>

# Login with UMI/MSI
az login --identity <CLIENT_ID>

# Login with federated token
az login --federated-token <TOKEN> --client-id <CLIENT_ID> --tenant-id <TENANT_ID>

## SUBSCRIPTION

az account set --subscription <SUBSCRIPTION_ID>

az account list --output table

az account show --output table

## RESOURCE GROUP

az group list --output table


## MANAGED IDENTITIES

az identity federated-credential list --identity-name <IDENTITY_NAME> --resource-group <RESOURCE_GROUP>

az identity federated-credential show --identity-name <IDENTITY_NAME> --resource-group <RESOURCE_GROUP> --name <CREDENTIAL_NAME>

az identity federated-credential create --identity-name <IDENTITY_NAME> --resource-group <RESOURCE_GROUP> --name <CREDENTIAL_NAME> --issuer <ISSUER_URL> --subject <SUBJECT> --audiences <AUDIENCE>