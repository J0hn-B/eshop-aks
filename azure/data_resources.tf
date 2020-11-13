# Service principal credentials received from a vault. Replace accordingly

# Access the resource azure key-vault
data "azurerm_key_vault" "vault_01" {
  name                = "terraform-keyvault01"
  resource_group_name = "azure-key-vault"
}

# Azure key-vault aks-rotation-key-vault
data "azurerm_key_vault_secret" "terr_sp_tenant_id" {
  name         = "tenant"
  key_vault_id = data.azurerm_key_vault.vault_01.id
}

data "azurerm_key_vault_secret" "terr_sp_object_id" {
  name         = "object-id"
  key_vault_id = data.azurerm_key_vault.vault_01.id
}

# Get terraform service principal client id (aks)
data "azurerm_key_vault_secret" "terr_sp_client_id" {
  name         = "appId"
  key_vault_id = data.azurerm_key_vault.vault_01.id
}

# Get terraform service principal secret
data "azurerm_key_vault_secret" "terr_sp_client_secret" {
  name         = "password"
  key_vault_id = data.azurerm_key_vault.vault_01.id
}
