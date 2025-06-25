terragrunt run-all plan --non-interactive \
    --terragrunt-include-external-dependencies \
    --terragrunt-working-dir . \
    --terragrunt-include-dir .\azure-key-vault \
    --terragrunt-exclude-dir ./vnet-region-peering
