#!/bin/bash

# Define the account and permission to check
ACCOUNT="khang.tran@mercatus.com"
PERMISSION="iam.serviceAccounts.list"

# Get the list of all projects
PROJECTS=$(gcloud projects list --format="value(projectId)")

# Iterate over each project and check the permission
for PROJECT in $PROJECTS; do
  echo "Checking permission in project: $PROJECT"
  gcloud projects get-iam-policy $PROJECT --flatten="bindings[].members" --format="table(bindings.role)" --filter="bindings.members:$ACCOUNT AND bindings.role:roles/$PERMISSION"
done