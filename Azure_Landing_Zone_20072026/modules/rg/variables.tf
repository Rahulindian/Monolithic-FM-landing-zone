variable "resource_group_name" {
  type = map(object({
    rg_name     = string
    rg_location = string
  }))
  description = "Map of resource groups to create"
}
