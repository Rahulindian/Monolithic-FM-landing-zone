resource "azurerm_network_interface" "nic" {
  for_each            = var.vm_config
  name                = "${each.value.vm_name}-nic"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_assoc" {
  for_each                = { for k, v in var.vm_config : k => v if v.lb_backend_pool_id != null }
  network_interface_id    = azurerm_network_interface.nic[each.key].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = each.value.lb_backend_pool_id
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vm_config
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
