# If you don't declare varibales in the root variables.tf, you will get an error like this:
# Error: Reference to undeclared input variable
# The line in demo.auto.tfvars has nowhere to land. Terraform sees a value for a variable the root doesn't know about.
# The root declaration lets the value enter your configuration from the tfvars file.
# The module declaration lets the value enter the module from the root.

# # resource group name 
variable "resource-group" {
  type        = list(any)
  description = "The application name used to build resources"
}

#Storage account variables
variable "location" {
  type = string
  #default = "eastus2"
}
variable "storage-name" {
  type        = string
  description = "Storage account name (ADLS Gen2)"
}

variable "storage_rg" {
  type        = string
  description = "Resource group for the storage account"
}

variable "account-tier" {
  type        = string
  description = "Storage account tier"
}

variable "replication-type" {
  type        = string
  description = "Storage replication type"
}

variable "storage-kind" {
  type        = string
  description = "Storage account kind"
}

variable "storage-tls" {
  type        = string
  description = "Minimum TLS version"
}

variable "storage_private_endpoints" {
  type        = map(string)
  description = "Map of storage sub-resource type to private endpoint name"
}

# Variables of Vnet and subnets
variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
  default     = "vnet-ads-eus2-analytics-int-edhpreprd-004"
}

variable "rgvnet" {
  type        = string
  description = "Resource group for the virtual network"
}

variable "address_space_vnet1" {
  type        = list(string)
  description = "Address space for the virtual network"
  default     = ["10.40.52.0/26"]
}

variable "subnets" {
  type = map(object({
    name                              = string
    address_prefixes                  = list(string)
    private_endpoint_network_policies = string
  }))
  description = "Subnets to create in the VNet, keyed by logical name"
}


variable "network_security_groups" {
  type        = map(string)
  description = "NSGs to create in the VNet"
  default     = {}
}

variable "subnet_nsg_associations" {
  type        = map(string)
  description = "Map of subnet key to NSG key"
  default     = {}
}

variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "rgkv" {
  type        = string
  description = "Resource group for the Key Vault"
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Whether purge protection is enabled on the Key Vault"
  default     = false
}
variable "key_vault_end_point_name" {
  type        = string
  description = "Name of the Key Vault private endpoint"
}
# variable "storage_rg" {
#   type = string
#   description = "Resource group name of Storage_account"
#   #default = "rg-ads-eus2-dstkpreprd-dev-001"
# }

# variable "storage-name" {
#   type = string
#   description = "Storage account name"
#   #default = ""
# }

# variable "storsubnet_id" {
#   type = string
#   description = "The subnet_id"
# #  default = "/subscriptions/eecd271c-6ad0-435b-9ff3-495957463af0/resourceGroups/rg-ads-eus2-pioneer-inn-armtotf/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"
# }
# variable "account-tier" {
#   type = string
#   description = "The account tier"
#   default = "Standard"
# }

# variable "replication-type" {
#   type = string
#   description = "The replication type"
#   default = "ZRS"
# }

# variable "storage-kind" {
# 	description = "The storage kind"
#     default = "StorageV2"
# }

# variable "storage-tls" {
# 	description = "The storage tls"
#     default = "TLS1_2"
# }

# variable "privateendpointnameBlob" {
#   type = string
#   description = "The privateend point of Blob"
#   #default = "pep-dls2-blob-ads-eus2-edhpreprd-dev-001"
# }

# variable "privateendpointnamedfs" {
#   type = string
#   description = "The privateend point of dfs"
#   #default = "pep-dls2-blob-ads-eus2-edhpreprd-dev-001"
# }

# variable "privateendpointnametb" {
#   type = string
#   description = "The privateend point of table"
#   #default = "pep-dls2-blob-ads-eus2-edhpreprd-dev-001"
# }

# variable "privateendpointnamefile" {
#   type = string
#   description = "The privateend point of file"
#   #default = "pep-dls2-blob-ads-eus2-edhpreprd-dev-001"
# }

# variable "privateendpointnamequ" {
#   type = string
#   description = "The privateend point of Queue"
#   #default = "pep-dls2-blob-ads-eus2-edhpreprd-dev-001"
# }

#Tag Variables
variable "AppId" {
  type        = string
  description = "The AppId (Tag variable)"
  #default = "TBD" 
}
variable "environment" {
  type        = string
  description = "The environment to be built (Tag variable)"
  #default = "dev"
}

variable "DataClassification" {
  type        = string
  description = "The DataClassification (Tag variable)"
  #default = "CONFIDENTIAL"
}

variable "Role" {
  type        = string
  description = "The Role (Tag variable)"
  #default = "Tools"
}

variable "SupportGroup" {
  type        = string
  description = "The SupportGroup (Tag variable)"
  #default = "ADCS.Cloud.Infrastructure"
}




#Variables of Virtual Machine
variable "virtual_machines" {
  type = map(object({
    name           = string
    nic_name       = string
    ip_config_name = string
    computer_name  = string
    admin_username = string
    os_disk_name   = string
    data_disk_name = string
  }))
  description = "Map of VM definitions, keyed by logical name"
}

variable "rgvm" {
  type        = string
  description = "Resource group for the CTRM VMs"
}

variable "vm_size" {
  type        = string
  description = "VM size"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "Private IP allocation method"
}

variable "publisher" {
  type        = string
  description = "VM image publisher"
}

variable "offer" {
  type        = string
  description = "VM image offer"
}

variable "sku" {
  type        = string
  description = "VM image SKU"
}

variable "version1" {
  type        = string
  description = "VM image version"
}

variable "caching" {
  type        = string
  description = "OS disk caching"
}

variable "managed_disk_type" {
  type        = string
  description = "OS disk storage account type"
}

variable "storage_account_type" {
  type        = string
  description = "Data disk storage account type"
}

variable "vm_admin_secret_name" {
  type        = string
  description = "Key Vault secret name holding the VM admin password"
}

#Keyvault variables
// variable "key_vault_name" {
//     description = "Specifies the name of the Key Vault"
// }

// variable "rgkv" {
//     description = "Resource group of Keyvault"
// }

// variable "key_vault_end_point_name" {
//     description = "Name of Endpoint used in key vault"
// }

// variable "kvsubnet_id" {
//     description = "Subnet id"
// }

// variable "purge_protection_enabled" {
//     description = "Purge Protection Enabled"
// }

// variable "key_permissions" {
//     description = "Key Permissions"
// }

// variable "secret_permissions" {
//     description = "Secret Permissions"
// }

#Datafactory variables
variable "datafactory_name" {
  type        = string
  description = "Data Factory name"
}

variable "rgdfac" {
  type        = string
  description = "Resource group for the Data Factory"
}

variable "datafactory_endpointname" {
  type        = string
  description = "Data Factory private endpoint name"
}

#AppInsights name
variable "loganalytics_workspace_appin" {
  type        = string
  description = "Log Analytics workspace name for App Insights"
}

variable "rgappin" {
  type        = string
  description = "Resource group for App Insights"
}

variable "appinsights_name" {
  type        = string
  description = "Application Insights instance name"
}

variable "sku_appin" {
  type        = string
  description = "Log Analytics SKU"
}

variable "application_type" {
  type        = string
  description = "Application Insights application type (e.g. web)"
}

#Azure Synapse Analytics
variable "sqlserver_name" {
  type        = string
  description = "Synapse SQL server name"
}

variable "versionsyn" {
  type        = string
  description = "Synapse SQL server version"
}

variable "administrator_login_synsql" {
  type        = string
  description = "Synapse SQL administrator login"
}

variable "sqldw_name" {
  type        = string
  description = "Synapse SQL data warehouse name"
}

variable "sqldw_sku" {
  type        = string
  description = "Synapse data warehouse SKU"
}

variable "sqlser_endpoint" {
  type        = string
  description = "Synapse SQL private endpoint name"
}

variable "rgsyn" {
  type        = string
  description = "Resource group for Synapse"
}

variable "syn_sql_admin_secret_name" {
  type        = string
  description = "Key Vault secret name for the Synapse SQL admin password"
}
#Azure App service values
variable "appServPlanName" {
  type        = string
  description = "App Service Plan name"
}

variable "app_service_sku_name" {
  type        = string
  description = "App Service Plan SKU"
}

variable "app_services" {
  type        = map(string)
  description = "Map of logical name to web app name"
}

variable "node_version" {
  type        = string
  description = "Node.js version for web apps"
}

variable "ftps_state" {
  type        = string
  description = "FTPS state"
}

variable "http2_enabled" {
  type        = bool
  description = "Whether HTTP/2 is enabled"
}

variable "rgappser" {
  type        = string
  description = "Resource group for App Service resources"
}

variable "appser_sql_server_name" {
  type        = string
  description = "SQL server name"
}

variable "administrator_login_appser" {
  type        = string
  description = "SQL administrator login"
}

variable "sql_server_version_appser" {
  type        = string
  description = "SQL server version"
}

variable "sql_sku_appser" {
  type        = string
  description = "SQL database SKU"
}

variable "appsersqldb_name" {
  type        = string
  description = "First SQL database name"
}

variable "appser_sqldb1" {
  type        = string
  description = "Second SQL database name"
}

variable "sql_redundancy_appser" {
  type        = bool
  description = "Whether the first database is zone redundant"
}

variable "appser_endpoint" {
  type        = string
  description = "SQL private endpoint name"
}

variable "sql_admin_secret_name" {
  type        = string
  description = "Key Vault secret name for the SQL admin password"
}


variable "sku_premium" {
  type        = string
  description = "The sku "
}



variable "rgdbr" {
  type        = string
  description = "Name of the resource group"
}

variable "databricksworkspace_name" {
  type        = string
  description = "Name of the workspace"
}
variable "managed_resource_group_name" {
  type        = string
  description = "Name of the Databricks-managed resource group (created and owned by Azure Databricks)"
}

variable "dbrlogworkspace_name" {
  type        = string
  description = "Databricks Log Analytics workspace name"
}

variable "dbrsku" {
  type        = string
  description = "Databricks Log Analytics SKU"
}

variable "dbx_public_subnet_name" {
  type        = string
  description = "Databricks public subnet name (must match the VNet subnet)"
}

variable "dbx_private_subnet_name" {
  type        = string
  description = "Databricks private subnet name (must match the VNet subnet)"
}