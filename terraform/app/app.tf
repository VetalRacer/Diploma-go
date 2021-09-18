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

provider "helm" {
  kubernetes {
    host                   = data.azurerm_key_vault_secret.hostk8s.value
    client_certificate     = base64decode(data.azurerm_key_vault_secret.clientcert.value)
    client_key             = base64decode(data.azurerm_key_vault_secret.clientkey.value)
    cluster_ca_certificate = base64decode(data.azurerm_key_vault_secret.clientcacert.value)
  }
}

resource "helm_release" "app" {
  name       = "app"
  chart      = "../../deploy/helm-charts/app/nhl"
  values     = [templatefile("../../deploy/helm-charts/app/nhl/values.dev.yaml", {})]
  namespace  = "develop"
  reuse_values = "true"
  force_update = "true"
  atomic = "true"

  set {
    name  = "db_pass"
    value = "${base64encode("${var.db_pass}")}"
  }

  set {
    name  = "tag"
    value = var.tag
  }


}


data "azurerm_key_vault_secret" "hostk8s" {
  name         = "hostk8s"
  key_vault_id = "/subscriptions/29ce556b-5437-4c4b-97d1-4b2730cda3ef/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomanhlvault"
}

data "azurerm_key_vault_secret" "clientcert" {
  name         = "clientcert"
  key_vault_id = "/subscriptions/29ce556b-5437-4c4b-97d1-4b2730cda3ef/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomanhlvault"
}

data "azurerm_key_vault_secret" "clientkey" {
  name         = "clientkey"
  key_vault_id = "/subscriptions/29ce556b-5437-4c4b-97d1-4b2730cda3ef/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomanhlvault"
}

data "azurerm_key_vault_secret" "clientcacert" {
  name         = "clientcacert"
  key_vault_id = "/subscriptions/29ce556b-5437-4c4b-97d1-4b2730cda3ef/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomanhlvault"
}


variable "db_pass" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  type        = string
}

variable "tag" {}