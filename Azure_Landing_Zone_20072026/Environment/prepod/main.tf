module "resource_group" {
  source              = "../../modules/rg"
  resource_group_name = var.resource_group_name
}

module "vnet" {
  source      = "../../modules/vnet"
  vnet_config = var.vnet_config

  depends_on = [module.resource_group]
}

module "subnet" {
  source         = "../../modules/subnet"
  subnets_config = var.subnets_config

  depends_on = [module.vnet]
}

module "nsg" {
  source     = "../../modules/nsg"
  nsg_config = var.nsg_config

  depends_on = [module.resource_group]
}

module "pip" {
  source     = "../../modules/pip"
  pip_config = var.pip_config

  depends_on = [module.resource_group]
}

module "bastion" {
  source = "../../modules/bastion"

  bastion_config = {
    for k, v in var.bastion_config : k => {
      bastion_name         = v.bastion_name
      resource_group_name  = var.resource_group_name[v.rg_key].rg_name
      location             = var.resource_group_name[v.rg_key].rg_location
      subnet_id            = module.subnet.subnets[v.subnet_key].id
      public_ip_address_id = module.pip.pips[v.pip_key].id
      sku                  = v.sku
    }
  }

  depends_on = [module.subnet, module.pip]
}

module "app_gateway" {
  source = "../../modules/app_gateway"

  app_gateway_config = {
    for k, v in var.app_gateway_config : k => {
      app_gw_name          = v.app_gw_name
      resource_group_name  = var.resource_group_name[v.rg_key].rg_name
      location             = var.resource_group_name[v.rg_key].rg_location
      sku_name             = v.sku_name
      sku_tier             = v.sku_tier
      capacity             = v.capacity
      subnet_id            = module.subnet.subnets[v.subnet_key].id
      public_ip_address_id = module.pip.pips[v.pip_key].id
      backend_ip_addresses = v.backend_ip_addresses
    }
  }

  depends_on = [module.subnet, module.pip]
}

module "load_balancer" {
  source = "../../modules/load_balancer"

  lb_config = {
    for k, v in var.lb_config : k => {
      lb_name              = v.lb_name
      resource_group_name  = var.resource_group_name[v.rg_key].rg_name
      location             = var.resource_group_name[v.rg_key].rg_location
      sku                  = v.sku
      subnet_id            = v.subnet_key != null ? module.subnet.subnets[v.subnet_key].id : null
      public_ip_address_id = v.pip_key != null ? module.pip.pips[v.pip_key].id : null
      frontend_ip_name     = v.frontend_ip_name
    }
  }

  depends_on = [module.subnet, module.pip]
}

module "vm" {
  source = "../../modules/vm"

  vm_config = {
    for k, v in var.vm_config : k => {
      vm_name             = v.vm_name
      resource_group_name = var.resource_group_name[v.rg_key].rg_name
      location            = var.resource_group_name[v.rg_key].rg_location
      size                = v.size
      admin_username      = v.admin_username
      admin_password      = v.admin_password
      subnet_id           = module.subnet.subnets[v.subnet_key].id
      lb_backend_pool_id  = v.lb_key != null ? module.load_balancer.load_balancers[v.lb_key].backend_pool_id : null
    }
  }

  depends_on = [module.subnet, module.load_balancer]
}
