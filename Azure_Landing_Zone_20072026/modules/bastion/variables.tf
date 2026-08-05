variable "bastion_config" {
  type = map(object({
    bastion_name         = string
    resource_group_name  = string
    location             = string
    subnet_id            = string
    public_ip_address_id = string
    sku                  = optional(string, "Standard")
  }))
  description = "Map of Azure Bastion hosts to create"
}
