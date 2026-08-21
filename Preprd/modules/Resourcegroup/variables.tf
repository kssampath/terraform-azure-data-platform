# resource group name 
variable "resource-group" {
  type        = list(any)
  description = "The application name used to build resources"
}

variable "environment" {
  type        = string
  description = "The environment to be built"
  #default = "dev"
}

variable "AppId" {
  type        = string
  description = "The AppId"
  #default = "TBD" 
}

variable "DataClassification" {
  type        = string
  description = "The DataClassification"
  #default = "CONFIDENTIAL"
}

variable "Role" {
  type        = string
  description = "The Role"
  #default = "Tools"
}

variable "SupportGroup" {
  type        = string
  description = "The SupportGroup"
  #default = "ADCS.Cloud.Infrastructure"
}
# azure region
variable "location" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "eastus2"
}
