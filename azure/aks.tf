
# Create the vnet for the cluster
resource "azurerm_virtual_network" "k8s" {
  name                = "aks-vnet"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  address_space       = ["192.168.0.0/16"]

  tags = {
    Environment = "Development"
  }
}

# Create the vnet subnet for the cluster
resource "azurerm_subnet" "k8s" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.aks.name
  address_prefixes     = ["192.168.1.0/24"]
  virtual_network_name = azurerm_virtual_network.k8s.name

}



# Create the AKS cluster
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "dev-aks"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "dev-eshop"

  default_node_pool {
    name                = "vmscaleset"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 4
    vm_size             = "Standard_B2s"
    os_disk_size_gb     = 30

    vnet_subnet_id = azurerm_subnet.k8s.id
  }
  node_resource_group = "k8s-resources"

  service_principal {
    client_id     = data.azurerm_key_vault_secret.terr_sp_client_id.value
    client_secret = data.azurerm_key_vault_secret.terr_sp_client_secret.value
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {

    kube_dashboard {
      enabled = true
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.law_01.id
    }

  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"

  }

  tags = {
    Environment = "Development"
  }
}

# Get terraform service principal client id 
data "azurerm_key_vault_secret" "terr_sp_client_id" {
  name         = "appId"
  key_vault_id = data.azurerm_key_vault.vault_01.id
}

# Get terraform service principal secret
data "azurerm_key_vault_secret" "terr_sp_client_secret" {
  name         = "password"
  key_vault_id = data.azurerm_key_vault.vault_01.id
}
