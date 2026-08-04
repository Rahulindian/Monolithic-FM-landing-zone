resource_group_name = {
  rg1 = {
    rg_name     = "rg-20072026"
    rg_location = "southafricanorth"
  }

  rg2 = {
    rg_name     = "rg-200720262"
    rg_location = "southafricanorth"
  }
  rg4 = {
    rg_name     = "rg-200720264"
    rg_location = "southafricanorth"
  }
}

vnet_name = {
  vnet1 = {
    vnet_name                = "vnet1"
    vnet_location            = "southafricanorth"
    vnet_resource_group_name = "rg-20072026"
    vnet_address_space       = ["10.0.0.0/16"]
  }

  vnet2 = {
    vnet_name                = "vnet2"
    vnet_location            = "southafricanorth"
    vnet_resource_group_name = "rg-200720262"
    vnet_address_space       = ["192.168.0.0/16"]
  }
}

subnet_name = {
  subnet1 = {
    subnet_name                 = "subnet1"
    subnet_resource_group_name  = "rg-20072026"
    subnet_virtual_network_name = "vnet1"
    subnet_address_prefixes     = ["10.0.1.0/24"]
  }

  subnet2 = {
    subnet_name                 = "subnet1"
    subnet_resource_group_name  = "rg-200720262"
    subnet_virtual_network_name = "vnet2"
    subnet_address_prefixes     = ["192.168.1.0/24"]
  }
}

pip_name = {
  pip1 = {
    pip_name                = "myfirstpip"
    pip_resource_group_name = "rg-20072026"
    pip_location            = "southafricanorth"
    pip_allocation_method   = "Static"
    pip_sku                 = "Standard"
  }

  pip2 = {
    pip_name                = "mysecondpip"
    pip_resource_group_name = "rg-200720262"
    pip_location            = "southafricanorth"
    pip_allocation_method   = "Static"
    pip_sku                 = "Standard"
  }
}

vms = {
  vm1 = {
    nic_name                = "nic1"
    nic_location            = "southafricanorth"
    nic_resource_group_name = "rg-20072026"
    nic_subnet_name         = "subnet1"
    nic_vnet_name           = "vnet1"
    nic_public_ip_name      = "myfirstpip"

    vm_name           = "vm1"
    vm_size           = "Standard_D2s_v3"
    vm_admin_username = "Rahulvm1"
    vm_admin_password = "Rahul@12345linux"
  }

  vm2 = {
    nic_name                = "nic2"
    nic_location            = "southafricanorth"
    nic_resource_group_name = "rg-200720262"
    nic_subnet_name         = "subnet1"
    nic_vnet_name           = "vnet2"
    nic_public_ip_name      = "mysecondpip"

    vm_name           = "vm2"
    vm_size           = "Standard_D2s_v3"
    vm_admin_username = "Rahulvm2"
    vm_admin_password = "Rahul@12345linux"
  }
}