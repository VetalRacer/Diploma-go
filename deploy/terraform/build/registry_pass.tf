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
  key_vault_id = "/subscriptions/${var.arm_subscription_id}/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomanhlvault"
}

output "registrypass" {
  value = data.azurerm_key_vault_secret.registrypass.value
  sensitive = true
}

variable "arm_subscription_id" {}