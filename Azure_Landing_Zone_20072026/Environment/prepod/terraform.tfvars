resource_group_name = {
  rg1 = {
    rg_name     = "rg-landing-zone-prep"
    rg_location = "southafricanorth"
  }
}

vnet_config = {
  vnet1 = {
    vnet_name           = "vnet-landing-zone-01"
    resource_group_name = "rg-landing-zone-prep"
    location            = "southafricanorth"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets_config = {
  bastion_sub = {
    subnet_name          = "AzureBastionSubnet"
    resource_group_name  = "rg-landing-zone-prep"
    virtual_network_name = "vnet-landing-zone-01"
    address_prefixes     = ["10.0.1.0/26"]
  }
  appgw_sub = {
    subnet_name          = "AppGatewaySubnet"
    resource_group_name  = "rg-landing-zone-prep"
    virtual_network_name = "vnet-landing-zone-01"
    address_prefixes     = ["10.0.2.0/24"]
  }
  lb_sub = {
    subnet_name          = "LBSubnet"
    resource_group_name  = "rg-landing-zone-prep"
    virtual_network_name = "vnet-landing-zone-01"
    address_prefixes     = ["10.0.3.0/24"]
  }
  backend_sub = {
    subnet_name          = "BackendSubnet"
    resource_group_name  = "rg-landing-zone-prep"
    virtual_network_name = "vnet-landing-zone-01"
    address_prefixes     = ["10.0.4.0/24"]
  }
}

nsg_config = {
  nsg_appgw = {
    nsg_name            = "nsg-appgw"
    resource_group_name = "rg-landing-zone-prep"
    location            = "southafricanorth"
    security_rules = [
      {
        name                       = "Allow_HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow_GatewayManager"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "65200-65535"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      }
    ]
  }
}

pip_config = {
  bastion_pip = {
    pip_name            = "pip-bastion-01"
    resource_group_name = "rg-landing-zone-prep"
    location            = "southafricanorth"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
  appgw_pip = {
    pip_name            = "pip-appgw-01"
    resource_group_name = "rg-landing-zone-prep"
    location            = "southafricanorth"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

bastion_config = {
  bastion1 = {
    bastion_name = "bastion-host-01"
    rg_key       = "rg1"
    subnet_key   = "bastion_sub"
    pip_key      = "bastion_pip"
    sku          = "Standard"
  }
}

app_gateway_config = {
  appgw1 = {
    app_gw_name          = "appgw-landing-zone"
    rg_key               = "rg1"
    sku_name             = "Standard_v2"
    sku_tier             = "Standard_v2"
    capacity             = 2
    subnet_key           = "appgw_sub"
    pip_key              = "appgw_pip"
    backend_ip_addresses = ["10.0.4.4", "10.0.4.5"]
  }
}

lb_config = {
  lb1 = {
    lb_name          = "ilb-backend"
    rg_key           = "rg1"
    sku              = "Standard"
    subnet_key       = "lb_sub"
    frontend_ip_name = "InternalLBFrontend"
  }
}

vm_config = {
  vm1 = {
    vm_name        = "vm-backend-01"
    rg_key         = "rg1"
    size           = "Standard_B2s"
    admin_username = "azureuser"
    admin_password = "P@ssw0rd12345!"
    subnet_key     = "backend_sub"
    lb_key         = "lb1"
  }
  vm2 = {
    vm_name        = "vm-backend-02"
    rg_key         = "rg1"
    size           = "Standard_B2s"
    admin_username = "azureuser"
    admin_password = "P@ssw0rd12345!"
    subnet_key     = "backend_sub"
    lb_key         = "lb1"
  }
}
