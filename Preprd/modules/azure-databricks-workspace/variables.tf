variable "dbrlogworkspace_name" {
  type        = string
  description = "Databricks Log Analytics workspace name"
}

variable "dbrsku" {
  type        = string
  description = "Log Analytics SKU"
}

variable "vnet_id" {
  type        = string
  description = "ID of the VNet for Databricks injection"
}

variable "public_subnet_name_dbr" {
  type        = string
  description = "Name of the Databricks public (host) subnet"
}

variable "private_subnet_name_dbr" {
  type        = string
  description = "Name of the Databricks private (container) subnet"
}

variable "public_subnet_nsg_association_id" {
  type        = string
  description = "NSG association ID for the public subnet"
}

variable "private_subnet_nsg_association_id" {
  type        = string
  description = "NSG association ID for the private subnet"
}

variable "managed_resource_group_name" {
  type        = string
  description = "Name of the Databricks-managed resource group"
}
variable "location" {
  type        = string
  description = "Location in which Databricks will be deployed"
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

variable "AppId" {
  type        = string
  description = "The AppId"
  default     = "TBD"
}

variable "environment" {
  type        = string
  description = "The environment to be built"
  default     = "dev"
}

variable "DataClassification" {
  type        = string
  description = "The DataClassification"
  default     = "CONFIDENTIAL"
}

variable "Role" {
  type        = string
  description = "The Role"
  default     = "Tools"
}

variable "SupportGroup" {
  type        = string
  description = "The SupportGroup"
  default     = "ADCS.Cloud.Infrastructure"
}

