# Vault Dedicated Cluster

# Check Vault Cluster Seal Status
curl -s $VAULT_ADDR/v1/sys/seal-status | jq

# Environment Variables
export VAULT_ADDR="https://<VAULT_CLUSTER_ID>.vault.<REGION>.hashicorpcloud.com:8200"
export VAULT_NAMESPACE="admin"
export VAULT_TOKEN=<VAULT_ADMIN_TOKEN>

vault write auth/kubernetes/config \
        kubernetes_host="$KUBERNETES_HOST" \
        kubernetes_ca_cert=@ca.crt \
        token_reviewer_jwt=@token.jwt