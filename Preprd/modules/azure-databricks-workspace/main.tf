terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0"
    }
  }
}
# Log Analytics workspace for Databricks diagnostics.
resource "azurerm_log_analytics_workspace" "databricks-loganalytics" {
  name                = var.dbrlogworkspace_name
  location            = var.location
  resource_group_name = var.rgdbr
  sku                 = var.dbrsku
  retention_in_days   = 30
}

# Databricks workspace with VNet injection (custom_parameters).

#no_public_ip = false means this is a "public" (standard secure cluster connectivity) injection;

resource "azurerm_databricks_workspace" "module-databricks" {
  name                = var.databricksworkspace_name
  resource_group_name = var.rgdbr
  location            = var.location
  sku                 = var.sku_premium

  managed_resource_group_name = var.managed_resource_group_name

  custom_parameters {
    no_public_ip                                         = false
    virtual_network_id                                   = var.vnet_id
    public_subnet_name                                   = var.public_subnet_name_dbr
    private_subnet_name                                  = var.private_subnet_name_dbr
    public_subnet_network_security_group_association_id  = var.public_subnet_nsg_association_id
    private_subnet_network_security_group_association_id = var.private_subnet_nsg_association_id
  }

  tags = {
    application            = "databricks"
    AppId                  = var.AppId
    databricks-environment = true
    environment            = var.environment
    DataClassification     = var.DataClassification
    Role                   = var.Role
    SupportGroup           = var.SupportGroup
  }
}