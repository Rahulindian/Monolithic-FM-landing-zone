
resource "azurerm_resource_group" "rg" {
    for_each = var.resource_group_name
    name = each.value.rg_name
    location = each.value.rg_location
}