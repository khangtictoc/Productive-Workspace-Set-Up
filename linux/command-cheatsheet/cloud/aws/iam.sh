# Generate temporary credentials with current user privileges
aws sts get-session-token --duration-seconds 3600

#  Assume a role to get temp credentials
aws sts assume-role \
    --role-arn <role-arn> \
    --role-session-name my-session

# Check current IAM user
aws sts get-caller-identity