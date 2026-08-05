variable "resource_group_name" {
  type = map(object({
    rg_name     = string
    rg_location = string
  }))
}

variable "vnet_config" {
  type = map(object({
    vnet_name           = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
  }))
}

variable "subnets_config" {
  type = map(object({
    subnet_name          = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}

variable "nsg_config" {
  type = map(object({
    nsg_name            = string
    resource_group_name = string
    location            = string
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "pip_config" {
  type = map(object({
    pip_name            = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    sku                 = optional(string, "Standard")
  }))
}

variable "bastion_config" {
  type = map(object({
    bastion_name = string
    rg_key       = string
    subnet_key   = string
    pip_key      = string
    sku          = optional(string, "Standard")
  }))
}

variable "app_gateway_config" {
  type = map(object({
    app_gw_name          = string
    rg_key               = string
    sku_name             = string
    sku_tier             = string
    capacity             = number
    subnet_key           = string
    pip_key              = string
    backend_ip_addresses = list(string)
  }))
}

variable "lb_config" {
  type = map(object({
    lb_name          = string
    rg_key           = string
    sku              = optional(string, "Standard")
    subnet_key       = optional(string)
    pip_key          = optional(string)
    frontend_ip_name = optional(string, "LoadBalancerFrontend")
  }))
}

variable "vm_config" {
  type = map(object({
    vm_name        = string
    rg_key         = string
    size           = string
    admin_username = string
    admin_password = string
    subnet_key     = string
    lb_key         = optional(string)
  }))
}
