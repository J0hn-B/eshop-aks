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
