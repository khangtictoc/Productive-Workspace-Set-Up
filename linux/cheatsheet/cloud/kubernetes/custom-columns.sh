## PODS ##

# Timestamp
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CREATED_AT:.metadata.creationTimestamp,NAMESPACE:.metadata.namespace'

# Controlled By's resource
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTROLLED_BY:.metadata.ownerReferences[0].kind,NAMESPACE:.metadata.namespace'

# Get pod with environment variables
# By name-value
kubectl get pod <POD_NAME> -o custom-columns='POD NAME:.metadata.name,ENVIRONMENT_VAR:.spec.containers.*.env.*,NAMESPACE:.metadata.namespace'
# By name only
kubectl get pod <POD_NAME> -o custom-columns='POD NAME:.metadata.name,ENVIRONMENT_VAR:.spec.containers.*.env.*.name,NAMESPACE:.metadata.namespace'

# Pod's images
kubectl get pods -o custom-columns='POD NAME:.metadata.name,IMAGE:.spec.containers.*.image,PULL_POLICY:.spec.containers.*.imagePullPolicy,NAMESPACE:.metadata.namespace'

# Container ports
kubectl get pods -o custom-columns='POD NAME:.metadata.name,CONTAINER_PORT:.spec.containers.*.ports.*.containerPort,NAMESPACE:.metadata.namespace'

# Resource requests/limits
kubectl get pods -o custom-columns='POD NAME:.metadata.name,REQUEST_CPU:.spec.containers.*.resources.requests.cpu,LIMIT_CPU:.spec.containers.*.resources.limits.cpu,REQUEST_MEM:.spec.containers.*.resources.requests.memory,LIMIT_MEM:.spec.containers.*.resources.limits.memory,REQUEST_EPHEMERAL_STORAGE:.spec.containers.*.resources.requests.ephemeral-storage,LIMIT_EPHEMERAL_STORAGE:.spec.containers.*.resources.limits.ephemeral-storage,NAMESPACE:.metadata.namespace'

# Container permissions
kubectl get pods -o custom-columns='POD NAME:.metadata.name,SECURITY_CONTEXT:.spec.containers.*.securityContext.privileged,AS_GROUP:.spec.containers.*.securityContext.runAsGroup,AS_USER:.spec.containers.*.securityContext.runAsUser,NON_ROOT:.spec.containers.*.securityContext.runAsNonRoot,SERVICE_ACCOUNT:.spec.serviceAccount,NAMESPACE:.metadata.namespace'

# Container volume mounts
kubectl get pods -o custom-columns='POD NAME:.metadata.name,VOLUME_MOUNT_PATH:.spec.containers.*.volumeMounts.*.mountPath,VOLUME_NAME:.spec.containers.*.volumeMounts.*.name,NAMESPACE:.metadata.namespace'

## AZURE POD IDENTITY ##
kubectl get deployment -A -o custom-columns='NAMESPACE:.metadata.namespace,DEPLOYMENT_NAME:.metadata.name,LABEL:.spec.template.metadata.labels.aadpodidbinding,REPLICAS:.spec.replicas'

## AZURE WORKLOAD IDENTITY (DEPRECATED) ##
kubectl get deployment -A -o custom-columns='NAMESPACE:.metadata.namespace, NAME:.metadata.name, SERVICE_ACCOUNT:.spec.template.spec.serviceAccountName, LABEL:.spec.template.metadata.labels.aadpodidbinding'
kubectl get statefulset -A -o custom-columns='NAMESPACE:.metadata.namespace, NAME:.metadata.name, SERVICE_ACCOUNT:.spec.template.spec.serviceAccountName, LABEL:.spec.template.metadata.labels.aadpodidbinding'