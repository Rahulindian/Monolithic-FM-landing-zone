variable "vm_config" {
  type = map(object({
    vm_name             = string
    resource_group_name = string
    location            = string
    size                = string
    admin_username      = string
    admin_password      = string
    subnet_id           = string
    lb_backend_pool_id  = optional(string)
  }))
  description = "Map of Virtual Machines to create"
}
