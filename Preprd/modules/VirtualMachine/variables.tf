variable "virtual_machines" {
  type = map(object({
    name           = string
    nic_name       = string
    ip_config_name = string
    computer_name  = string
    admin_username = string
    os_disk_name   = string
    data_disk_name = string
  }))
  description = "Map of VM definitions, keyed by logical name"
}

variable "keyvault_name" {
  type        = string
  description = "Name of the Key Vault holding the VM admin password"
}

variable "keyvault_rg" {
  type        = string
  description = "Resource group of the Key Vault"
}

variable "vm_admin_secret_name" {
  type        = string
  description = "Name of the Key Vault secret holding the VM admin password"
}

variable "vmnicsub_id" {
  type        = string
  description = "Subnet ID for the VM NICs (from the VNet module output)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "rgvm" {
  type        = string
  description = "Resource group for the VMs"
}

variable "vm_size" {
  type        = string
  description = "VM size"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "Private IP allocation method (e.g. Dynamic)"
}
variable "publisher" {
  type        = string
  description = "Image publisher"
}

variable "offer" {
  type        = string
  description = "Image offer"
}

variable "sku" {
  type        = string
  description = "Image SKU"
}

variable "version1" {
  type        = string
  description = "Image version"
}

variable "caching" {
  type        = string
  description = "OS disk caching"
}

variable "managed_disk_type" {
  type        = string
  description = "OS disk storage account type"
}

variable "storage_account_type" {
  type        = string
  description = "Data disk storage account type"
}

variable "AppId" {
  type        = string
  description = "Governance tag: app id"
}

variable "environment" {
  type        = string
  description = "Governance tag: environment"
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