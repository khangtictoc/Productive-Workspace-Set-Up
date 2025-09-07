# Login & Authorize
az login --service-principal -u <CLIENT_ID> -p <CLIENT_SECRET> --tenant <TENANT_ID>

## SUBSCRIPTION
# Set
az account set --subscription <SUBSCRIPTION_ID>

# List
az account list --output table

# Get current
az account show --output table

## RESOURCE GROUP
# Get
az group list --output table