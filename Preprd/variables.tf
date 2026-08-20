# If you don't declare varibales in the root variables.tf, you will get an error like this:
# Error: Reference to undeclared input variable
# The line in demo.auto.tfvars has nowhere to land. Terraform sees a value for a variable the root doesn't know about.
# The root declaration lets the value enter your configuration from the tfvars file.
# The module declaration lets the value enter the module from the root.

# # resource group name 
variable "resource-group" {
  type = list
  description = "The application name used to build resources"
}

#Storage account variables
variable "location" {
  type = string
  #default = "eastus2"
}variable "storage-name" {
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
  default = "vnet-ads-eus2-analytics-int-edhpreprd-004"
}

variable "rgvnet" {
  type        = string
  description = "Resource group for the virtual network"
}

variable "address_space_vnet1" {
  type        = list(string)
  description = "Address space for the virtual network"
  default = ["10.40.52.0/26"]
}

variable "subnets" {
  type = map(object({
    name                              = string
    address_prefixes                  = list(string)
    private_endpoint_network_policies = string
  }))
  description = "Subnets to create in the VNet, keyed by logical name"
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
  type = string
  description = "The AppId (Tag variable)"
  #default = "TBD" 
}
variable "environment" {
  type = string
  description = "The environment to be built (Tag variable)"
  #default = "dev"
}

variable "DataClassification" {
  type = string
  description = "The DataClassification (Tag variable)"
  #default = "CONFIDENTIAL"
}

variable "Role" {
  type = string
  description = "The Role (Tag variable)"
  #default = "Tools"
}

variable "SupportGroup" {
  type = string
  description = "The SupportGroup (Tag variable)"
  #default = "ADCS.Cloud.Infrastructure"
}




#Variables of Virtual Machine

# variable "vmnicsub_id" {
#   type = string
#   description = "The vmnicsubnet_id"
#   default = ""
# }
# variable "caching" {
#   type = string
#   description = "Resource group name"
#   default = "ReadWrite"
# }

# variable "os_disk1" {
#   type = string
#   description = "storage_os_disk name"
#   #default = "acs29l018-osdisk-20210805-181232"
# }

# variable "os_disk2" {
#   type = string
#   description = "storage_os_disk name"
#  # default = "acs29l018-osdisk-20210805-181232"
# }

# variable "vm1" {
#   type = string
#   description = "virtual machine name 1"
#   default = "ACS29L018"
# }

# variable "vm2" {
#   type = string
#   description = "virtual machine name 2"
#   default = "ACS29L019"
# }

# variable "os_type" {
#   type = string
#   description = ""
#   default = ""
# }

# variable "vmsubnetname" {
#   type = string
#   description = "The subnet name"
#   default = ""
# }

# // variable "vmsb_add" {
# //   type = list
# //   description = "The address vprefixes"
# //   #default = ""
# // }

# variable "nicname1" {
#   type = string
#   description = "The nic1 name"
#   default = ""
# }

# variable "nicname2" {
#   type = string
#   description = "The nic2 name"
#   default = ""
# }

# variable "private_ip_address_allocation" {
#   type = string
#   description = "The private_ip_address_allocation"
#   default = ""
# }

# variable "rgvm" {
#   type = string
#   description = "The Resourse group of VM"
#   default = ""
# }

# variable "vm_size" {
#   type = string
#   description = "The vm size"
#   default = ""
# }

# variable "publisher" {
#   type = string
#   description = "The publisher"
#   default = ""
# }
# variable "offer" {
#   type = string
#   description = "The offer"
#   default = ""
# }
# variable "computer_name1" {
#   type = string
#   description = "The computer name1"
#  default = ""
# }
# variable "admin_username1" {
#   type = string
#   description = "The admin username"
#  default = ""
# }
# variable "admin_password1" {
#   type = string
#   description = "The admin password"
#  default = ""
# }
# variable "computer_name2" {
#   type = string
#   description = "The computer name2"
#  default = ""
# }
# variable "admin_username2" {
#   type = string
#   description = "The admin username2"
#  default = ""
# }
# variable "admin_password2" {
#   type = string
#   description = "The admin password2"
#  default = ""
# }
# variable "sku" {
#   type = string
#   description = "The sku"
#  default = ""
# }
# variable "version1" {
#   type = string
#   description = "The version"
#  default = ""
# }
# variable "managed_disk_type" {
#   type = string
#   description = "managed_disk_type"
#  default = ""
# }
# variable "managed_disk_type_name1" {
#   type = string
#   description = "Managed_disk_type name1"
#  default = ""
# }
# variable "managed_disk_type_name2" {
#   type = string
#   description = "Managed_disk_type name2"
#  default = ""
# }

# variable "storage_account_type" {
#   type = string
#   description = "Storage_account_type (VM)"
#  default = ""
# }

# variable "create_option" {
#   type = string
#   description = ""
#   #default = ""
# }


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
# variable "rgsyn" {
#   description = "Resource group name"
#   default = "rg-ads-eus2-pioneer-inn-armtotf"
# }

# variable "sqlserver_name" {
#   type = string
#   description = "The sqlserver name"
#   default = "acs26x012"
# }

# variable "versionsyn" {
#   type = string
#   description = "The environment to be built"
#   default = "12.0"
# }

# variable "administrator_login_synsql" {
#   type = string
#   description = "The administrator_login"
#   default = ""
# }

# variable "administrator_login_password_synsql" {
#   type = string
#   description = "The administrator_login_password"
#   default = "dev"
# }

# variable "sqldw_name" {
#   type = string
#   description = "The sql datawarehouse name"
#   default = "syn-ads-eus2-edhpreprd-dev-001"
# }

# variable "editionsyn" {
#   type = string
#   description = "The edition"
#   default = "DataWarehouse"
# }

# variable "sqlser_endpoint" {
#   type = string
#   description = "The sqlserver private endpoint"
#   default = "pep-a6X0011"
# }

# variable "synsubnet_id" {
#   type = string
#   description = "The subnet_id"
#   default = "/subscriptions/eecd271c-6ad0-435b-9ff3-495957463af0/resourceGroups/rg-ads-eus2-pioneer-inn-armtotf/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"
# }
# variable "requested_service_objective_name" {
#   type = string
# }

#Azure App service values

# variable "linux_fx_version" {
#   type = string
# }

# variable "ftps_state" {
#   type = string
# } 

# variable "http2_enabled" {
  
# } 

# variable "php_version" {
#   type = string
# } 

# variable "python_version" {
#   type = string
# } 

# variable "dotnet_framework_version" {
#   type = string
# }

# variable "rgappser" {
#   type = string
# }

# variable "appServPlanName" {
#   description = "Name of the app service plan"
# }

# variable "appServPlanTier" {
#   description = "app service plan's tier"
# }

# variable "appServPlanSKU" {
#   description = "app service plan's instance size"
# }

# variable "kind" {
#   description = "The kind of the App Service Plan to create. Possible values are Windows (also available as App), Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan). Defaults to Windows. Changing this forces a new resource to be created."
# }

# variable "appser_sql_server_name" {
#   type = string
#   description = "The name of the database."
# }

# variable "administrator_login_appser" {
#   type = string
#   description = "Specifies the name of the SQL administrator."
# }

# variable "sql_server_version_appser" { 
#   type = string
#   description = "SQl Server version"
# }

# variable "sql_storage_appser"{
#   type = string
#   description = "Appsevice Sql Storage Name"
# }

# variable "appsersqldb_name"{
#   type = string
#   description = "Appsevice Sql Database Name"
# }

# variable "appser_sqldb1" {
#     type = string
#     description = "Appsevice Sql Database Name"
# }

# variable "sql_redundancy_appser" {
#   description = "Sql redundancy_appser"
# }

#Variables for azurerm_app_service
# variable "appServiceName1" {
#   type = string
#   description = "Name of the app service 1"
# }

# variable "appServiceName2" {
#   type = string
#   description = "Name of the app service 2"
# }
# variable "appsersubnet_id" {
#   type = string
# }

# variable "appser_endpoint" {
#   type = string
# }


# Databrciks variables
// variable "dbrlogworkspace-name" {
//   type        = string
//   description = "The workspace name"
//   #default     = "law-ads-eus2-core-dev-001"
// }
// variable "vnet_id" {
//   type        = string
//   description = "The vnet_id"
//   default     = ""
// }

// variable "dbrsku" {
//   type        = string
//   description = "The sku"
//   #default     = "PerGB2018"
// }
 
// variable "security_group_name_public_dbr" {
//   type        = string
//   description = "names of the security groups created by this module"
//   default     = ""
// }

// variable "security_group_name_private_dbr" {
//   type        = string
//   description = "names of the security groups created by this module"
//   default     = ""
// }

// variable "private_address_prefix_dbr" {
//   type        = list
//   description = "The private_address_prefix"
// }

// variable "public_address_prefix_dbr" {
//   type        = list
//   description = "The public_address_prefix"
// }

variable "sku_premium" {
  type        = string
  description = "The sku "
}

// variable "rgvnet" {
//   type        = string
//   description = "Name of resource group which contains the virtual network and subnets"
// }

// variable "private_subnet_name_dbr" {
//   type        = string
//   description = "Name of the private subnet"
// }

// variable "public_subnet_name_dbr" {
//   type        = string
//   description = "Name of the public subnet"
// }

variable "rgdbr" {
  type        = string
  description = "Name of the resource group"
}

variable "databricksworkspace_name" {
  type        = string
  description = "Name of the workspace"
}

variable "databricks_managed_resource_group_name" {
  type        = string
  description = "Name of the managed resource group for Databricks workspace"
}
