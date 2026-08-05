variable "lb_config" {
  type = map(object({
    lb_name              = string
    resource_group_name  = string
    location             = string
    sku                  = optional(string, "Standard")
    subnet_id            = optional(string)
    public_ip_address_id = optional(string)
    frontend_ip_name     = optional(string, "LoadBalancerFrontend")
  }))
  description = "Map of Azure Load Balancers to create"
}
