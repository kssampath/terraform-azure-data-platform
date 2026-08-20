// variable "dbrlogworkspace-name" {
//   type        = string
//   description = "The workspace name"
//   default     = "law-ads-eus2-core-dev-001"
// }

// variable "dbrsku" {
//   type        = string
//   description = "The sku"
//   default     = "PerGB2018"
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

variable "location" {
  type        = string
  description = "Location in which Databricks will be deployed"
}
variable "databricks_managed_resource_group_name" {
  type        = string
  description = "Name of the managed resource group for Databricks workspace"
}
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


// variable "vnet_name" {
//   type        = string
//   description = "Name of vnet"
//   default = "vnet-ads-eus2-analytics-int-dev-004"
// }
// variable "vnet_id" {
//   type = string
// }

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

variable "AppId" {
  type = string
  description = "The AppId"
  default = "TBD" 
}

variable "environment" {
  type = string
  description = "The environment to be built"
  default = "dev"
}

variable "DataClassification" {
  type = string
  description = "The DataClassification"
  default = "CONFIDENTIAL"
}

variable "Role" {
  type = string
  description = "The Role"
  default = "Tools"
}

variable "SupportGroup" {
  type = string
  description = "The SupportGroup"
  default = "ADCS.Cloud.Infrastructure"
}

