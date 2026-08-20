 module "application-rg" {
   source = "./modules/Resourcegroup"
   resource-group = var.resource-group
   location = var.location
   environment              = var.environment
   AppId                    = var.AppId
   DataClassification       = var.DataClassification
   Role                     = var.Role
   SupportGroup             = var.SupportGroup
 }

module "application-vnet" {
  source              = "./modules/Azurevnet"
  depends_on          = [module.application-rg]
  vnet_name           = var.vnet_name
  rgvnet              = var.rgvnet
  location            = var.location
  address_space_vnet1 = var.address_space_vnet1
  subnets             = var.subnets
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
  depends_on = [module.application-rg]
  // depends_on = [module.application-vnet]
  rgdbr        = var.rgdbr
  databricks_managed_resource_group_name =  var.databricks_managed_resource_group_name
  location                    = var.location
  // dbrsku = var.dbrsku
  // vnet_name = var.vnet_name
  // rgvnet    = var.rgvnet
  // vnet_id = var.vnet_id
  // security_group_name_public_dbr  = var.security_group_name_public_dbr
  // security_group_name_private_dbr = var.security_group_name_private_dbr
  // private_subnet_name_dbr         = var.private_subnet_name_dbr
  // public_subnet_name_dbr          = var.public_subnet_name_dbr
  // dbrlogworkspace-name              = var.dbrlogworkspace-name
  databricksworkspace_name  = var.databricksworkspace_name
  sku_premium  = var.sku_premium
  // public_address_prefix_dbr = var.public_address_prefix_dbr  #"10.40.52.0/26"
  // private_address_prefix_dbr  = var.private_address_prefix_dbr  #"10.40.52.64/26"
  AppId                    = var.AppId
  DataClassification       = var.DataClassification
  Role                     = var.Role
  SupportGroup             = var.SupportGroup
  environment              = var.environment
}

module "application-Keyvault" {
  source                   = "./modules/Keyvault"
  depends_on               = [module.application-rg]
  key_vault_name           = var.key_vault_name
  location                 = var.location
  rgkv                     = var.rgkv
  purge_protection_enabled = var.purge_protection_enabled
  environment              = var.environment
  AppId                    = var.AppId
  DataClassification       = var.DataClassification
  Role                     = var.Role
  SupportGroup             = var.SupportGroup
}
#  module "application-AzureSynapseAnalytics" {
#   source                   = "./modules/AzureSynapseAnalytics"
#   depends_on = [module.application-rg]
#   // depends_on = [module.application-vnet]
#   location = var.location
#   versionsyn = var.versionsyn #"12.0"
#   editionsyn = var.editionsyn
#   sqlserver_name = var.sqlserver_name 
#   requested_service_objective_name = var.requested_service_objective_name
#   sqldw_name = var.sqldw_name
#   rgsyn = var.rgsyn
#   sqlser_endpoint = var.sqlser_endpoint
#   synsubnet_id = var.synsubnet_id
#   administrator_login_synsql = var.administrator_login_synsql #"etarrowo"
#   administrator_login_password_synsql = var.administrator_login_password_synsql #"ab1@cdef"
#   environment              = var.environment
#   AppId                    = var.AppId
#   DataClassification       = var.DataClassification
#   Role                     = var.Role
#   SupportGroup             = var.SupportGroup
#   }
