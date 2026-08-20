terraform { 
  required_providers { 
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" 
    } 
  } 
}

# Create the virtual network
resource "azurerm_virtual_network" "virtual-network" {
  name                = var.vnet_name
  address_space       = var.address_space_vnet1
  location            = var.location
  resource_group_name = var.rgvnet
}

# Create all subnets by iterating over a map of subnet definitions.
# each.key is the subnet's logical name; each.value is its settings object.
# Adding a subnet = adding one map entry, with no risk of copy-paste errors.
resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = var.rgvnet
  virtual_network_name = azurerm_virtual_network.virtual-network.name

  # 4.x: address_prefixes is a LIST (was singular address_prefix in 2.x)
  address_prefixes = each.value.address_prefixes

  # 4.x: string enum (was the removed bool enforce_private_link_endpoint_network_policies).
  # "Disabled" lets private endpoints attach; "Enabled" keeps standard network policies.
  private_endpoint_network_policies = each.value.private_endpoint_network_policies
}

