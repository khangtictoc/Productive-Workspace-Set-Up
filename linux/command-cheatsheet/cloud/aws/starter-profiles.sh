
# List all profiles
aws configure list-profiles

# View current profile
aws configure list

# Select a profile
export AWS_DEFAULT_PROFILE=<profile_name>

# Create a new profile
aws configure --profile <new_profile_name>