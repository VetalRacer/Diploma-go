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
    client_id     = "${var.arm_client_id}"
    client_secret = "${var.arm_client_secret}"
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Diploma"
  }

  #provisioner "local-exec" {
  #  command="az aks get-credentials -g ${azurerm_resource_group.default.name} -n Diploma-aks --overwrite-existing"
  #}
}