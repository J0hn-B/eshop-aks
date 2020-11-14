# Chaos Testing Notes

  Create service account

   kubectl create serviceaccount chaos-sa -n chaos-testing

   kubectl create role chaos-role --verb=create,get,list,watch --resource=crds -n chaos-testing

   kubectl create rolebinding chaos-rolebinding --role=chaos-role --serviceaccount=chaos-testing:chaos-sa -n chaos-testing

   kubectl auth can-i get crds -n chaos-testing --as system:serviceaccount:chaos-testing:chaos-sa -n chaos-testing

## kubectl patch example

  kubectl get services nginx-ingress-ingress-nginx-controller -n ingress-basic -o yaml

  kubectl patch service nginx-ingress-ingress-nginx-controller -n ingress-basic -p '{"spec":{"loadBalancerIP":"20.54.94.247"}}'

## Azure get public ip
  
  az network public-ip show -g aks -n ingress-ip-01 --query ipAddress -o tsv

## Override Helm values

  Check  nginx-ingress.yml at k8s-configuration Helm chart


PUBLIC_IP=$(az network public-ip show -g aks -n ingress-ip-01 --query ipAddress -o tsv)





"##vso[task.setvariable variable=public_ip]$PUBLIC_IP"