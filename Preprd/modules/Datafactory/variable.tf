variable "location" {
  type        = string
  description = "Azure region"
}

variable "environment" {
  type        = string
  description = "Environment name (governance tag)"
}

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

variable "dfacsubnet_id" {
  type        = string
  description = "Subnet ID for the private endpoint (passed from the VNet module output)"
}

variable "AppId" {
  type        = string
  description = "Governance tag: application identifier"
}

variable "DataClassification" {
  type        = string
  description = "Governance tag: data classification"
}

variable "Role" {
  type        = string
  description = "Governance tag: workload role"
}

variable "SupportGroup" {
  type        = string
  description = "Governance tag: support group"
}