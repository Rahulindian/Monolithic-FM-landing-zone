variable "app_gateway_config" {
  type = map(object({
    app_gw_name          = string
    resource_group_name  = string
    location             = string
    sku_name             = string
    sku_tier             = string
    capacity             = number
    subnet_id            = string
    public_ip_address_id = string
    backend_ip_addresses = list(string)
  }))
  description = "Map of Application Gateways to create"
}
