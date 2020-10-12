# Create the file share  for the cluster
resource "azurerm_storage_account" "file_share" {
  name                     = "cluster01shared01dev"
  resource_group_name      = azurerm_resource_group.aks.name
  location                 = azurerm_resource_group.aks.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = "Development"
  }
}

resource "azurerm_storage_share" "file_share" {
  name                 = "k8share"
  storage_account_name = azurerm_storage_account.file_share.name
  quota                = 50

}
