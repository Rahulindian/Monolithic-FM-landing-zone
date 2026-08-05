variable "pip_config" {
  type = map(object({
    pip_name            = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    sku                 = optional(string, "Standard")
  }))
  description = "Map of Public IPs to create"
}
