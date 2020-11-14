#!/bin/bash

# Create AKS Cluster
cd ../azure && terraform apply --auto-approve

# Get aks credentials
az aks get-credentials --resource-group aks --name dev-aks --overwrite-existing

# Install ArgoCD
source ../scripts/./argocd_install.sh

# Create Azure Credentials secrets to allow external-secrets controller configuration
source ../scripts/./external-secrets.sh

# Configure cluster's management
cd ../k8s && kubectl apply -f argo_config/k8s-project.yml && kubectl apply -f argo_config/k8s-app.yml

# ? Important: Update the loadBalancerIP public ip in the k8s-configuration/values.yaml or from ArgoCD ui --> ingress app --> parameters controller.service.loadBalancerIP
# ? ( az network public-ip show -g aks -n ingress-ip-01 --query ipAddress -o tsv )

# Deploy the application
##cd ../app && kubectl apply -f argo_config/eshop-project.yml && kubectl apply -f argo_config/eshop-app.yml

# Access ArgoCD web interface
# kubectl port-forward svc/argocd-server -n argocd 8080:443

******************************************************************
# With stopped AKS cluster zero charges apply

# Stop the cluster
# * az aks stop -n dev-aks -g aks

# Start the cluster
# * az aks start -n dev-aks -g aks

******************************************************************
