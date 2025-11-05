# Vault Dedicated Cluster

# Check Vault Cluster Seal Status
curl -s $VAULT_ADDR/v1/sys/seal-status | jq

# Environment Variables
export VAULT_ADDR="https://<VAULT_ENDPOINT_URL>:8200"
export VAULT_NAMESPACE="admin"
export VAULT_TOKEN=<VAULT_ADMIN_TOKEN>

TOKEN_REVIEW_JWT=$(kubectl get secret vault-auth --output='go-template={{ .data.token }}' | base64 --decode) 
KUBE_CA_CERT=$(kubectl config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.certificate-authority-data}' | base64 --decode) 
KUBE_HOST=$(kubectl config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.server}')

vault write auth/kubernetes/config \
        kubernetes_host="$KUBERNETES_HOST" \
        kubernetes_ca_cert=@ca.crt \
        token_reviewer_jwt=@token.jwt

# --- Testing K8s Auth (With Service Account) ---

kubectl apply -f- <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: dummy
  namespace: dummy
EOF

vault policy write dummy - <<EOF
path "*" {
   capabilities = ["read"]
}
EOF

vault write auth/kubernetes/role/dummy \
  bound_service_account_names=dummy \
  bound_service_account_namespaces=dummy \
  policies=dummy \
  ttl=24h \
  audience="vault"


kubectl create token dummy -n dummy --audience vault > token-dummy.jwt

vault write auth/kubernetes/login \
  role=dummy \
  jwt=@token-dummy.jwt

vault secrets enable -namespace="admin" -path="kvv2" kv-v2
vault kv put kvv2/webapp/config username="static-user" password="static-password"

vault delete auth/kubernetes/role/dummy
