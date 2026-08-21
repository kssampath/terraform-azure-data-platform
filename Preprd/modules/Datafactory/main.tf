resource "azurerm_data_factory" "terraform-demo-factory" {
  name                = var.datafactory_name
  location            = var.location
  resource_group_name = var.rgdfac

  # System-assigned managed identity lets the Data Factory authenticate to other
  # Azure services (Key Vault, Storage) without stored credentials. Azure generates
  # the principal/tenant IDs — never hardcode them.
  identity {
    type = "SystemAssigned"
  }

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}

# Private endpoint giving the Data Factory a private IP inside the PEP subnet.
# subnet_id is passed in from the VNet module's output (loose coupling) rather
# than a hardcoded subnet path.
resource "azurerm_private_endpoint" "datafactory-pep" {
  name                = var.datafactory_endpointname
  location            = var.location
  resource_group_name = var.rgdfac
  subnet_id           = var.dfacsubnet_id

  private_service_connection {
    name                           = azurerm_data_factory.terraform-demo-factory.name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_data_factory.terraform-demo-factory.id
    subresource_names              = ["dataFactory"]
  }

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}