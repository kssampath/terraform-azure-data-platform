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

  name                              = each.value.name
  resource_group_name               = var.rgvnet
  virtual_network_name              = azurerm_virtual_network.virtual-network.name
  address_prefixes                  = each.value.address_prefixes
  private_endpoint_network_policies = each.value.private_endpoint_network_policies

  # 4.x: string enum (was the removed bool enforce_private_link_endpoint_network_policies).
  # "Disabled" lets private endpoints attach; "Enabled" keeps standard network policies.
  # Dynamic delegation block — only rendered when the subnet defines a delegation.
  # Databricks subnets carry a delegation; pep/app leave it null so no block appears.
  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_name
        actions = delegation.value.actions
      }
    }
  }
}

# NSGs for Databricks subnets.
resource "azurerm_network_security_group" "nsg" {
  for_each = var.network_security_groups

  name                = each.value
  location            = var.location
  resource_group_name = var.rgvnet
  tags                = var.tags
}

# Associate NSGs with their subnets.
resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each = var.subnet_nsg_associations

  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value].id
}

