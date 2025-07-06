

rg_parent = {
  "rg1" = {
    resource_group_name = "TODOAPP-AE-RG"
    location            = "Australia East"
  }
}

vnet_parent = {
  "vnet1" = {
    vnet_name           = "TODOAPP-AE-VNET"
    location            = "Australia East"
    resource_group_name = "TODOAPP-AE-RG"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet_parent = {
  "TODOAPP-AE-SUBNET-FRONTEND" = {
    subnet_name         = "TODOAPP-AE-SUBNET-FRONTEND"
    resource_group_name = "TODOAPP-AE-RG"
    vnet_name           = "TODOAPP-AE-VNET"
    address_prefixes    = ["10.0.1.0/24"]
  }

  "TODOAPP-AE-SUBNET-BACKEND" = {
    subnet_name         = "TODOAPP-AE-SUBNET-BACKEND"
    resource_group_name = "TODOAPP-AE-RG"
    vnet_name           = "TODOAPP-AE-VNET"
    address_prefixes    = ["10.0.2.0/24"]
  }

}
pip_parent = {
  "frontend_public_ip" = {
    public_ip_name      = "TODOAPP-AE-PIP-FRONTEND"
    resource_group_name = "TODOAPP-AE-RG"
    location            = "Australia East"
    allocation_method   = "Static"
    sku                 = "Basic"
  }

  "backend_public_ip" = {
    public_ip_name      = "TODOAPP-AE-PIP-BACKEND"
    resource_group_name = "TODOAPP-AE-RG"
    location            = "Australia East"
    allocation_method   = "Static"
    sku                 = "Basic"
  }
}

keyvault_parent = {
  "kv1" = {
    key_vault_name      = "TODOAPP-AE-KV"
    vault_location      = "Australia East"
    resource_group_name = "TODOAPP-AE-RG"
  }
}
keyvaultsecret_parent = {
  "vm-username" = {
    secret_name  = "vm-username"
    secret_value = "adminuser"

  }
  "vm-password" = {
    secret_name  = "vm-password"
    secret_value = "Ankur@121212"

  }

}



# vm_parent = {
#   "frontend_vm" = {
#     nic_name             = "nic-frontend-vm"
#     location             = "Australia East"
#     resource_group_name  = "TODOAPP-AE-RG"
#     ipconfig_name        = "ipconfig-frontend"

#     vm_name              = "frontend-vm"
#     vm_size              = "Standard_D2s_v3"
#     vm_image_publisher   = "Canonical"
#     vm_image_offer       = "0001-com-ubuntu-server-jammy"
#     vm_image_sku         = "22_04-lts"
#     vm_image_version     = "latest"
#   }


#   "backend_vm" = {
#     nic_name            = "nic-backend-vm"
#     location            = "Australia East"
#     resource_group_name = "TODOAPP-AE-RG"
#     ipconfig_name       = "ipconfig-backend"
#     subnet_name         = "TODOAPP-AE-SUBNET-BACKEND"
#     public_ip           = "pip-back"
#     virtual_network_name = "TODOAPP-AE-VNET
#     key_vault_name      = "kv-todoapp-ankur"
#     secret_username     = "vm-username"
#     secret_password     = "vm-password"
#     vm_name             = "backend-vm"
#     location            = "Australia East"
#     vm_size             = "Standard_D2s_v3"
#     vm_image_publisher  = "Canonical"
#     vm_image_offer      = "0001-com-ubuntu-server-focal"
#     vm_image_sku        = "20_04-lts"
#     vm_image_version    = "latest"
#   }
# }
