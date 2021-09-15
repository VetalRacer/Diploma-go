resource "azurerm_postgresql_server" "default" {
  name                = "diploma-psqlserver"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  administrator_login          = "psqladmin"
  administrator_login_password = ${var.db_pass}

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = 5120

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_database" "default" {
  name                = "nhl"
  resource_group_name = azurerm_resource_group.default.name
  server_name         = azurerm_postgresql_server.default.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "default" {
  name                = "k8s"
  resource_group_name = azurerm_resource_group.default.name
  server_name         = azurerm_postgresql_server.default.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}