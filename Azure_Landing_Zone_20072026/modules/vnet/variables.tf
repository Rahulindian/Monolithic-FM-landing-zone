variable "vnet_config" {
  type = map(object({
    vnet_name           = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
  }))
  description = "Map of virtual networks to create"
}
