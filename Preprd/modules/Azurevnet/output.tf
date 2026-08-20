output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.virtual-network.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.virtual-network.name
}

# Map of subnet name -> subnet ID, so other modules can look up the subnet
# they need (e.g. the PEP subnet for private endpoints) by key.
output "subnet_ids" {
  description = "Map of logical subnet name to subnet ID"
  value       = { for k, s in azurerm_subnet.subnets : k => s.id }
}