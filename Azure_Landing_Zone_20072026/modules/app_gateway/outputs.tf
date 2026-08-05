output "application_gateways" {
  description = "Outputs of created Application Gateways"
  value = {
    for k, v in azurerm_application_gateway.app_gw : k => {
      id   = v.id
      name = v.name
    }
  }
}
