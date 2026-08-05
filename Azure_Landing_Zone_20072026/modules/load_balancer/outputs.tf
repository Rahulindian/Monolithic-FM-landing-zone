output "load_balancers" {
  description = "Outputs of created Load Balancers"
  value = {
    for k, v in azurerm_lb.lb : k => {
      id              = v.id
      name            = v.name
      backend_pool_id = azurerm_lb_backend_address_pool.backend_pool[k].id
    }
  }
}
