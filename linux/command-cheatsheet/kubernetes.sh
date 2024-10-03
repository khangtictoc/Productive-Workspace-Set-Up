#! /bin/bash

## Get custom columns/values of Node
# Get capacity info
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,CPU_CORES:.status.capacity.cpu,ALLOC_CPU:.status.allocatable.cpu,ALLOC_EPHEMERAL_STORAGE:.status.allocatable.ephemeral-storage,ALLOC_MEM:.status.allocatable.memory,MAX_POD:.status.allocatable.pods'
# Get timestamp info
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,CREATED_AT:.metadata.creationTimestamp,LAST_HEALTHY:.status.conditions[0].lastHeartbeatTime'
# Get address info
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,HOST_TYPE:.status.addresses.*.type,ADDRESSES:.status.addresses.*.address'
# Get OS-level info
kubectl get nodes -o custom-columns='NODE NAME:.metadata.name,ARCHITECTURE:.status.nodeInfo.architecture,CONTAINER_RUNTIME:.status.nodeInfo.containerRuntimeVersion,KERNEL_VER:.status.nodeInfo.kernelVersion,OS:.status.nodeInfo.osImage'


# Get downloaded/existing images and corresponding one version of tag
kubectl get node aks-heavy9d45-26308833-vmss000000 -o jsonpath='{.status.images.*.names[0]}' |  tr ' ' '\n'
# Get downloaded/existing images
kubectl get node aks-heavy9d45-26308833-vmss000000 -o jsonpath='{.status.images.*.names[0]}' |  tr ' ' '\n' | cut -d ':' -f1

## Get custom columns/values of Pod
# Get timestamp info
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CREATED_AT:.metadata.creationTimestamp'
# Get controlling resources
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTROLLED_BY:.metadata.ownerReferences[0].kind'
# Get environment variables
kubectl get pod <POD_NAME> -o custom-columns='POD NAME:.metadata.name,CONTROLLED_BY:.spec.containers[0].env.*'
kubectl get pod <POD_NAME> -o custom-columns='POD NAME:.metadata.name,CONTROLLED_BY:.spec.containers[0].env.*.name'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTROLLED_BY:.spec.containers[0].image,CONTROLLED_BY:.spec.containers[0].imagePullPolicy'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTAINER_PORT:.spec.containers[0].ports.*.containerPort'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,REQUEST_CPU:.spec.containers[0].resources.requests.cpu,LIMIT_CPU:.spec.containers[0].resources.limits.cpu,REQUEST_MEM:.spec.containers[0].resources.requests.memory,LIMIT_MEM:.spec.containers[0].resources.limits.memory,REQUEST_EPHEMERAL_STORAGE:.spec.containers[0].resources.requests.ephemeral-storage,LIMIT_EPHEMERAL_STORAGE:.spec.containers[0].resources.limits.ephemeral-storage'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,SECURITY_CONTEXT:.spec.containers[0].securityContext.privileged,AS_GROUP:.spec.containers[0].securityContext.runAsGroup,AS_USER:.spec.containers[0].securityContext.runAsUser,NON_ROOT:.spec.containers[0].securityContext.runAsNonRoot,SERVICE_ACCOUNT:.spec.serviceAccount'
kubectl get pods -o custom-columns='POD NAME:.metadata.name,VOLUME_MOUNT_PATH:.spec.containers[0].volumeMounts.*.mountPath,VOLUME_NAME:.spec.containers[0].volumeMounts.*.name'


## Force apply app using new ConfigMap
kubectl rollout restart deployment configmap-env-var
kubectl rollout status deployment configmap-env-var --watch=true