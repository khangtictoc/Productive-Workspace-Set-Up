az aks  enable-addons \
    --resource-group <RESOURCE_GROUP> \
    --name <CLUSTER_NAME> \
    --addons ingress-appgw \
    --appgw-name <APPLICATION_GATEWAY_NAME> \
    --appgw-subnet-cidr <APPLICATION_GATEWAY_SUBNET_CIDR>


az aks get-credentials \
    --resource-group <RESOURCE_GROUP> \
    --name <CLUSTER_NAME>