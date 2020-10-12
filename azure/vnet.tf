# Create the VNET for the NFS Server
resource "azurerm_virtual_network" "nfs_vnet" {
  name                = "vm-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.nfs.location
  resource_group_name = azurerm_resource_group.nfs.name
}

# Create the VNET's subnet for the NFS Server
resource "azurerm_subnet" "nfs_vnet_subnet_01" {
  name                 = "subnet-01"
  resource_group_name  = azurerm_resource_group.nfs.name
  virtual_network_name = azurerm_virtual_network.nfs_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create the VNET peering between AKS and NFS Server
resource "azurerm_virtual_network_peering" "nfs_vnet" {
  name                      = "nfs_vnet-to-k8s"
  resource_group_name       = azurerm_resource_group.nfs.name
  virtual_network_name      = azurerm_virtual_network.nfs_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.k8s.id
}

resource "azurerm_virtual_network_peering" "k8s_vnet" {
  name                      = "k8s-to-nfs_vnet"
  resource_group_name       = azurerm_resource_group.aks.name
  virtual_network_name      = azurerm_virtual_network.k8s.name
  remote_virtual_network_id = azurerm_virtual_network.nfs_vnet.id
}
