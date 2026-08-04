resource "azurerm_subnet" "subnet" {
    for_each = var.subnet_name 
    name = each.value.subnet_name
    resource_group_name = each.value.subnet_resource_group_name
    virtual_network_name = each.value.subnet_virtual_network_name
    address_prefixes = each.value.subnet_address_prefixes
    
}