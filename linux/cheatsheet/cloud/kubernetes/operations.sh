# List all pods running in a Node
kubectl get pods -o wide --all-namespaces --field-selector spec.nodeName=<NODE_NAME>


## EVENTS ##
# Get events for a specific node
kubectl get events --field-selector involvedObject.kind=Node,involvedObject.name=<NODE_NAME> --all-namespaces

## OTHERS ##
# Wait until reaching a specific state
kubectl wait --timeout=5m -n <NAMESPACE> deployment/<DEPLOYMENT_NAME> --for=condition=Available

# Rollout restart workload
kubectl rollout restart deployment <DEPLOYMENT_NAME>
kubectl rollout status deployment --watch=true <DEPLOYMENT_NAME> 
kubectl rollout restart statefulsets <DEPLOYMENT_NAME>
kubectl rollout status statefulsets --watch=true <DEPLOYMENT_NAME> 

# Scale workload
kubectl scale deployment <DEPLOYMENT_NAME> --replicas=0 -n <NAMESPACE>
kubectl scale deployment <DEPLOYMENT_NAME> --replicas=<NUMBER_OF_REPLICAS> -n <NAMESPACE>
kubectl scale statefulsets <STATEFULSET_NAME> --replicas=0 -n <NAMESPACE>
kubectl scale statefulsets <STATEFULSET_NAME> --replicas=<NUMBER_OF_REPLICAS> -n <NAMESPACE>


# Resources controlled by Helm
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm'
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=<APP_NAME>'

# Resources controlled by ArgoCD
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=<APP_NAME>,argocd.argoproj.io/instance=<ARGOCD_APP_NAME>'

# Resources controlled by Kustomize
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=<APP_NAME>,kustomize.toolkit.fluxcd.io/name=<KUSTOMIZE_APP_NAME>'

# Kubectl copy file/folder from local to pod & vice versa
kubectl cp <LOCAL_FILE> <CONTAINER>:/<PATH>
kubectl cp <CONTAINER>:/<PATH> <LOCAL_FILE> 

# Apply without creating YAML file
kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: example-config
data:
  key: value
EOF

# Show diffs between applying manifests and deployed ones (colorful)
KUBECTL_EXTERNAL_DIFF="diff --color=always -u" kubectl diff -f <YAML_FILE>

# Check authorization for a user/service account
kubectl auth can-i create token -n kube-system --as=system:serviceaccount:kube-system:default

# Delete hanged Terminating namespace

NAMESPACE=<NAMESPACE_NAME>
kubectl proxy &
kubectl get namespace $NAMESPACE -o json | jq '.spec = {"finalizers":[]}' >temp.json
curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize


# KUBECONFIG
kubectl config set-credentials 60099@internal.users --client-key=60099.key --client-certificate=60099.crt
kubectl config set-context 60099@internal.users --cluster=kubernetes --user=60099@internal.users

# Certificate

kubectl certificate approve 60099@internal.users