output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.storage-account.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.storage-account.name
}

output "private_endpoint_ids" {
  description = "Map of sub-resource type to private endpoint ID"
  value       = { for k, pe in azurerm_private_endpoint.storage : k => pe.id }
}