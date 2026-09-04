#! /bin/bash

git clone https://github.com/khangtictoc/Productive-Workspace-Set-Up.git "1.1 Productive Workspace"
git clone https://github.com/khangtictoc/DevOps-Tools-Installation-Scripts.git "1.2 DevOps Tools"
git clone https://github.com/khangtictoc/khangtictoc.github.io.git "2. My Blog"
git clone https://github.com/khangtictoc/myportfolio.git "3. My Portfolio"
git clone https://github.com/khangtictoc/Personal-Pipelines.git "4. Personal Pipelines"


git clone https://github.com/khangtictoc/Monitoring--GrafanaStack.git "10. Monitoring GrafanaStack"
git clone https://github.com/khangtictoc/Terragrunt_Project_Structure_Design.git "11. Terragrunt Project"
git clone https://github.com/khangtictoc/ArgoCD-Apps.git "12. ArgoCD Apps"
git clone https://github.com/khangtictoc/All-In-One-Devops-Pipelines.git "13. All-In-One Devops Pipelines"
git clone https://github.com/khangtictoc/Jenkins-Library "14. Jenkins Library"
git clone https://github.com/khangtictoc/POC-All-In-One-Azure.git "15. POC"

# Gitlab Repos
mkdir -p "20. Terraform modules"
cd "20. Terraform modules"
git clone https://gitlab.com/terraform-modules7893436/aws/eks.git "aws/eks"
git clone https://gitlab.com/terraform-modules7893436/azure/naming.git "azure/naming"
git clone https://gitlab.com/terraform-modules7893436/hcp/vault-dedicated-cluster.git "hcp/vault-dedicated-cluster"
git clone https://gitlab.com/terraform-modules7893436/hcp/vault-components.git "hcp/vault-components"
git clone https://gitlab.com/terraform-modules7893436/kubernetes-deploy/helm.git "kubernetes-deploy/helm"
cd ..

mkdir -p "21. Helm Charts"
cd "21. Helm Charts"
git clone https://gitlab.com/helm-charts2255608/java-app.git
cd ..
