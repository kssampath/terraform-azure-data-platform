module "application-rg" {
  source             = "./modules/Resourcegroup"
  resource-group     = var.resource-group
  location           = var.location
  environment        = var.environment
  AppId              = var.AppId
  DataClassification = var.DataClassification
  Role               = var.Role
  SupportGroup       = var.SupportGroup
}

module "application-vnet" {
  source                  = "./modules/Azurevnet"
  depends_on              = [module.application-rg]
  vnet_name               = var.vnet_name
  rgvnet                  = var.rgvnet
  location                = var.location
  address_space_vnet1     = var.address_space_vnet1
  subnets                 = var.subnets
  network_security_groups = var.network_security_groups
  subnet_nsg_associations = var.subnet_nsg_associations
  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}
module "application-datafactory" {
  source                   = "./modules/Datafactory"
  depends_on               = [module.application-rg, module.application-vnet]
  datafactory_name         = var.datafactory_name
  rgdfac                   = var.rgdfac
  location                 = var.location
  datafactory_endpointname = var.datafactory_endpointname

  # Loose coupling: the PEP subnet ID comes from the VNet module's output,
  # not a hardcoded path. If the VNet changes, this keeps working.
  dfacsubnet_id = module.application-vnet.subnet_ids["pep"]

  environment        = var.environment
  AppId              = var.AppId
  DataClassification = var.DataClassification
  Role               = var.Role
  SupportGroup       = var.SupportGroup
}

module "application-ctrm" {
  source     = "./modules/VirtualMachine"
  depends_on = [module.application-rg, module.application-vnet]

  # Loose coupling: VM NICs go in the app subnet, from the VNet output
  vmnicsub_id = module.application-vnet.subnet_ids["app"]

  virtual_machines              = var.virtual_machines
  location                      = var.location
  rgvm                          = var.rgvm
  vm_size                       = var.vm_size
  private_ip_address_allocation = var.private_ip_address_allocation

  publisher = var.publisher
  offer     = var.offer
  sku       = var.sku
  version1  = var.version1

  caching              = var.caching
  managed_disk_type    = var.managed_disk_type
  storage_account_type = var.storage_account_type

  # Key Vault secret lookup for the VM admin password
  keyvault_name        = var.key_vault_name
  keyvault_rg          = var.rgkv
  vm_admin_secret_name = var.vm_admin_secret_name

  AppId              = var.AppId
  DataClassification = var.DataClassification
  Role               = var.Role
  SupportGroup       = var.SupportGroup
  environment        = var.environment
}

module "application-Appservice" {
  source     = "./modules/Azureappservice"
  depends_on = [module.application-rg, module.application-vnet]

  appServPlanName      = var.appServPlanName
  app_service_sku_name = var.app_service_sku_name
  app_services         = var.app_services
  node_version         = var.node_version
  ftps_state           = var.ftps_state
  http2_enabled        = var.http2_enabled

  rgappser                   = var.rgappser
  appser_sql_server_name     = var.appser_sql_server_name
  administrator_login_appser = var.administrator_login_appser
  sql_server_version_appser  = var.sql_server_version_appser
  sql_sku_appser             = var.sql_sku_appser
  appsersqldb_name           = var.appsersqldb_name
  appser_sqldb1              = var.appser_sqldb1
  sql_redundancy_appser      = var.sql_redundancy_appser

  # Loose coupling: SQL private endpoint subnet from the VNet output
  appsersubnet_id = module.application-vnet.subnet_ids["pep"]
  appser_endpoint = var.appser_endpoint

  # SQL admin password from Key Vault (reuses the existing KV vars)
  keyvault_name         = var.key_vault_name
  keyvault_rg           = var.rgkv
  sql_admin_secret_name = var.sql_admin_secret_name

  location           = var.location
  environment        = var.environment
  AppId              = var.AppId
  DataClassification = var.DataClassification
  Role               = var.Role
  SupportGroup       = var.SupportGroup
}
module "application-appinsights" {
  source                       = "./modules/AppInsights"
  depends_on                   = [module.application-rg]
  loganalytics_workspace_appin = var.loganalytics_workspace_appin
  rgappin                      = var.rgappin
  location                     = var.location
  appinsights_name             = var.appinsights_name
  sku_appin                    = var.sku_appin
  application_type             = var.application_type
  AppId                        = var.AppId
  DataClassification           = var.DataClassification
  Role                         = var.Role
  SupportGroup                 = var.SupportGroup
  environment                  = var.environment
}

module "application-storage" {
  source           = "./modules/StorageAccount"
  depends_on       = [module.application-rg, module.application-vnet]
  storage-name     = var.storage-name
  storage_rg       = var.storage_rg
  location         = var.location
  account-tier     = var.account-tier
  replication-type = var.replication-type
  storage-kind     = var.storage-kind
  storage-tls      = var.storage-tls

  # Loose coupling: PEP subnet from the VNet output
  storsubnet_id     = module.application-vnet.subnet_ids["pep"]
  private_endpoints = var.storage_private_endpoints

  AppId              = var.AppId
  DataClassification = var.DataClassification
  Role               = var.Role
  SupportGroup       = var.SupportGroup
  environment        = var.environment
}

module "databricks-workspace" {
  source                      = "./modules/azure-databricks-workspace"
  depends_on                  = [module.application-rg, module.application-vnet]
  databricksworkspace_name    = var.databricksworkspace_name
  rgdbr                       = var.rgdbr
  location                    = var.location
  sku_premium                 = var.sku_premium
  managed_resource_group_name = var.managed_resource_group_name

  dbrlogworkspace_name = var.dbrlogworkspace_name
  dbrsku               = var.dbrsku

  # VNet injection — consume the VNet module outputs (loose coupling)
  vnet_id = module.application-vnet.vnet_id
  # This two-subnet model is required for Databricks VNet injection — it's not optional
  public_subnet_name_dbr            = module.application-vnet.subnet_names["databricks_public"]
  private_subnet_name_dbr           = module.application-vnet.subnet_names["databricks_private"]
  public_subnet_nsg_association_id  = module.application-vnet.nsg_association_ids["databricks_public"]
  private_subnet_nsg_association_id = module.application-vnet.nsg_association_ids["databricks_private"]
  # module.application-vnet.nsg_association_ids["databricks_public"] pulls the association ID straight from the VNet output
  # Databricks requires the NSG association to exist before it injects, and referencing the output creates that dependency automatically — Terraform will build the subnet, NSG, and association first, then the workspace.
  AppId              = var.AppId
  environment        = var.environment
  DataClassification = var.DataClassification
  Role               = var.Role
  SupportGroup       = var.SupportGroup
}
module "application-Keyvault" {
  source                   = "./modules/Keyvault"
  depends_on               = [module.application-rg, module.application-vnet]
  key_vault_name           = var.key_vault_name
  location                 = var.location
  rgkv                     = var.rgkv
  key_vault_end_point_name = var.key_vault_end_point_name
  kvsubnet_id              = module.application-vnet.subnet_ids["pep"]
  purge_protection_enabled = var.purge_protection_enabled
  environment              = var.environment
  AppId                    = var.AppId
  DataClassification       = var.DataClassification
  Role                     = var.Role
  SupportGroup             = var.SupportGroup
}

module "application-AzureSynapseAnalytics" {
  source     = "./modules/AzureSynapseAnalytics"
  depends_on = [module.application-rg, module.application-vnet]

  sqlserver_name             = var.sqlserver_name
  versionsyn                 = var.versionsyn
  administrator_login_synsql = var.administrator_login_synsql
  sqldw_name                 = var.sqldw_name
  sqldw_sku                  = var.sqldw_sku
  sqlser_endpoint            = var.sqlser_endpoint

  # Loose coupling: SQL private endpoint subnet from the VNet output
  synsubnet_id = module.application-vnet.subnet_ids["pep"]

  # SQL admin password from Key Vault (reuses existing KV vars)
  keyvault_name             = var.key_vault_name
  keyvault_rg               = var.rgkv
  syn_sql_admin_secret_name = var.syn_sql_admin_secret_name

  location           = var.location
  rgsyn              = var.rgsyn
  environment        = var.environment
  AppId              = var.AppId
  DataClassification = var.DataClassification
  Role               = var.Role
  SupportGroup       = var.SupportGroup
}