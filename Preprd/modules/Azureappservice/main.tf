
terraform { 
  required_providers { 
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" 
    } 
  } 
}
// Create the app service plan
resource "azurerm_app_service_plan" "serviceplan" {
  name                = var.appServPlanName #"appsvc-ads-eus2-edhpreprd-dev-001"
  location            = var.location
  resource_group_name = var.rgappser
  kind                = var.kind #"linux"
  reserved            = true

  sku {
    tier              = var.appServPlanSKU #"PremiumV3"
    size              = var.appServPlanTier #"P1v3"
  }
    tags              = {
    AppId = var.AppId 
    environment = var.environment
    DataClassification = var.DataClassification
    Role = var.Role
    SupportGroup = var.SupportGroup 
  }

}

#create azure App service 1 
resource "azurerm_app_service" "appservice1" {

  name                = var.appServiceName1
  location            = var.location
  resource_group_name =var.rgappser
  #"rg-ads-eus2-pioneer-inn-armtotf"
  app_service_plan_id = azurerm_app_service_plan.serviceplan.id
  client_cert_enabled = false
  https_only          = true
  tags                = {
    AppId = var.AppId 
    environment = var.environment
    DataClassification = var.DataClassification
    Role = var.Role
    SupportGroup = var.SupportGroup 
  }

  auth_settings {
    enabled = false
  }


  site_config {
    linux_fx_version         = var.linux_fx_version #"NODE|12-lts"
    ftps_state               = var.ftps_state #"Disabled"
    http2_enabled            = var.http2_enabled #false
    php_version              = var.php_version #"7.4"          
    python_version           = var.python_version #"3.4"          
    dotnet_framework_version = var.dotnet_framework_version #"v4.0"
    always_on                = true 
  }
}
#create azure App service 1 
resource "azurerm_app_service" "appservice2" {

  name                = var.appServiceName2
  #"appsvc-ads-eus2-edhpreprd-dev-001"
  location            = var.location
  resource_group_name =var.rgappser
  #"rg-ads-eus2-pioneer-inn-armtotf"
  app_service_plan_id = azurerm_app_service_plan.serviceplan.id
  client_cert_enabled = false
  https_only          = true
  tags                = {
    AppId = var.AppId 
    environment = var.environment
    DataClassification = var.DataClassification
    Role = var.Role
    SupportGroup = var.SupportGroup 
  }

  auth_settings {
    enabled = false
  }


  site_config {
    linux_fx_version         = var.linux_fx_version #"NODE|12-lts"
    ftps_state               = var.ftps_state #"Disabled"
    http2_enabled            = var.http2_enabled #false
    php_version              = var.php_version #"7.4"          
    python_version           = var.python_version #"3.4"          
    dotnet_framework_version = var.dotnet_framework_version #"v4.0"
    always_on                = true 
  }
}
#create SQL Server 1
resource "azurerm_sql_server" "sql_server1" {
  name                         = var.appser_sql_server_name
  resource_group_name          = var.rgappser

  location                     = var.location
  version                      = var.sql_server_version_appser
  administrator_login          = var.administrator_login_appser
  administrator_login_password = "Abc12486e3@"
  tags =  {
    AppId = var.AppId 
    environment = var.environment
    DataClassification = var.DataClassification
    Role = var.Role
    SupportGroup = var.SupportGroup 
  }
}

#create Azure Sql database1 attached with SQL server 1
resource "azurerm_sql_database" "sql_database" {
  name                             = var.appsersqldb_name #"sdb-ads-eus2-edhpreprd-dev-002"
  #var.sql_db_name
  resource_group_name              = var.rgappser
  location                         = var.location
  server_name                      = azurerm_sql_server.sql_server1.name

  #collation                        = var.sql_Collation #"SQL_Latin1_General_CP1_CI_AS"
  requested_service_objective_name = var.sql_storage_appser #"P1"
  #var.sql_storage
  zone_redundant                   = var.sql_redundancy_appser #true
  #var.sql_redundancy
  tags                             =  {
    AppId = var.AppId 
    environment = var.environment
    DataClassification = var.DataClassification
    Role = var.Role
    SupportGroup = var.SupportGroup 
  }
}

#create SQL database 1
resource "azurerm_sql_database" "Sqldatabase1" {
  name                             = var.appser_sqldb1 #"sdb-ads-eus2-edhpreprd-dev-002"
  resource_group_name              = var.rgappser
  location                         = var.location
  server_name                      = azurerm_sql_server.sql_server1.name

  tags = {
    AppId = var.AppId 
    environment = var.environment
    DataClassification = var.DataClassification
    Role = var.Role
    SupportGroup = var.SupportGroup 
  }
}

#create private_end_point1 attach private connection with SQL Server1
resource "azurerm_private_endpoint" "endpointsqlser1" {
  name                = var.appser_endpoint # "pep-acs26X0011"
  location            = var.location
  resource_group_name = var.rgappser
  subnet_id           = var.appsersubnet_id #"/subscriptions/eecd271c-6ad0-435b-9ff3-495957463af0/resourceGroups/rg-ads-eus2-pioneer-inn-armtotf/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"

  private_service_connection {
    name                           = azurerm_sql_server.sql_server1.name
    private_connection_resource_id = azurerm_sql_server.sql_server1.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
    }
  tags = {
    AppId = var.AppId 
    environment = var.environment
    DataClassification = var.DataClassification
    Role = var.Role
    SupportGroup = var.SupportGroup 
  }
}
