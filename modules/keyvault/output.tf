output "id" {
  value       = azurerm_key_vault.kv_for_app.id
  description = "The ID of the Key Vault."
}

output "name" {
  value       = azurerm_key_vault.kv_for_app.name
  description = "The name of the Key Vault."
}