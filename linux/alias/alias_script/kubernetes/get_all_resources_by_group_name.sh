#! /usr/bin/env bash


while [[ $# -gt 0 ]]; do
    case "$1" in
        --namespace)
            NAMESPACE="$2"
            shift 2
            ;;
        --name)
            NAME="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: kga-custom [--namespace NAMESPACE] [--name NAME]"
            echo "The name would be passed with 'grep' to filter the specific deployed resources."
            echo
            echo "For example: --name velero to get all Velero kind resources."
            echo
            echo "kubectl api-resources | grep velero"
            echo "backups                                                velero.io/v1                      true         Backup"
            echo "backupstoragelocations              bsl                velero.io/v1                      true         BackupStorageLocation"
            echo "volumesnapshotlocations             vsl                velero.io/v1                      true         VolumeSnapshotLocation"
            echo "..."
            echo
            exit 1
            ;;
    esac
done

NAME="${NAME:-}"
echo "DEBUG: $NAME"

mapfile -t RESOURCES < <(kubectl api-resources | grep "$NAME" | awk '{print $1}')

for resource in "${RESOURCES[@]}"; do
{
    {
    echo "===== kubectl get $resource ====="
    if [[ -n "${NAMESPACE}" ]]; then
        kubectl get "$resource" -n "${NAMESPACE}"
    else
        kubectl get "$resource" --all-namespaces
    fi
    
    echo
    } &> "out_$resource.txt"
} &
done

wait

for resource in "${RESOURCES[@]}"; do
cat "out_$resource.txt" &
done

wait

# Clean up
rm out_*.txt