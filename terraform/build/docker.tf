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

resource "null_resource" "cluster" {
  provisioner "local-exec" {
    #command = "export PASSSSS = data.azurerm_key_vault_secret.registrypass.value"
    #command = "echo data.azurerm_key_vault_secret.registrypass.value >> private_ips.txt"
    command = "/bin/bash touch test.txt"
  }

    provisioner "file" {
    source      = "configs.d"
    destination = "."
  }
}

output "example1" {
  value = "hello"
}