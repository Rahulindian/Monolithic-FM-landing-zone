output "virtual_machines" {
  description = "Outputs of created Linux Virtual Machines"
  value = {
    for k, v in azurerm_linux_virtual_machine.vm : k => {
      id                 = v.id
      name               = v.name
      private_ip_address = azurerm_network_interface.nic[k].private_ip_address
    }
  }
}
