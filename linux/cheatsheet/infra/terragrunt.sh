# Operate on selected directories
terragrunt run-all plan --non-interactive \
    --queue-include-external \
    --working-dir . \
    --queue-include-dir <sub-dir1> \
    --queue-include-dir <sub-dir2> \
    --terragrunt-exclude-dir <excluded-dir> \


# Operate on all directories
terragrunt run-all plan --non-interactive \
    --queue-include-external \
    --working-dir . 

# Format files
terragrunt hclfmt --terragrunt-working-dir . # .hcl 
terraform fmt -recursive # .tf, .tfvars, .tfstate, .tfstate.backup 


# Delete local cache in a folder
folder_name=""
find $FOLDER_NAME -type d -name ".terragrunt-cache" -prune -exec rm -rf {} +


# Remove an object/instance state
# NOTE: Be inside a module directory

terragrunt run --non-interactive state list
terragrunt run --non-interactive state rm "kubernetes_service_account_v1.alb_controller[0]"