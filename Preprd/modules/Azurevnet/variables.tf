variable "location" {
  type        = string
  description = "Azure region"
}

variable "rgvnet" {
  type        = string
  description = "Resource group for the virtual network"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "address_space_vnet1" {
  type        = list(string)
  description = "Address space for the virtual network, e.g. [\"10.40.48.0/20\"]"
}

# Map of subnets. Each key is a logical name; each value describes that subnet.
# The object type constraint documents exactly what each entry must contain.
variable "subnets" {
  type = map(object({
    name                              = string
    address_prefixes                  = list(string)
    private_endpoint_network_policies = string
  }))
  description = "Subnets to create in the VNet, keyed by logical name"
}