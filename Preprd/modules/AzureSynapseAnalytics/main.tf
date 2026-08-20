
terraform { 
  required_providers { 
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" 
    } 
  } 
}# SQL server hosting the Synapse SQL data warehouse (modern azurerm_mssql_server).
# Admin password read from Key Vault at runtime — never stored in code/tfvars.
resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sqlserver_name
  resource_group_name          = var.rgsyn
  location                     = var.location
  version                      = var.versionsyn
  administrator_login          = var.administrator_login_synsql
  administrator_login_password = data.azurerm_key_vault_secret.syn_sql_admin_password.value

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}

# Synapse SQL data warehouse (modern azurerm_mssql_database).
# The DW* sku_name signals a data warehouse — the old edition="DataWarehouse" +
# requested_service_objective_name is now a single sku_name.
resource "azurerm_mssql_database" "sql_dw" {
  name      = var.sqldw_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = var.sqldw_sku

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}

# Private endpoint for the SQL server, subnet from the VNet output (loose coupling).
resource "azurerm_private_endpoint" "endpointsqlser1" {
  name                = var.sqlser_endpoint
  location            = var.location
  resource_group_name = var.rgsyn
  subnet_id           = var.synsubnet_id

  private_service_connection {
    name                           = azurerm_mssql_server.sql_server.name
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}