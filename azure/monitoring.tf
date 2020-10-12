# Create Azure log analytics workspace
resource "azurerm_log_analytics_workspace" "law_01" {
  name                = "aks-resources"
  location            = azurerm_resource_group.monitor.location
  resource_group_name = azurerm_resource_group.monitor.name
  sku                 = "Free"
}

resource "azurerm_log_analytics_solution" "las_01" {
  solution_name         = "ContainerInsights"
  location              = azurerm_resource_group.monitor.location
  resource_group_name   = azurerm_resource_group.monitor.name
  workspace_resource_id = azurerm_log_analytics_workspace.law_01.id
  workspace_name        = azurerm_log_analytics_workspace.law_01.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}
