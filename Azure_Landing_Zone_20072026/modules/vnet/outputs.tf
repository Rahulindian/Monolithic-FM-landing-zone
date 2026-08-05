output "vnets" {
  description = "Outputs of created virtual networks"
  value = {
    for k, v in azurerm_virtual_network.vnet : k => {
      id                  = v.id
      name                = v.name
      resource_group_name = v.resource_group_name
      location            = v.location
      address_space       = v.address_space
    }
  }
}
