#!/bin/bash

# Define the project ID
PROJECT_ID="dxpro-uat-mcp-eks"

# Get the list of all secrets in the project and filter by names starting with "dxpro"
SECRETS=$(gcloud secrets list --project="$PROJECT_ID" --format="value(name)" | grep "^dxpro")

# Iterate over each secret and get its value
for SECRET in $SECRETS; do
  SECRET_VALUE=$(gcloud secrets versions access latest --secret="$SECRET" --project="$PROJECT_ID")
  echo "$SECRET:$SECRET_VALUE"
done