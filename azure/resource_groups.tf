# Create AKS resource group
resource "azurerm_resource_group" "aks" {
  name     = "aks"
  location = "North Europe"
}

# Create NFS Server resource group
resource "azurerm_resource_group" "nfs" {
  name     = "nfs-server"
  location = "North Europe"
}

# Create monitoring resource group
resource "azurerm_resource_group" "monitor" {
  name     = "monitoring"
  location = "North Europe"
}
