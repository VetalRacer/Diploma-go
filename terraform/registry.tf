resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  sku                 = "Standart"
  admin_enabled       = false
}