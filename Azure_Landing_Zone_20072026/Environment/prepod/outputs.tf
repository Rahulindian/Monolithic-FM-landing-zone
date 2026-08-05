output "resource_groups" {
  description = "Resource group details"
  value       = module.resource_group.resource_groups
}

output "vnets" {
  description = "Virtual network details"
  value       = module.vnet.vnets
}

output "subnets" {
  description = "Subnet details"
  value       = module.subnet.subnets
}

output "public_ips" {
  description = "Public IP details"
  value       = module.pip.pips
}

output "bastion_hosts" {
  description = "Bastion host details"
  value       = module.bastion.bastion_hosts
}

output "application_gateways" {
  description = "Application Gateway details"
  value       = module.app_gateway.application_gateways
}

output "load_balancers" {
  description = "Load Balancer details"
  value       = module.load_balancer.load_balancers
}

output "virtual_machines" {
  description = "Virtual Machine details"
  value       = module.vm.virtual_machines
}
