variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "rgkv" {
  type        = string
  description = "Resource group for the Key Vault"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Whether purge protection is enabled on the vault"
  default     = false
}

variable "AppId" {
  type        = string
  description = "Governance tag: application identifier"
}

variable "environment" {
  type        = string
  description = "Governance tag: environment name"
}

variable "DataClassification" {
  type        = string
  description = "Governance tag: data sensitivity classification"
}

variable "Role" {
  type        = string
  description = "Governance tag: workload role"
}

variable "SupportGroup" {
  type        = string
  description = "Governance tag: owning support group"
}
# Moved to RBAC model for Key Vault access control, so we don't need to define access policies in the Key Vault resource. Instead, we will use Azure RBAC roles to manage access to the Key Vault. The following variables are commented out as they are no longer needed.
# variable "key_permissions" {
# }
# variable "secret_permissions" {
# }

