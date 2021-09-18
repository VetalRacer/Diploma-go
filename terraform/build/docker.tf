terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.66.0"
    }
  }

  required_version = ">= 0.14"

  backend "azurerm" {
  }

}

provider "azurerm" {
  features {}
}

data "azurerm_key_vault_secret" "registrypass" {
  name         = "registrypass"
  key_vault_id = "/subscriptions/29ce556b-5437-4c4b-97d1-4b2730cda3ef/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomanhlvault"
}

output "example1" {
  value = nonsensitive(data.azurerm_key_vault_secret.registrypass.value)
  #sensitive = true
}