terraform { 
  required_providers { 
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" 
    } 
  } 
}
# Create a resource group
resource "azurerm_resource_group" "resource-group" {
  # for_each over a set keeps each RG keyed by its unique name, so adding or
  # removing one from the list never reindexes or recreates the others.
  for_each = toset(var.resource-group)

  # each.value is the current RG name from the set (each.key == each.value for a set)
  name     = each.value
  location = var.location

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}