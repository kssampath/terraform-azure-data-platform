output "key_vault_id" {
  description = "ID of the Key Vault, consumed by other modules (e.g. for private endpoints or secret data sources)"
  value       = azurerm_key_vault.key_vault.id
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.key_vault.vault_uri
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.key_vault.name
}