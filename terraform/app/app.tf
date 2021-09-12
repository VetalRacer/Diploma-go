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
    host                   = azurerm_kubernetes_cluster.default.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}

resource "helm_release" "app" {
  name       = "app"
  chart      = "../../deploy/helm-charts/app/nhl"
  values     = [templatefile("../../deploy/helm-charts/app/nhl/values.dev.yaml", {})]
  namespace  = "develop"
  force_update = "true"
  atomic = "true"

}


data "azurerm_key_vault_secret" "hostk8s" {
  name         = "hostk8s"
  key_vault_id = "/subscriptions/8fcd86ec-9ad9-4c85-a8e0-b5410c6e01ac/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomavault"
}

data "azurerm_key_vault_secret" "clientcert" {
  name         = "clientcert"
  key_vault_id = "/subscriptions/8fcd86ec-9ad9-4c85-a8e0-b5410c6e01ac/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomavault"
}

data "azurerm_key_vault_secret" "clientkey" {
  name         = "clientkey"
  key_vault_id = "/subscriptions/8fcd86ec-9ad9-4c85-a8e0-b5410c6e01ac/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomavault"
}

data "azurerm_key_vault_secret" "clientcacert" {
  name         = "clientcacert"
  key_vault_id = "/subscriptions/8fcd86ec-9ad9-4c85-a8e0-b5410c6e01ac/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomavault"
}