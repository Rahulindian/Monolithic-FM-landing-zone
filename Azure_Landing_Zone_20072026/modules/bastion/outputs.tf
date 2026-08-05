output "bastion_hosts" {
  description = "Outputs of created Bastion hosts"
  value = {
    for k, v in azurerm_bastion_host.bastion : k => {
      id   = v.id
      name = v.name
      dns  = v.dns_name
    }
  }
}
