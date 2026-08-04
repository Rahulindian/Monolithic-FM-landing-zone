resource "azurerm_network_interface" "nic" {
    for_each = var.vms
    name   = each.value.nic_name
    location = each.value.nic_location
    resource_group_name = each.value.nic_resource_group_name

  ip_configuration {

    name                          = "dhondhu"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.public_ip[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "virtual_machine" {
  for_each = var.vms
  name                = each.value.vm_name
  resource_group_name = each.value.nic_resource_group_name
  location            = each.value.nic_location
  size                = each.value.vm_size
  admin_username      = each.value.vm_admin_username
  admin_password      = each.value.vm_admin_password
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}