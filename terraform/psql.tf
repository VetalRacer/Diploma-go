resource "azurerm_resource_group" "example" {
  name     = "Diploma-rg"
  location = "westeurope"
}

resource "azurerm_postgresql_server" "default" {
  name                = "diploma-psqlserver"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  administrator_login          = "psqladminun"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = 5120

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_database" "default" {
  name                = "exampledb"
  resource_group_name = azurerm_resource_group.default.name
  server_name         = azurerm_postgresql_server.default.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}