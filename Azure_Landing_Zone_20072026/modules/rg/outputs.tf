output "resource_groups" {
  description = "Outputs of all created resource groups"
  value = {
    for k, v in azurerm_resource_group.rg : k => {
      id       = v.id
      name     = v.name
      location = v.location
    }
  }
}
