variable "location" {
  type        = string
  description = "Azure region"
}

variable "rgappser" {
  type        = string
  description = "Resource group for App Service resources"
}

variable "appServPlanName" {
  type        = string
  description = "App Service Plan name"
}

variable "app_service_sku_name" {
  type        = string
  description = "App Service Plan SKU (e.g. P1v3)"
}

variable "app_services" {
  type        = map(string)
  description = "Map of logical name to web app name"
}

variable "node_version" {
  type        = string
  description = "Node.js version for the web apps (e.g. 20-lts)"
}

variable "ftps_state" {
  type        = string
  description = "FTPS state (e.g. Disabled)"
}

variable "http2_enabled" {
  type        = bool
  description = "Whether HTTP/2 is enabled"
}

variable "appser_sql_server_name" {
  type        = string
  description = "SQL server name"
}

variable "administrator_login_appser" {
  type        = string
  description = "SQL administrator login name"
}

variable "sql_server_version_appser" {
  type        = string
  description = "SQL server version (e.g. 12.0)"
}

variable "sql_sku_appser" {
  type        = string
  description = "SQL database SKU (e.g. P1, S0)"
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

variable "appsersubnet_id" {
  type        = string
  description = "Subnet ID for the SQL private endpoint (from VNet output)"
}

variable "appser_endpoint" {
  type        = string
  description = "SQL private endpoint name"
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault name holding the SQL admin password"
}

variable "keyvault_rg" {
  type        = string
  description = "Key Vault resource group"
}

variable "sql_admin_secret_name" {
  type        = string
  description = "Key Vault secret name for the SQL admin password"
}

variable "environment" {
  type        = string
  description = "Environment (governance tag)"
}

variable "AppId" {
  type        = string
  description = "Governance tag: app id"
}

variable "DataClassification" {
  type        = string
  description = "Governance tag: data classification"
}

variable "Role" {
  type        = string
  description = "Governance tag: role"
}

variable "SupportGroup" {
  type        = string
  description = "Governance tag: support group"
}