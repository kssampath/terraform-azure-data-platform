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
#  module "application-ctrm" {
#   source                   = "./modules/VirtualMachine"
#   depends_on = [module.application-rg]
  // depends_on = [module.application-vnet]
  # vmnicsub_id = var.vmnicsub_id
  # vm1  = var.vm1
  # vm2  = var.vm2 
  // vmsb_add = var.vmsb_add
  // vnet = var.vnet_name
  // rgvnet = var.rgvnet
  # nicname1                 = var.nicname1
  # nicname2                 = var.nicname2
  # location                 = var.location
  # vmsubnetname             = var.vmsubnetname 
  # private_ip_address_allocation = var.private_ip_address_allocation
  # vm_size                  = var.vm_size
  # publisher = var.publisher #"RedHat"
  # offer     = var.offer #"RHEL"
  # sku       = var.sku #"7.8"  
  # version1   = var.version1
  # caching   = var.caching
  # create_option = var.create_option
  # managed_disk_type = var.managed_disk_type #"Premium_LRS"
#   os_type = var.os_type
#   os_disk1  = var.os_disk1
#   os_disk2  = var.os_disk2
#   computer_name1 = var.computer_name1 #"ACS29L018"
#   admin_username1 = var.admin_username1 # "ctrmadmin"
#   admin_password1 = var.admin_password1 #"Ab@c123"c
#   computer_name2 = var.computer_name2 #"ACS29L018"
#   admin_username2 = var.admin_username2 # "ctrmadmin"
#   admin_password2 = var.admin_password2 #"Ab@c123"c
#   managed_disk_type_name1 = var.managed_disk_type_name1
#   managed_disk_type_name2 = var.managed_disk_type_name2
#   storage_account_type = var.storage_account_type 
#   AppId                    = var.AppId
#   DataClassification       = var.DataClassification
#   Role                     = var.Role
#   SupportGroup             = var.SupportGroup
#   environment              = var.environment
#   rgvm                    = var.rgvm
#  }
  
  
#  module "application-Appservice" {
#   source                   = "./modules/Azureappservice"
#   depends_on = [module.application-rg]
  // depends_on = [module.application-vnet]
  # appServPlanName = var.appServPlanName
  # rgappser = var.rgappser
  # kind = var.kind 
  # appServPlanSKU = var.appServPlanSKU 
  # appServPlanTier = var.appServPlanTier
  # appServiceName1 = var.appServiceName1
  # appServiceName2 = var.appServiceName2
  # appser_sql_server_name = var.appser_sql_server_name
  # sql_server_version_appser = var.sql_server_version_appser
  # administrator_login_appser = var.administrator_login_appser
  # appsersqldb_name  = var.appsersqldb_name #"sdb-ads-eus2-edhpreprd-dev-002"
  # sql_storage_appser = var.sql_storage_appser #"P1"
  # sql_redundancy_appser =  var.sql_redundancy_appser #true
  # appser_sqldb1 = var.appser_sqldb1 #"sdb-ads-eus2-edhpreprd-dev-002"
  # appser_endpoint = var.appser_endpoint # "pep-acs26X0011"
  # appsersubnet_id = var.appsersubnet_id #"/subscriptions/eecd271c-6ad0-435b-9ff3-495957463af0/resourceGroups/rg-ads-eus2-pioneer-inn-armtotf/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"
#   linux_fx_version         = var.linux_fx_version #"NODE|12-lts"
#   ftps_state               = var.ftps_state #"Disabled"
#   http2_enabled            = var.http2_enabled #false
#   php_version              = var.php_version #"7.4"          
#   python_version           = var.python_version #"3.4"          
#   dotnet_framework_version = var.dotnet_framework_version #"v4.0"
#   location = var.location
#   environment = var.environment
#   AppId                    = var.AppId
#   DataClassification       = var.DataClassification
#   Role                     = var.Role
#   SupportGroup             = var.SupportGroup
#  }


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
