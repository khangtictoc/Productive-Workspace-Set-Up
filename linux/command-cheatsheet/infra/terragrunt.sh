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