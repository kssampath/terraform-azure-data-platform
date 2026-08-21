output "vnet_id" {
  value       = azurerm_virtual_network.virtual-network.id
  description = "ID of the virtual network"
}

output "vnet_name" {
  value       = azurerm_virtual_network.virtual-network.name
  description = "Name of the virtual network"
}


# Map of subnet name -> subnet ID, so other modules can look up the subnet
# they need (e.g. the PEP subnet for private endpoints) by key.
output "subnet_ids" {
  description = "Map of logical subnet name to subnet ID"
  value       = { for k, s in azurerm_subnet.subnets : k => s.id }
}
# That { for k, s in ... : k => s.id } is a for expression (different from for_each) — it transforms the resource instances into an output map
# when the Key Vault module needs the PEP subnet for its private endpoint, the root will pass module.vnet.subnet_ids["pep"] — the Key Vault module never needs to know how the VNet is structured internally.


# Databricks custom_parameters needs the association IDs, not just subnet IDs.
output "nsg_association_ids" {
  value       = { for k, a in azurerm_subnet_network_security_group_association.assoc : k => a.id }
  description = "Map of subnet key to its NSG association ID"
}

# Unlike every other resource that references subnets by ID (subnet_id = ...), the Databricks custom_parameters block wants the subnet name as a plain string (public_subnet_name, private_subnet_name), plus the virtual_network_id separately.
# It's an odd API — it locates the subnet by "here's the VNet ID, and here's the name of the subnet within it." So Databricks genuinely needs a name string, where other modules need an ID.
output "subnet_names" {
  description = "Map of logical subnet key to actual subnet name"
  value       = { for k, s in azurerm_subnet.subnets : k => s.name }
}