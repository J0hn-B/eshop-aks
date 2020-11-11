#!/bin/bash

# Fetch Azure credentials 
AZURE_TENANT_ID=$(az ad sp list --display-name terraform-sp --query "[].appOwnerTenantId" -o tsv)
AZURE_CLIENT_ID=$(az ad sp list --display-name terraform-sp --query "[].appId" -o tsv)
AZURE_CLIENT_SECRET=$(az keyvault secret show --name "password" --vault-name "terraform-keyvault01" --query "value" -o tsv)

# Create the namespace to allow secrets to be stored
kubectl create namespace external-secrets

# Create K8s secrets
kubectl create secret generic azure-credentials  \
--from-literal=tenantid=$AZURE_TENANT_ID  \
--from-literal=clientid=$AZURE_CLIENT_ID  \
--from-literal=clientsecret=$AZURE_CLIENT_SECRET  \
-n external-secrets