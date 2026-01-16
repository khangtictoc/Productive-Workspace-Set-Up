az aks enable-addons \
    --resource-group <RESOURCE_GROUP> \
    --name <CLUSTER_NAME> \
    --addons ingress-appgw \
    --appgw-name <APPLICATION_GATEWAY_NAME> \
    --appgw-subnet-cidr <APPLICATION_GATEWAY_SUBNET_CIDR>

# Kubeconfig
az aks get-credentials \
    --resource-group <RESOURCE_GROUP> \
    --name <CLUSTER_NAME>

# Reconcile

## Whole cluster
az aks update \
    --resource-group <RESOURCE_GROUP> \
    --name <CLUSTER_NAME>

## Nodepool only
az aks nodepool update \
    --resource-group <RESOURCE_GROUP> \
    --cluster-name <CLUSTER_NAME> \
    --name <NODEPOOL_NAME>

# Show operations
az aks show \
    --resource-group <RESOURCE_GROUP> \
    --name <CLUSTER_NAME>

# Abort operation
az aks operation-abort \
    --resource-group <RESOURCE_GROUP> \
    --name <CLUSTER_NAME> \
    --operation-id <OPERATION_ID>