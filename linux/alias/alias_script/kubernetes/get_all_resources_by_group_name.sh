#! /usr/bin/env bash


while [[ $# -gt 0 ]]; do
    case "$1" in
        --namespace)
            NAMESPACE="$2"
            shift 2
            ;;
        --pattern-name)
            PATTERN_NAME="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: kga-custom [--namespace NAMESPACE] [--pattern-name PATTERN_NAME]"
            echo "The pattern name would be passed with 'grep' to filter the specific deployed resources."
            echo
            echo "For example: --pattern-name velero to get all Velero kind resources."
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

PATTERN_NAME="${PATTERN_NAME:-}"
echo "DEBUG: $PATTERN_NAME"

mapfile -t RESOURCES < <(kubectl api-resources | grep "$PATTERN_NAME" | awk '{print $1}')

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

# wait

# Clean up
if [[ -n "$(ls out_*.txt 2>/dev/null)" ]]; then
    rm out_*.txt
fi