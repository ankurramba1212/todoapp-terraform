parent_rg = {
  "rg1" = {
    resource_group_name = "TODOAPP-AE-RG"
    location            = "Australia East"
  }
}
parent_vnet = {
  "vnet1" = {
    vnet_name           = "TODOAPP-AE-VNET"
    address_space       = ["10.0.0.0/16"]
    location            = "Australia East"
    resource_group_name = "TODOAPP-AE-RG"

  }
}
parent_subnet = {
  "Frontend_Subnet" = {
    subnet_name         = "TODOAPP-AE-FRONTEND-SUBNET"
    resource_group_name = "TODOAPP-AE-RG"
    vnet_name           = "TODOAPP-AE-VNET"
    address_prefixes    = ["10.0.1.0/24"]
  }
  # "Backend_Subnet" = {
  #   subnet_name         = "TODOAPP-AE-BACKEND-SUBNET"
  #   resource_group_name = "TODOAPP-AE-RG"
  #   vnet_name           = "TODOAPP-AE-VNET"
  #   address_prefixes    = ["10.0.2.0/24"]
  # }
}
parent_pip = {
  "frontend_pip" = {
    pip_name            = "TODOAPP-AE-FRONTEND-PIP"
    resource_group_name = "TODOAPP-AE-RG"
    location            = "Australia East"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
  # "backend_pip" = {
  #   pip_name            = "TODOAPP-AE-BACKEND-PIP"
  #   resource_group_name = "TODOAPP-AE-RG"
  #   location            = "Australia East"
  #   allocation_method   = "Static"
  #   sku                 = "Standard"
  # }
}

parent_kv = {
  "kv1" = {
    key_vault_name      = "TODOAPP-AE-KV"
    resource_group_name = "TODOAPP-AE-RG"
    location            = "Australia East"
  }
}

parent_kv_secrets = {
  "username" = {
    key_vault_name      = "TODOAPP-AE-KV"
    secret_name         = "username"
    secret_value        = "adminuser"
    resource_group_name = "TODOAPP-AE-RG"

  }
  "password" = {
    key_vault_name      = "TODOAPP-AE-KV"
    secret_name         = "password"
    secret_value        = "Ankur@121212"
    resource_group_name = "TODOAPP-AE-RG"
  }
}


parent_nic = {
  "frontend_nic" = {
    nic_name              = "TODOAPP-AE-FRONTEND-NIC"
    location              = "Australia East"
    resource_group_name   = "TODOAPP-AE-RG"
    ip_configuration_name = "ipconfig1"
    subnet_name           = "TODOAPP-AE-FRONTEND-SUBNET"
    vnet_name             = "TODOAPP-AE-VNET"
    pip_name              = "TODOAPP-AE-FRONTEND-PIP"
  }
  # "backend_nic" = {
  #   nic_name              = "TODOAPP-AE-BACKEND-NIC"
  #   location              = "Australia East"
  #   resource_group_name   = "TODOAPP-AE-RG"
  #   ip_configuration_name = "ipconfig2"
  #   subnet_name           = "TODOAPP-AE-BACKEND-SUBNET"
  #   vnet_name             = "TODOAPP-AE-VNET"
  #   pip_name              = "TODOAPP-AE-BACKEND-PIP"
  # }
}

parent_vm = {
  "frontend_vm" = {
    vm_name             = "TODOAPP-AE-FRONTEND-VM"
    resource_group_name = "TODOAPP-AE-RG"
    location            = "Australia East"
    size                = "Standard_D2s_v3"
    nic_name            = "TODOAPP-AE-FRONTEND-NIC"
    key_vault_name      = "TODOAPP-AE-KV"
    secret_username     = "username"
    secret_password     = "password"
    vm_publisher        = "Canonical"
    vm_offer            = "0001-com-ubuntu-server-jammy"
    vm_sku              = "22_04-lts-gen2"
    vm_version          = "latest"
    
    custom_data_script  = <<EOT
#!/bin/bash
sudo apt update
sudo apt install nginx -y
systemctl status nginx
git clone https://github.com/devopsinsiders/ReactTodoUIMonolith.git
cd ReactTodoUIMonolith/
curl -s https://deb.nodesource.com/setup_16.x | sudo bash
sudo apt install nodejs -y
sudo npm install
sudo npm run build
sudo cp -r build/* /var/www/html
EOT

  }
  # "backend_vm" = {
  #   vm_name             = "TODOAPP-AE-BACKEND-VM"
  #   resource_group_name = "TODOAPP-AE-RG"
  #   location            = "Australia East"
  #   size                = "Standard_B1s"
  #   key_vault_name      = "TODOAPP-AE-KV"
  #   secret_username     = "username"
  #   secret_password     = "password"
  #   nic_name            = "TODOAPP-AE-BACKEND-NIC"
  #   vm_publisher        = "Canonical"
  #   vm_offer            = "0001-com-ubuntu-server-focal"
  #   vm_sku              = "20_04-lts"
  #   vm_version          = "latest"

  # }
}

parent_nsg = {
  "frontend_nsg" = {
    nsg_name            = "TODOAPP-AE-FRONTEND-NSG"
    location            = "Australia East"
    resource_group_name = "TODOAPP-AE-RG"
    security_rule = {
      "allow_ssh" = {
        name                   = "Allow_SSH"
        destination_port_range = "22"
      }
      "allow_http" = {
        name                   = "Allow_HTTP"
        destination_port_range = "80"
      }
    }
  }
  # "backend_nsg" = {
  #   nsg_name            = "TODOAPP-AE-BACKEND-NSG"
  #   location            = "Australia East"
  #   resource_group_name = "TODOAPP-AE-RG"
  #   security_rule = {
  #     "allow_ssh" = {
  #       name                   = "Allow_SSH"
  #       destination_port_range = "22"
  #     }
  #     "allow_http" = {
  #       name                   = "Allow_HTTP"
  #       destination_port_range = "80"
  #     }
  #   }
  # }
}
parent_nsg_association = {
  "frontend_nsg_association" = {
    nic_name            = "TODOAPP-AE-FRONTEND-NIC"
    nsg_name            = "TODOAPP-AE-FRONTEND-NSG"
    resource_group_name = "TODOAPP-AE-RG"
  }
  # "backend_nsg_association" = {
  #   nic_name            = "TODOAPP-AE-BACKEND-NIC"
  #   nsg_name            = "TODOAPP-AE-BACKEND-NSG"
  #   resource_group_name = "TODOAPP-AE-RG"
  # }
}

# parent_sql_server = {
#   "sql_server" = {
#     sql_server_name     = "sqlserver-todoapp-ae"
#     resource_group_name = "TODOAPP-AE-RG"
#     location            = "Australia East"
#     key_vault_name      = "TODOAPP-AE-KV"
#     secret_username     = "username"
#     secret_password     = "password"
#   }
# }

# parent_sql_database = {
#   "sql_database" = {
#     sql_database_name   = "TODOAPP-AE-SQLDB"
#     sql_server_name     = "sqlserver-todoapp-ae"
#     resource_group_name = "TODOAPP-AE-RG"
#   }
# }