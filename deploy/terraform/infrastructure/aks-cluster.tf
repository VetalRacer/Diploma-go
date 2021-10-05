resource "azurerm_resource_group" "default" {
  name     = "Diploma-rg"
  location = "westeurope"

  tags = {
    environment = "Diploma"
  }
}

resource "azurerm_public_ip" "default" {
  name                = "nginx-ingress-controller"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  allocation_method   = "Static"
  sku                 = "Standard"
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

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
    load_balancer_profile {
      outbound_ip_address_ids = [ azurerm_public_ip.default.id ]

    }
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
    "${var.registry_url}": {
      "auth": "${base64encode("${azurerm_container_registry.default.name}:${azurerm_container_registry.default.admin_password}")}"
    }
  }
}
DOCKER
  }

  type = "kubernetes.io/dockerconfigjson"
}