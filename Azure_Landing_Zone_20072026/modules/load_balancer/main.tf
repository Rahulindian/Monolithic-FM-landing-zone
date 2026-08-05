resource "azurerm_lb" "lb" {
  for_each            = var.lb_config
  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_name
    subnet_id            = each.value.subnet_id
    public_ip_address_id = each.value.public_ip_address_id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each        = var.lb_config
  name            = "${each.value.lb_name}-backend-pool"
  loadbalancer_id = azurerm_lb.lb[each.key].id
}

resource "azurerm_lb_probe" "probe" {
  for_each        = var.lb_config
  name            = "${each.value.lb_name}-hp"
  loadbalancer_id = azurerm_lb.lb[each.key].id
  port            = 80
  protocol        = "Tcp"
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = var.lb_config
  name                           = "${each.value.lb_name}-rule"
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = each.value.frontend_ip_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.probe[each.key].id
}
