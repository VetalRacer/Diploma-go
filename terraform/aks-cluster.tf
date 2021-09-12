resource "azurerm_resource_group" "default" {
  name     = "Diploma-rg"
  location = "westeurope"

  tags = {
    environment = "Diploma"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "Diploma-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "Diploma-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.arm_client_id
    client_secret = var.arm_client_secret
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Diploma"
  }  
}

resource "kubernetes_namespace" "prod-env" {
  metadata {
    annotations = {
      name = "prod-env"
    }

    name = "production"
  }
}

resource "kubernetes_namespace" "dev-env" {
  metadata {
    annotations = {
      name = "dev-env"
    }

    name = "develop"
  }
}

resource "kubernetes_namespace" "logging-env" {
  metadata {
    annotations = {
      name = "logging-env"
    }

    name = "logging"
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations = {
      name = "dev-monitoring"
    }

    name = "monitoring"
  }
}

resource "kubernetes_namespace" "qgate-env" {
  metadata {
    annotations = {
      name = "qgate-env"
    }

    name = "qgate"
  }
}


resource "kubernetes_secret" "dev-env" {
  metadata {
    name = "artifactory"
    namespace = "develop"
  }

  data = {
    ".dockerconfigjson" = <<DOCKER
{
  "auths": {
    "${var.registry_server}": {
      "auth": "${base64encode("${var.registry_username}:${var.registry_password}")}"
    }
  }
}
DOCKER
  }

  type = "kubernetes.io/dockerconfigjson"
}


resource "azurerm_key_vault_secret" "default" {
  name         = "hostk8s"
  value        = azurerm_kubernetes_cluster.default.kube_config.0.host
  key_vault_id = "/subscriptions/8fcd86ec-9ad9-4c85-a8e0-b5410c6e01ac/resourceGroups/tf-storage-rg/providers/Microsoft.KeyVault/vaults/diplomakeyvault"
  #key_vault_id = azurerm_kubernetes_cluster.default.kube_config.0.host
}