#!/bin/bash

# Define the project ID
PROJECT_ID="dxpro-uat-mcp-eks"

# Get the list of all secrets in the project
SECRETS=$(gcloud secrets list --project="$PROJECT_ID" --format="value(name)")

# Iterate over each secret and delete it
for SECRET in $SECRETS; do
  echo "Deleting secret: $SECRET"
  gcloud secrets delete "$SECRET" --project="$PROJECT_ID" --quiet
done

echo "All secrets have been deleted."