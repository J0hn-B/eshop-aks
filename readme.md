# Using the project

1: from your terminal go to ~/eshop-aks/scripts and run ./aks.sh

az network public-ip create --resource-group aks --name ingress-main --sku Standard --allocation-method static --query publicIp.ipAddress -o tsv

helm install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace ingress-basic \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set controller.service.loadBalancerIP="20.54.33.82" \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"="dev-aks-eshop"