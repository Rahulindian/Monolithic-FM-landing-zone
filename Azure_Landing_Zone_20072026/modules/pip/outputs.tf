output "pips" {
  description = "Outputs of created Public IPs"
  value = {
    for k, v in azurerm_public_ip.pip : k => {
      id         = v.id
      name       = v.name
      ip_address = v.ip_address
    }
  }
}
