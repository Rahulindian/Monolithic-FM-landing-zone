module "resource_group" {

  source = "../../modules/rg"

  resource_group_name = var.resource_group_name

}

module "vnet" {

  depends_on = [
    module.resource_group
  ]

  source = "../../modules/vnet"

  vnet_name = var.vnet_name

}

module "subnet" {

  depends_on = [
    module.vnet
  ]

  source = "../../modules/subnet"

  subnet_name = var.subnet_name

}

module "pip" {

  depends_on = [
    module.resource_group
  ]

  source = "../../modules/pip"

  pip_name = var.pip_name

}

module "virtual_machine" {

  depends_on = [
    module.subnet,
    module.pip
  ]

  source = "../../modules/vm"

  vms = var.vms

}