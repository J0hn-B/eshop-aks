#!/bin/bash


# Get aks credentials
az aks get-credentials --resource-group aks --name dev-aks

# With stopped AKS cluster zero charges apply

# Stop the cluster
az aks stop -n dev-aks -g aks

# Start the cluster
# * az aks start -n dev-aks -g aks