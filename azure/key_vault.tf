# Create Azure Key Vault for the AKS cluster
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "aks_kv_01" {
  name                        = "aks-rotation-key-vault"
  location                    = azurerm_resource_group.aks.location
  resource_group_name         = azurerm_resource_group.aks.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
      "create",
      "list",
      "delete"
    ]

    secret_permissions = [
      "get",
      "set",
      "list",
      "delete"
    ]

    storage_permissions = [
      "get",
      "list",
      "delete"
    ]
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }


  tags = {
    Environment = "Development"
  }
}
