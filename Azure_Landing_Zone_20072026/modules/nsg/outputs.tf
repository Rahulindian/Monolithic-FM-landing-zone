output "nsgs" {
  description = "Outputs of created NSGs"
  value = {
    for k, v in azurerm_network_security_group.nsg : k => {
      id                  = v.id
      name                = v.name
      resource_group_name = v.resource_group_name
    }
  }
}
