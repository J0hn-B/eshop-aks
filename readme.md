# AKS sample application with ArgoCD PoC demo

GitOps project, based on ArgoCD. App of apps deployment style.

Use as reference.

At a glance:

- 1: app: contains the argo project, the app for the eshop project and the helm chart (eshop) which creates the services. Services are on eshop repo.
- 2: azure: the terraform manifests for aks and azure infra.
- 3: k8s: contains the argo project, the argo app, the Helm charts (cert-manager, nginx-ingress etc..), and the K8s-configuration helm chart.

For the step by step configuration read the scripts/aks.sh

- After aks creation an ArgoCD App, called k8s-cluster-management, will configure the cluster with the related Helm Charts.
- Helm Charts are stored in k8s/k8s-charts folder. *(fetch, update values and push to the repo)*
- K8s-configuration is a Helm chart, which creates a seperate argocd app for every Helm Chart. *(App of Apps)*
This chart is responsible for the K8s cluster management.
