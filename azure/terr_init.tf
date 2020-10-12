provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "~> 2.30.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-tfstate"
    storage_account_name = "terrstatedev"
    container_name       = "terraformdev"
    key                  = "azure_k8s.tfstate"
  }
}
# Access the environment azure key-vault
data "azurerm_key_vault" "vault_01" {
  name                = "terraform-keyvault01"
  resource_group_name = "azure-key-vault"
}
