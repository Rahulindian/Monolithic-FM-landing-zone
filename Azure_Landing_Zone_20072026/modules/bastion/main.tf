resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion_config
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = each.value.subnet_id
    public_ip_address_id = each.value.public_ip_address_id
  }
}
