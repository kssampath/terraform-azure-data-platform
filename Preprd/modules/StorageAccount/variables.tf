
# storage name 
variable "storage-name" {
  type        = string
  description = "default storage account name"
  #default = "dls2adseus2dstkpreprddeve01"
}
variable "storsubnet_id" {
  type        = string
  description = "The subnet_id"
  #  default = "/subscriptions/eecd271c-6ad0-435b-9ff3-495957463af0/resourceGroups/rg-ads-eus2-pioneer-inn-armtotf/providers/Microsoft.Network/virtualNetworks/vnet-ads-eus2-analytics-int-edhpreprd-004/subnets/sn-ads-eus2-analytics-edhpreprd-pep-001"
}
# storage environment
variable "environment" {
  type        = string
  description = "The environment to be built"
  #default = "dev"
}

# azure region
variable "location" {
  type        = string
  description = "Azure region where resources will be created"
  #default = "eastus2"
}

variable "storage_rg" {
  type        = string
  description = "Resource group name of Storage_account"
  #default = "rg-ads-eus2-dstkpreprd-dev-001"
}
variable "account-tier" {
  type        = string
  description = "The account tier"
  #default = "Standard"
}
variable "replication-type" {
  type        = string
  description = "The replication type"
  #default = "ZRS"
}
variable "storage-kind" {
  type        = string
  description = "The storage kind"
  #default = "StorageV2"
}
variable "storage-tls" {
  type        = string
  description = "The storage tls"
  #default = "TLS1_2"
}
# Map of storage sub-resource type -> private endpoint name.
# Keys must be valid storage sub-resources: blob, dfs, file, queue, table.
variable "private_endpoints" {
  type        = map(string)
  description = "Map of storage sub-resource type to its private endpoint name"
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

