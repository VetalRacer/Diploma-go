

data "azurerm_key_vault_secret" "registrypass" {
  name         = "registrypass"
  key_vault_id = "/subscriptions/29ce556b-5437-4c4b-97d1-4b2730cda3ef/resourceGroups/Diploma-rg/providers/Microsoft.KeyVault/vaults/diplomanhlvault"
}

output "registrypass" {
  #value = nonsensitive(data.azurerm_key_vault_secret.registrypass.value)
  value = data.azurerm_key_vault_secret.registrypass.value
  sensitive = true
}