#! /bin/bash

# GitHub Repos
FAV_DIR="I. Favorite"
git clone https://github.com/khangtictoc/Productive-Workspace-Set-Up.git "$FAV_DIR/1.1 Productive Workspace"
git clone https://github.com/khangtictoc/DevOps-Tools-Installation-Scripts.git "$FAV_DIR/1.2 DevOps Tools"
git clone https://github.com/khangtictoc/khangtictoc.github.io.git "$FAV_DIR/2. My Blog"
git clone https://github.com/khangtictoc/myportfolio.git "$FAV_DIR/3. My Portfolio"
git clone https://github.com/khangtictoc/Personal-Pipelines.git "$FAV_DIR/4. Personal Pipelines"

LABS_DIR="II. Labs"
git clone https://github.com/khangtictoc/Monitoring--GrafanaStack.git "$LABS_DIR/1. Monitoring GrafanaStack"
git clone https://github.com/khangtictoc/Terragrunt_Project_Structure_Design.git "$LABS_DIR/2. Terragrunt Project"
git clone https://github.com/khangtictoc/ArgoCD-Apps.git "$LABS_DIR/3. ArgoCD Apps"
git clone https://github.com/khangtictoc/All-In-One-Devops-Pipelines.git "$LABS_DIR/4. All-In-One Devops Pipelines"
git clone https://github.com/khangtictoc/Jenkins-Library "$LABS_DIR/15. Jenkins Library"
git clone https://github.com/khangtictoc/POC-All-In-One-Azure.git "$LABS_DIR/6. POC"

# Gitlab Repos
TF_MOD_DIR="III. Gitlab/1. Terraform Modules"
git clone https://gitlab.com/terraform-modules7893436/general/naming.git "$TF_MOD_DIR/general/naming"
git clone https://gitlab.com/terraform-modules7893436/aws/eks.git "$TF_MOD_DIR/aws/eks"
git clone https://gitlab.com/terraform-modules7893436/hcp/vault-dedicated-cluster.git "$TF_MOD_DIR/hcp/vault-dedicated-cluster"
git clone https://gitlab.com/terraform-modules7893436/hcp/vault-components.git "$TF_MOD_DIR/hcp/vault-components"
git clone https://gitlab.com/terraform-modules7893436/kubernetes-deploy/helm.git "$TF_MOD_DIR/kubernetes-deploy/helm"

HELM_CHARTS_DIR="III. Gitlab/2. Helm Charts"
git clone https://gitlab.com/helm-charts2255608/java-app.git "$HELM_CHARTS_DIR/java-app"
