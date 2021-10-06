resource "azurerm_key_vault" "default" {
  name                       = "diplomanhlvault"
  location                   = azurerm_resource_group.default.location
  resource_group_name        = azurerm_resource_group.default.name
  tenant_id                  = data.azurerm_client_config.default.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.default.tenant_id
    object_id = data.azurerm_client_config.default.object_id

    key_permissions = [
      "create",
      "get",
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
      "purge",
      "recover"
    ]
  }

  tags = {
    environment = "Diploma"
  }
}

resource "azurerm_key_vault_secret" "hostk8s" {
  name         = "hostk8s"
  value        = azurerm_kubernetes_cluster.default.kube_config.0.host
  key_vault_id = azurerm_key_vault.default.id
}

resource "azurerm_key_vault_secret" "clientcert" {
  name         = "clientcert"
  value        = azurerm_kubernetes_cluster.default.kube_config.0.client_certificate
  key_vault_id = azurerm_key_vault.default.id
}

resource "azurerm_key_vault_secret" "clientkey" {
  name         = "clientkey"
  value        = azurerm_kubernetes_cluster.default.kube_config.0.client_key
  key_vault_id = azurerm_key_vault.default.id
}

resource "azurerm_key_vault_secret" "clientcacert" {
  name         = "clientcacert"
  value        = azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate
  key_vault_id = azurerm_key_vault.default.id
}

resource "azurerm_key_vault_secret" "registrypass" {
  name         = "registrypass"
  value        = azurerm_container_registry.default.admin_password
  key_vault_id = azurerm_key_vault.default.id
}
