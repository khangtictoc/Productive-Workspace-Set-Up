name: "[1.0] Terraform - Deploy Kubernetes Single Cloud"

on:
  # push:
  #   branches:
  #     - main

  # schedule:
  #   # Runs at 07:00 AM in every month.
  #   - cron: "0 17 */1 * *"
  repository_dispatch:
    types: [terraform_deploy_kubernetes_single_cloud]

  # Optional: You can also allow manual runs
  workflow_dispatch:
    inputs:
      shell_type:
        description: "Choose Shell Type"
        required: false
        default: "azure"
        type: choice
        options:
          - bash
          - zsh

jobs:
  verify-configuration:
    runs-on: ubuntu-latest

    steps:
      - name: Verify Input
        run: |
          echo "Deploy Kubernetes: ${{ github.event.inputs.shell_type }}"

  deploy-cluster-infra:
    runs-on: ubuntu-latest
    steps:
      - name: Terragrunt Plan
        if: ${{ github.event.inputs.terraform_action == 'plan' && github.event.inputs.deploy_kubernetes == 'false' }}
        run: |
          cd "Terragrunt_Project_Structure_Design/environment/${{ github.event.inputs.environment }}/${{ github.event.inputs.cloud_provider }}/$REGION/${{ github.event.inputs.modules }}"
          terragrunt run --all  --non-interactive plan



  deploy-k8s-components:
    runs-on: ubuntu-latest
    if: ${{ github.event.inputs.deploy_kubernetes == 'true' }}
    needs: deploy-cluster-infra
    steps:
      - name: Kubernetes Components - Terragrunt Plan
        if: ${{ github.event.inputs.terraform_action == 'plan' }}
        run: |
          cd "Terragrunt_Project_Structure_Design/environment/${{ github.event.inputs.environment }}/kubernetes/${{ github.event.inputs.cloud_provider }}/$REGION"
          terragrunt run --all  --non-interactive plan



  cleanup:
    runs-on: ubuntu-latest
    if: always()
    needs: [deploy-cluster-infra, deploy-k8s-components]
    steps:
      - name: Checkout code
        uses: actions/checkout@v5
      - name: Cleanup resources
        run: |
          chmod +x script/remove_tf_lock.sh
          ./script/remove_tf_lock.sh $REGION "terragrunt-state-lock"
