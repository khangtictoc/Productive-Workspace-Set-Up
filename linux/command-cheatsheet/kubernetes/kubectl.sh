## NODE ##
# Capacity
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,CPU_CORES:.status.capacity.cpu,ALLOC_CPU:.status.allocatable.cpu,ALLOC_EPHEMERAL_STORAGE:.status.allocatable.ephemeral-storage,ALLOC_MEM:.status.allocatable.memory,MAX_POD:.status.allocatable.pods'
# Timestamp
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,CREATED_AT:.metadata.creationTimestamp,LAST_HEALTHY:.status.conditions[0].lastHeartbeatTime'
# Addresses
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,HOST_TYPE:.status.addresses.*.type,ADDRESSES:.status.addresses.*.address'
# OS-level
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,ARCHITECTURE:.status.nodeInfo.architecture,CONTAINER_RUNTIME:.status.nodeInfo.containerRuntimeVersion,KERNEL_VER:.status.nodeInfo.kernelVersion,OS:.status.nodeInfo.osImage'
# Taints
kubectl get nodes -o json | jq -r '.items[] | select(.spec.taints[]? | select(.key=="<TAIN_KEY>" and .value=="<TAIN_VALUE>" and .effect=="NoSchedule")) | .metadata.name'
# Labels
kubectl get nodes -l <LABEL>
# Maximum pods
# Azure
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,MAX_PODS:.status.maxPods'
# AWS
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,MAX_PODS:.status.allocatable.pods'
# Existing images & tag versions
kubectl get node <NODE_NAME> -o jsonpath='{.status.images.*.names[0]}' |  tr ' ' '\n'
# Existing images
kubectl get node <NODE_NAME> -o jsonpath='{.status.images.*.names[0]}' |  tr ' ' '\n' | cut -d ':' -f1

## PODS ##
# Timestamp
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CREATED_AT:.metadata.creationTimestamp,NAMESPACE:.metadata.namespace'
# Controlled by's resource
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTROLLED_BY:.metadata.ownerReferences[0].kind,NAMESPACE:.metadata.namespace'
# Get pod with environment variables
# By name-value
kubectl get pod <POD_NAME> -o custom-columns='POD NAME:.metadata.name,ENVIRONMENT_VAR:.spec.containers.*.env.*,NAMESPACE:.metadata.namespace'
# By name only
kubectl get pod <POD_NAME> -o custom-columns='POD NAME:.metadata.name,ENVIRONMENT_VAR:.spec.containers.*.env.*.name,NAMESPACE:.metadata.namespace'
# Using images & pull policy
kubectl get pods -o custom-columns='POD NAME:.metadata.name,IMAGE:.spec.containers.*.image,PULL_POLICY:.spec.containers.*.imagePullPolicy,NAMESPACE:.metadata.namespace'
# Container ports
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTAINER_PORT:.spec.containers.*.ports.*.containerPort,NAMESPACE:.metadata.namespace'
# Container requests/limits
kubectl get pods -o custom-columns='POD NAME:.metadata.name,REQUEST_CPU:.spec.containers.*.resources.requests.cpu,LIMIT_CPU:.spec.containers.*.resources.limits.cpu,REQUEST_MEM:.spec.containers.*.resources.requests.memory,LIMIT_MEM:.spec.containers.*.resources.limits.memory,REQUEST_EPHEMERAL_STORAGE:.spec.containers.*.resources.requests.ephemeral-storage,LIMIT_EPHEMERAL_STORAGE:.spec.containers.*.resources.limits.ephemeral-storage,NAMESPACE:.metadata.namespace'
# Container permissions
kubectl get pods -o custom-columns='POD NAME:.metadata.name,SECURITY_CONTEXT:.spec.containers.*.securityContext.privileged,AS_GROUP:.spec.containers.*.securityContext.runAsGroup,AS_USER:.spec.containers.*.securityContext.runAsUser,NON_ROOT:.spec.containers.*.securityContext.runAsNonRoot,SERVICE_ACCOUNT:.spec.serviceAccount,NAMESPACE:.metadata.namespace'
# Container volume mounts
kubectl get pods -o custom-columns='POD NAME:.metadata.name,VOLUME_MOUNT_PATH:.spec.containers.*.volumeMounts.*.mountPath,VOLUME_NAME:.spec.containers.*.volumeMounts.*.name,NAMESPACE:.metadata.namespace'
# List all pods running in a Node
kubectl get pods -o wide --all-namespaces --field-selector spec.nodeName=node-1

## INGRESS ## 
# All path rules
kubectl get ingress -o custom-columns="NAME:.metadata.name,PATHS:.spec.rules[].http.paths[*].path"

## ARGOCD ##
# List all applications with details
kubectl get app -o=custom-columns="NAME:.metadata.name,DESTINATION:.spec.destination.namespace,SERVER:.spec.destination.server,PROJECT:.spec.project,TARGET_REVISION:.spec.sources[0].targetRevision" -n argocd

## EVENTS ##
# Get events for a specific node
kubectl get events --field-selector involvedObject.kind=Node,involvedObject.name=<NODE_NAME> --all-namespaces

## OTHERS ##
# Wait until reaching a specific state
kubectl wait --timeout=5m -n <NAMESPACE> deployment/<DEPLOYMENT_NAME> --for=condition=Available

## Force apply app using new ConfigMap
kubectl rollout restart deployment <DEPLOYMENT_NAME>
kubectl rollout status deployment --watch=true <DEPLOYMENT_NAME> 
kubectl rollout restart statefulsets <DEPLOYMENT_NAME>
kubectl rollout status statefulsets --watch=true <DEPLOYMENT_NAME> 

# Resources controlled by Helm
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm'
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=<APP_NAME>'
# Resources controlled by ArgoCD
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=<APP_NAME>,argocd.argoproj.io/instance=<ARGOCD_APP_NAME>'
# Resources controlled by Kustomize
kubectl get all --all-namespaces -l='app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=<APP_NAME>,kustomize.toolkit.fluxcd.io/name=<KUSTOMIZE_APP_NAME>'

# Kubectl copy file/folder from local to pod & vice versa
kubectl cp <FILE> <CONTAINER>:/<PATH>
kubectl cp <CONTAINER>:/<PATH> <FILE> 



# Apply without actually creating YAML file
kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: example-config
data:
  key: value
EOF