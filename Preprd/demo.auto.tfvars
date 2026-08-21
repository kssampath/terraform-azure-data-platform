resource-group = ["rg-ads-eus2-edh-preprd-adf-005",
  "rg-ads-eus2-edh-preprd-appin-005",
  "rg-ads-eus2-edh-preprd-appsvc-005",
  "rg-ads-eus2-edh-preprd-ctrm-005",
  "rg-ads-eus2-edh-preprd-dbx-005",
  "rg-ads-eus2-edh-preprd-dls2-005",
"rg-ads-eus2-edh-preprd-syn-005"]
#"test" 
#Vnet variables
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

  databricks_public = {
    name                              = "sn-ads-eus2-analytics-edhpreprd-dbxpub-001"
    address_prefixes                  = ["10.40.52.128/26"]
    private_endpoint_network_policies = "Enabled"
    delegation = {
      name         = "databricks-delegation"
      service_name = "Microsoft.Databricks/workspaces"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
  databricks_private = {
    name                              = "sn-ads-eus2-analytics-edhpreprd-dbxpriv-001"
    address_prefixes                  = ["10.40.52.192/26"]
    private_endpoint_network_policies = "Enabled"
    delegation = {
      name         = "databricks-delegation"
      service_name = "Microsoft.Databricks/workspaces"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

network_security_groups = {
  dbx_public  = "nsg-ads-eus2-analytics-edhpreprd-dbxpub-001"
  dbx_private = "nsg-ads-eus2-analytics-edhpreprd-dbxpriv-001"
}

subnet_nsg_associations = {
  databricks_public  = "dbx_public"
  databricks_private = "dbx_private"
}

key_vault_name           = "kv-ads-eus2-edhpreprd-001"
rgkv                     = "rg-ads-eus2-edh-preprd-dbx-005"
purge_protection_enabled = false

# Storage Variables
storage-name     = "dls2adseus2edhpreprd001"
storage_rg       = "rg-ads-eus2-edh-preprd-dls2-005"
account-tier     = "Standard"
replication-type = "ZRS"
storage-kind     = "StorageV2"
storage-tls      = "TLS1_2"

storage_private_endpoints = {
  blob  = "pep-dls2-blob-ads-eus2-edhpreprd-001"
  dfs   = "pep-dls2-dfs-ads-eus2-edhpreprd-001"
  file  = "pep-dls2-file-ads-eus2-edhpreprd-001"
  queue = "pep-dls2-queue-ads-eus2-edhpreprd-001"
  table = "pep-dls2-table-ads-eus2-edhpreprd-001"
}


# TAG values
AppId              = "TBD"
DataClassification = "CONFIDENTIAL"
Role               = "Tools"
SupportGroup       = "ADCS.Cloud.Infrastructure"
environment        = "dev"

#CTRM (VM) values
rgvm                          = "rg-ads-eus2-edh-preprd-ctrm-005"
vm_size                       = "Standard_E2s_v3"
private_ip_address_allocation = "Dynamic"
publisher                     = "RedHat"
offer                         = "RHEL"
sku                           = "7_9"
version1                      = "latest"
caching                       = "ReadWrite"
managed_disk_type             = "Premium_LRS"
storage_account_type          = "Standard_LRS"
vm_admin_secret_name          = "vm-admin-password"

virtual_machines = {
  vm1 = {
    name           = "ACS29L018"
    nic_name       = "nic-acs29l018-001"
    ip_config_name = "ipconfig-acs29l018"
    computer_name  = "ACS29L018"
    admin_username = "ctrmadmin"
    os_disk_name   = "osdisk-acs29l018-001"
    data_disk_name = "datadisk-acs29l018-001"
  }
  vm2 = {
    name           = "ACS29L019"
    nic_name       = "nic-acs29l019-001"
    ip_config_name = "ipconfig-acs29l019"
    computer_name  = "ACS29L019"
    admin_username = "ctrmadmin"
    os_disk_name   = "osdisk-acs29l019-001"
    data_disk_name = "datadisk-acs29l019-001"
  }
}


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
sqlserver_name             = "sql-syn-ads-eus2-edhpreprd-001"
versionsyn                 = "12.0"
administrator_login_synsql = "synadmin"
sqldw_name                 = "syndw-ads-eus2-edhpreprd-001"
sqldw_sku                  = "DW100c"
sqlser_endpoint            = "pep-syn-ads-eus2-edhpreprd-001"
rgsyn                      = "rg-ads-eus2-edh-preprd-syn-005"
syn_sql_admin_secret_name  = "syn-sql-admin-password"

#Azure App service
appServPlanName      = "asp-ads-eus2-edhpreprd-001"
app_service_sku_name = "P1v3"
node_version         = "20-lts"
ftps_state           = "Disabled"
http2_enabled        = false

app_services = {
  app1 = "app-ads-eus2-edhpreprd-001"
  app2 = "app-ads-eus2-edhpreprd-002"
}

rgappser                   = "rg-ads-eus2-edh-preprd-appsvc-005"
appser_sql_server_name     = "sql-ads-eus2-edhpreprd-001"
administrator_login_appser = "sqladmin"
sql_server_version_appser  = "12.0"
sql_sku_appser             = "P1"
appsersqldb_name           = "sdb-ads-eus2-edhpreprd-001"
appser_sqldb1              = "sdb-ads-eus2-edhpreprd-002"
sql_redundancy_appser      = true
appser_endpoint            = "pep-sql-ads-eus2-edhpreprd-001"
sql_admin_secret_name      = "sql-admin-password"

#databricks Variables
databricksworkspace_name    = "dbx-ads-eus2-edh-preprd-003"
managed_resource_group_name = "rg-ads-eus2-edh-preprd-dbx-001"
sku_premium                 = "premium"

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