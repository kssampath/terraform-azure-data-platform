
terraform { 
  required_providers { 
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" 
    } 
  } 
}
# App Service Plan — modern azurerm_service_plan (replaces azurerm_app_service_plan).
# The old sku{} block + kind + reserved are now flat os_type + sku_name.
resource "azurerm_service_plan" "serviceplan" {
  name                = var.appServPlanName
  location            = var.location
  resource_group_name = var.rgappser
  os_type             = "Linux"
  sku_name            = var.app_service_sku_name

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}

# Two Linux web apps via for_each (replaces two azurerm_app_service blocks).
# Runtime is set via application_stack inside site_config (was linux_fx_version etc.).
resource "azurerm_linux_web_app" "appservice" {
  for_each = var.app_services

  name                = each.value
  location            = var.location
  resource_group_name = var.rgappser
  service_plan_id     = azurerm_service_plan.serviceplan.id
  client_certificate_enabled = false
  https_only          = true

  site_config {
    ftps_state    = var.ftps_state
    http2_enabled = var.http2_enabled
    always_on     = true

    application_stack {
      node_version = var.node_version
    }
  }

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}

# SQL Server — modern azurerm_mssql_server (replaces azurerm_sql_server).
# Password now read from Key Vault at runtime, not hardcoded.
resource "azurerm_mssql_server" "sql_server1" {
  name                         = var.appser_sql_server_name
  resource_group_name          = var.rgappser
  location                     = var.location
  version                      = var.sql_server_version_appser
  administrator_login          = var.administrator_login_appser
  administrator_login_password = data.azurerm_key_vault_secret.sql_admin_password.value

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}

# Two SQL databases — modern azurerm_mssql_database (replaces azurerm_sql_database).
# server_name + requested_service_objective_name are now server_id + sku_name.
resource "azurerm_mssql_database" "sql_database" {
  name         = var.appsersqldb_name
  server_id    = azurerm_mssql_server.sql_server1.id
  sku_name     = var.sql_sku_appser
  zone_redundant = var.sql_redundancy_appser

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}

resource "azurerm_mssql_database" "sql_database1" {
  name      = var.appser_sqldb1
  server_id = azurerm_mssql_server.sql_server1.id
  sku_name  = var.sql_sku_appser

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
  name                = var.appser_endpoint
  location            = var.location
  resource_group_name = var.rgappser
  subnet_id           = var.appsersubnet_id

  private_service_connection {
    name                           = azurerm_mssql_server.sql_server1.name
    private_connection_resource_id = azurerm_mssql_server.sql_server1.id
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