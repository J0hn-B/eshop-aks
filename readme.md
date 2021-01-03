# AKS sample application with ArgoCD

> [!NOTE]
> AKS version of "GitOps K8s sample application deployment with ArgoCD". Use as reference.

GitOps project, based on ArgoCD. App of apps deployment style.

At a glance:

- 1: app: contains the argo project, the app for the eshop project and the helm chart (eshop) which creates the services. Services are on eshop repo.
- 2: azure: the terraform manifests for aks and azure infra.
- 3: k8s: contains the argo project, the argo app, the Helm charts (cert-manager, nginx-ingress etc..), and the K8s-configuration helm chart.

For the step by step configuration read the scripts/aks.sh
