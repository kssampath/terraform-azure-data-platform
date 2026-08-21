variable "location" {
  type        = string
  description = "Azure region"
}

variable "rgsyn" {
  type        = string
  description = "Resource group for Synapse"
}

variable "environment" {
  type        = string
  description = "Environment (governance tag)"
}

variable "sqlserver_name" {
  type        = string
  description = "SQL server name"
}

variable "versionsyn" {
  type        = string
  description = "SQL server version (e.g. 12.0)"
}

variable "administrator_login_synsql" {
  type        = string
  description = "SQL administrator login name"
}

variable "sqldw_name" {
  type        = string
  description = "Synapse SQL data warehouse name"
}

variable "sqldw_sku" {
  type        = string
  description = "Data warehouse SKU (e.g. DW100c)"
}

variable "sqlser_endpoint" {
  type        = string
  description = "SQL private endpoint name"
}

variable "synsubnet_id" {
  type        = string
  description = "Subnet ID for the private endpoint (from VNet output)"
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault name holding the SQL admin password"
}

variable "keyvault_rg" {
  type        = string
  description = "Key Vault resource group"
}

variable "syn_sql_admin_secret_name" {
  type        = string
  description = "Key Vault secret name for the Synapse SQL admin password"
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