## NODE
# Capacity
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,CPU_CORES:.status.capacity.cpu,ALLOC_CPU:.status.allocatable.cpu,ALLOC_EPHEMERAL_STORAGE:.status.allocatable.ephemeral-storage,ALLOC_MEM:.status.allocatable.memory,MAX_POD:.status.allocatable.pods'
# Timestamp
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,CREATED_AT:.metadata.creationTimestamp,LAST_HEALTHY:.status.conditions[0].lastHeartbeatTime'
# Addresses
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,HOST_TYPE:.status.addresses.*.type,ADDRESSES:.status.addresses.*.address'
# OS-level
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,ARCHITECTURE:.status.nodeInfo.architecture,CONTAINER_RUNTIME:.status.nodeInfo.containerRuntimeVersion,KERNEL_VER:.status.nodeInfo.kernelVersion,OS:.status.nodeInfo.osImage'
# Taints
kubectl get nodes -o json | jq -r '.items[] | select(.spec.taints[]? | select(.key=="dxp-united-oss" and .value=="true" and .effect=="NoSchedule")) | .metadata.name'
# Labels
kubectl get nodes -l <LABEL>

# Existing images & tag versions
kubectl get node aks-heavy9d45-26308833-vmss000000 -o jsonpath='{.status.images.*.names[0]}' |  tr ' ' '\n'
# Existing images
kubectl get node aks-heavy9d45-26308833-vmss000000 -o jsonpath='{.status.images.*.names[0]}' |  tr ' ' '\n' | cut -d ':' -f1

## PODS
# Timestamp
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CREATED_AT:.metadata.creationTimestamp,NAMESPACE:.metadata.namespace'
# Controlled by's resource
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTROLLED_BY:.metadata.ownerReferences[0].kind,NAMESPACE:.metadata.namespace'
# Custom  values
kubectl get pod <POD_NAME> -o custom-columns='POD NAME:.metadata.name,CONTROLLED_BY:.spec.containers[0].env.*,NAMESPACE:.metadata.namespace'
kubectl get pod <POD_NAME> -o custom-columns='POD NAME:.metadata.name,ENVIRONMENT_VAR:.spec.containers[0].env.*.name,NAMESPACE:.metadata.namespace'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,IMAGE:.spec.containers[0].image,PULL_POLICY:.spec.containers[0].imagePullPolicy,NAMESPACE:.metadata.namespace'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTAINER_PORT:.spec.containers[0].ports.*.containerPort,NAMESPACE:.metadata.namespace'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,REQUEST_CPU:.spec.containers[0].resources.requests.cpu,LIMIT_CPU:.spec.containers[0].resources.limits.cpu,REQUEST_MEM:.spec.containers[0].resources.requests.memory,LIMIT_MEM:.spec.containers[0].resources.limits.memory,REQUEST_EPHEMERAL_STORAGE:.spec.containers[0].resources.requests.ephemeral-storage,LIMIT_EPHEMERAL_STORAGE:.spec.containers[0].resources.limits.ephemeral-storage,NAMESPACE:.metadata.namespace'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,SECURITY_CONTEXT:.spec.containers[0].securityContext.privileged,AS_GROUP:.spec.containers[0].securityContext.runAsGroup,AS_USER:.spec.containers[0].securityContext.runAsUser,NON_ROOT:.spec.containers[0].securityContext.runAsNonRoot,SERVICE_ACCOUNT:.spec.serviceAccount,NAMESPACE:.metadata.namespace'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,VOLUME_MOUNT_PATH:.spec.containers[0].volumeMounts.*.mountPath,VOLUME_NAME:.spec.containers[0].volumeMounts.*.name,NAMESPACE:.metadata.namespace'

## Ingress
# All path rules
kubectl get ingress -o custom-columns="NAME:.metadata.name,PATHS:.spec.rules[].http.paths[*].path"


## ARGOCD APPLICATION
# List all applications with details
kubectl get app -o=custom-columns="NAME:.metadata.name,DESTINATION:.spec.destination.namespace,SERVER:.spec.destination.server,PROJECT:.spec.project,TARGET_REVISION:.spec.sources[0].targetRevision" -n argocd

## OTHERS
# List all pods running in a Node
kubectl get pods -o wide --all-namespaces --field-selector spec.nodeName=node-1

# Wait until reaching a specific state
kubectl wait --timeout=5m -n envoy-gateway-system deployment/envoy-gateway --for=condition=Available

## Force apply app using new ConfigMap
kubectl rollout restart deployment <DEPLOYMENT_NAME>
kubectl rollout status deployment --watch=true <DEPLOYMENT_NAME> 
kubectl rollout restart statefulsets <DEPLOYMENT_NAME>
kubectl rollout status statefulsets --watch=true <DEPLOYMENT_NAME> 

# Resources controlled by Helm
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm'
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=kube-prometheus-stack'

# Kubectl copy file/folder from local to pod & vice versa
kubectl cp <FILE> <CONTAINER>:/<PATH>
kubectl cp <CONTAINER>:/<PATH> <FILE> 

# Get events for a specific node
kubectl get events --field-selector involvedObject.kind=Node,involvedObject.name=dc-hpb7-rke2-prod-worker-105 --all-namespaces


# AWS EKS
# Get number of available pods that can be run on a node
kubectl get nodes -o json | jq '.items[].status.capacity.pods'

# Apply without actually creating YAML file
kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: example-config
data:
  key: value
EOF