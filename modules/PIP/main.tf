

resource "azurerm_public_ip" "pip" {
  for_each = var.pip_name
  name                = each.value.pip_name
  resource_group_name = each.value.pip_resource_group_name
  location            = each.value.pip_location
  allocation_method   = each.value.pip_allocation_method
  sku = each.value.pip_sku

  tags = {
    environment = "Production"
  }
}