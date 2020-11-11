# Create AKS Ingress Public IP
resource "azurerm_public_ip" "ingress_ip_01" {
  name                = "ingress-ip-01"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  allocation_method   = "Static"
  domain_name_label   = "dev-aks-eshop"
  sku                 = "Standard"

  tags = {
    Environment = "Development"
  }
}

data "azurerm_public_ip" "ingress_ip_01" {
  name                = azurerm_public_ip.ingress_ip_01.name
  resource_group_name = azurerm_resource_group.aks.name
  depends_on = [
    azurerm_public_ip.ingress_ip_01
  ]
}

resource "azurerm_key_vault_secret" "ingress_ip_01" {
  name         = azurerm_public_ip.ingress_ip_01.name
  value        = azurerm_public_ip.ingress_ip_01.ip_address
  key_vault_id = azurerm_key_vault.aks_kv_01.id

  tags = {
    Environment = "Development"
  }
}
