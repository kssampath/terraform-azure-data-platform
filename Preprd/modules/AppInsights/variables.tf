variable "loganalytics_workspace_appin" {
  type = string
  description = "The loganalytics workspace name"
  // default = "workspace-test" 
}

variable "location" {
  type        = string
  description = "Azure region"
  default = "eastus2"
}

variable "rgappin" {
  type        = string
  description = "Resource group name for App Insights"
  default = "rg-ads-eus2-pioneer-inn-armtotf"
}

variable "retention_in_days" {
  type        = number
  description = "Log Analytics data retention in days"
  default     = 30
}

variable "sku_appin" {
  type = string
  description = "The sku"
  // default = "PerGB2018"
}

variable "appinsights_name" {
  type = string
  description = "The appinsights name"
  // default = "appin-ads-eus2-edhpreprd-dev-001"
}

variable "application_type" {
  type = string
  description = "The application type"
  // default = "web"
}

variable "AppId" {
  type = string
  description = "The AppId"
  // default = "TBD" 
}

variable "environment" {
  type = string
  description = "The environment to be built"
  // default = "dev"
}

variable "DataClassification" {
  type = string
  description = "The DataClassification"
  // default = "CONFIDENTIAL"
}

variable "Role" {
  type = string
  description = "The Role"
  // default = "Tools"
}

variable "SupportGroup" {
  type = string
  description = "The SupportGroup"
  // default = "ADCS.Cloud.Infrastructure"
}
