resource-group =     [ "rg-ads-eus2-edh-preprd-adf-005",
                        "rg-ads-eus2-edh-preprd-appin-005",
                        "rg-ads-eus2-edh-preprd-appsvc-005",
                        "rg-ads-eus2-edh-preprd-ctrm-005",  
                        "rg-ads-eus2-edh-preprd-dbx-005",
                        "rg-ads-eus2-edh-preprd-dls2-005",
                        "rg-ads-eus2-edh-preprd-syn-005" ]
                        #"test" 
#Vnet variables
vnet_name           = "vnet-ads-eus2-analytics-int-edhpreprd-004"
rgvnet              = "rg-ads-eus2-edh-preprd-dbx-005"
address_space_vnet1 = ["10.40.48.0/20"]
subnets = {
  pep = {
    name                              = "sn-ads-eus2-analytics-edhpreprd-pep-001"
    address_prefixes                  = ["10.40.52.0/26"]
    private_endpoint_network_policies = "Disabled"
  }
  app = {
    name                              = "sn-ads-eus2-analytics-edhpreprd-app-001"
    address_prefixes                  = ["10.40.52.64/26"]
    private_endpoint_network_policies = "Enabled"
  }
  databricks = {
    name                              = "sn-ads-eus2-analytics-edhpreprd-dbx-001"
    address_prefixes                  = ["10.40.52.128/26"]
    private_endpoint_network_policies = "Enabled"
  }
}

key_vault_name           = "kv-ads-eus2-edhpreprd-001"
rgkv                     = "rg-ads-eus2-edh-preprd-dbx-005"
purge_protection_enabled = false

# Storage Variables
storage-name = "dls2adseus2edhpreprd01"
storsubnet_id = "/subscriptions/8987b447-d083-481e-9c0f-f2b73a15b18b/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"
account-tier = "Standard"
replication-type = "ZRS"
storage-kind = "StorageV2"
storage-tls = "TLS1_2"
location     = "eastus"
storage_rg = "rg-ads-eus2-edh-preprd-dls2-001"
#"rg-ads-eus2-pioneer-inn-armtotf"

# PE Variables
privateendpointnameBlob = "pep-dls2-blob-ads-eus2-edh-preprd-001"
privateendpointnamedfs = "pep-dls2-dfs-ads-eus2-edhpreprd-dev-001"
privateendpointnametb = "pep-dls2-table-ads-eus2-edhpreprd-dev-001"
privateendpointnamefile = "pep-dls2-file-ads-eus2-edh-preprd-001"
privateendpointnamequ = "pep-dls2-queue-ads-eus2-edh-preprd-001"

# TAG values
AppId = "TBD"
DataClassification = "CONFIDENTIAL"
Role = "Tools"
SupportGroup = "ADCS.Cloud.Infrastructure"
environment = "dev"

#CTRM (VM) values
vmsubnetname = "sn-ads-eus2-analytics-preprd-app-001"
vmnicsub_id = "/subscriptions/8987b447-d083-481e-9c0f-f2b73a15b18b/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-preprd-app-001"
// vmsb_add = ["10.40.49.0/24"]
nicname1 = "example-nic1"
private_ip_address_allocation = "Dynamic"
nicname2 = "example-nic2"
vm1 = "ACS09L193"
vm2  = "ACS09L194"
publisher = "RedHat"
offer     = "RHEL"
sku       = "7.8"  
version   = "latest"
version1   = "latest"
rgvm = "rg-ads-eus2-edh-preprd-ctrm-001"
vm_size =  "Standard_E2s_v3"
os_disk1 = "ACS09L193-osdisk"
os_disk2 = "ACS09L194-osdisk"
caching           = "ReadWrite"
create_option     = "FromImage"
managed_disk_type = "Premium_LRS"
os_type = "Linux"    
computer_name1 = "ACS29L018"
admin_username1 = "ctrmadmin"
admin_password1 = "Ab@c123"
managed_disk_type_name1 = "acs09l193-datadisk-01"
storage_account_type = "Standard_LRS"
computer_name2 = "ACS29L019"
admin_username2 = "ctrmadmin"
admin_password2 = "Ab@c123"
managed_disk_type_name2 = "acs09l194-datadisk-01"

#Key vault values
// key_vault_name = "kvadseus2e3wprd1"
// key_permissions = [
//                         "get",
//                         "list",
//                         "update",
//                         "Create",
//                         "import",
//                         "delete",
//                         "recover",
//                         "backup",
//                         "restore",
//                         "decrypt",
//                         "encrypt",
//                         "unwrapKey",
//                         "wrapKey",
//                         "verify",
//                         "sign"
//                     ]
// secret_permissions =   [
//                         "get",
//                         "list",
//                         "set",
//                         "delete",
//                         "recover",
//                         "backup",
//                         "restore"
//                     ]
// key_vault_end_point_name = "kvadseus2edhpreprd1"
// kvsubnet_id = "/subscriptions/8987b447-d083-481e-9c0f-f2b73a15b18b/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"
// # "/subscriptions/eecd271c-6ad0-435b-9ff3-495957463af0/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"
// rgkv = "rg-ads-eus2-edh-preprd-dbx-001"
// #"rg-ads-eus2-pioneer-inn-armtotf"
// purge_protection_enabled = false

#Datafactory values
datafactory_name         = "adf-ads-eus2-edhpreprd-001"
rgdfac                   = "rg-ads-eus2-edh-preprd-adf-005"
datafactory_endpointname = "pep-adf-ads-eus2-edhpreprd-001"

#AppInsights Values
loganalytics_workspace_appin = "log-ads-eus2-edhpreprd-001"
rgappin                      = "rg-ads-eus2-edh-preprd-appin-005"
appinsights_name             = "appin-ads-eus2-edhpreprd-001"
sku_appin                    = "PerGB2018"
application_type             = "web"

#Synapse Alaytics Values
rgsyn = "rg-ads-eus2-edh-preprd-syn-001"
synsubnet_id = "/subscriptions/8987b447-d083-481e-9c0f-f2b73a15b18b/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"
#"/subscriptions/eecd271c-6ad0-435b-9ff3-495957463af0/resourceGroups/rg-ads-eus2-pioneer-inn-armtotf/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"
versionsyn = "12.0"
administrator_login_synsql = "etarrowo"
administrator_login_password_synsql = "ab1@cdef"
requested_service_objective_name = "DW100c"
sqlserver_name  = "acs06x010"
editionsyn = "DataWarehouse"
sqldw_name = "syn-ads-eus2-edhpreprd-dev-001"
sqlser_endpoint = "pep-ACS06X010"

#Azure App service
appServPlanName = "appsvcpl-ads-eus2-edh-preprd-001"
kind = "linux"
appServPlanSKU = "PremiumV3"
appServPlanTier = "P1v3"
appServiceName1 = "appsvc-ads-eus2-edh-preprd-001"
appServiceName2 = "appsvc-ads-eus2-edh-preprd-002"
rgappser = "rg-ads-eus2-edh-preprd-appsvc-001"
linux_fx_version = "NODE|12-lts"
ftps_state = "Disabled"
http2_enabled = false
php_version = "7.4"   
python_version = "3.4"   
dotnet_framework_version = "v4.0"
appser_sql_server_name = "acs6x007"
sql_server_version_appser = "12.0"
administrator_login_appser ="adsmetasqladmin"
appsersqldb_name = "sdb-ads-eus2-edh-preprd-001"
sql_storage_appser = "P1"
sql_redundancy_appser = true
appser_sqldb1 = "sdb-ads-eus2-edh-preprd-002"
appser_endpoint =  "pep-acs6x007"
appser_endpoint1 = "pep-appsvc-ads-eus2-edh-preprd-001"
appser_endpoint2 = "pep-appsvc-ads-eus2-edh-preprd-002"
appsersubnet_id = "/subscriptions/8987b447-d083-481e-9c0f-f2b73a15b18b/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"
#"/subscriptions/eecd271c-6ad0-435b-9ff3-495957463af0/resourceGroups/rg-ads-eus2-pioneer-inn-armtotf/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"


#databricks Variables
databricksworkspace_name = "dbx-ads-eus2-edh-preprd-003"
dbrlogworkspace-name  = "law-ads-eus2-core-edhpreprd-001"
databricks_managed_resource_group_name = "rg-ads-eus2-edh-preprd-dbx-001"
// dbrsku  = "PerGB2018"
sku_premium = "premium"
// public_address_prefix_dbr  = ["10.40.52.0/26"]
// private_address_prefix_dbr  = ["10.40.52.64/26"]
// security_group_name_public_dbr  = "nsg-ads-eus2-analytics-edhpreped-dbxpub-001"
// security_group_name_private_dbr = "nsg-ads-eus2-analytics-edhpreprd-dbxprv-001"
rgdbr         = "rg-ads-eus2-edh-preprd-dbx-001"
vnet_id                     = "/subscriptions/8987b447-d083-481e-9c0f-f2b73a15b18b/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004"
#"/subscriptions/eecd271c-6ad0-435b-9ff3-495957463af0/resourceGroups/rg-ads-eus2-pioneer-inn-armtotf/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004"
// private_subnet_name_dbr      = "sn-ads-eus2-analytics-preprd-prv-01"
// public_subnet_name_dbr          = "sn-ads-eus2-analytics-preprd-pub-01"
