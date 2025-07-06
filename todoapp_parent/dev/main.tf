

#sggsgsgsgsgsgsgsgs

module "resource_group" {
  source   = "../../modules/azurerm_resource_group"
  rg_child = var.rg_parent

}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_virtual_network"
  vnet_child = var.vnet_parent

}

module "subnet" {
  depends_on   = [module.virtual_network]
  source       = "../../modules/azurerm_subnet"
  subnet_child = var.subnet_parent

}

module "public_ip" {
  depends_on = [module.subnet]
  source     = "../../modules/azurerm_pip"
  pip_child  = var.pip_parent
}

module "key_vault" {
  depends_on     = [module.resource_group]
  source         = "../../modules/azurerm_key_vault"
  keyvault_child = var.keyvault_parent
}


# module "vm-username" {
#   depends_on          = [module.key_vault]
#   source              = "../../modules/azurerm_key_vault_secrets"
#   secret_name         = "vm-username"
#   secret_value        = "adminuser"
#   key_vault_name      = "kv-todoapp-ankur"
#   resource_group_name = "todoappankur"

# }

# module "vm-password" {
#   depends_on          = [module.key_vault]
#   source              = "../../modules/azurerm_key_vault_secrets"
#   secret_name         = "vm-password"
#   secret_value        = "Ankur@121212"
#   key_vault_name      = "kv-todoapp-ankur"
#   resource_group_name = "todoappankur"

# }

module "secrets" {
  depends_on           = [module.key_vault]
  source               = "../../modules/azurerm_key_vault_secrets"
  keyvaultsecret_child = var.keyvaultsecret_parent
  key_vault_name       = "TODOAPP-AE-KV"
  resource_group_name  = "TODOAPP-AE-RG"
}

# module "vm" { 
#   depends_on            = [module.subnet, module.public_ip, module.secrets, module.key_vault]
#   source                = "../../modules/azurerm_virtual_machine"
#   vm_child              = var.vm_parent
# }

module "frontend_vm" {
  depends_on = [module.subnet, module.public_ip, module.secrets, module.key_vault]
  source     = "../../modules/azurerm_virtual_machine"

  nic_name             = "TODOAPP-AE-NIC-FRONTEND"
  location             = "Australia East"
  resource_group_name  = "TODOAPP-AE-RG"
  ipconfig_name        = "TODOAPP-AE-IPCONFIG-FRONTEND"
  vm_name              = "TODOAPP-AE-VM-FRONTEND"
  vm_size              = "Standard_D2s_v3"
  vm_image_publisher   = "Canonical"
  vm_image_offer       = "0001-com-ubuntu-server-jammy"
  vm_image_sku         = "22_04-lts"
  vm_image_version     = "latest"
  public_ip            = "TODOAPP-AE-PIP-FRONTEND"
  subnet_name          = "TODOAPP-AE-SUBNET-FRONTEND"
  virtual_network_name = "TODOAPP-AE-VNET"
  key_vault_name       = "TODOAPP-AE-KV"
  secret_username      = "vm-username"
  secret_password      = "vm-password"

}



module "backend_vm" {
  depends_on = [module.subnet, module.public_ip, module.secrets, module.key_vault]
  source     = "../../modules/azurerm_virtual_machine"

  nic_name             = "TODOAPP-AE-NIC-BACKEND"
  location             = "Australia East"
  resource_group_name  = "TODOAPP-AE-RG"
  ipconfig_name        = "TODOAPP-AE-IPCONFIG-BACKEND"
  vm_name              = "TODOAPP-AE-VM-BACKEND"
  vm_size              = "Standard_D2s_v3"
  vm_image_publisher   = "Canonical"
  vm_image_offer       = "0001-com-ubuntu-server-focal"
  vm_image_sku         = "20_04-lts"
  vm_image_version     = "latest"
  public_ip            = "TODOAPP-AE-PIP-BACKEND"
  subnet_name          = "TODOAPP-AE-SUBNET-BACKEND"
  virtual_network_name = "TODOAPP-AE-VNET"
  key_vault_name       = "TODOAPP-AE-KV"
  secret_username      = "vm-username"
  secret_password      = "vm-password"

}

module "sql_server" {
  depends_on          = [module.resource_group, module.secrets, module.key_vault]
  source              = "../../modules/azurerm_sql_server"
  sql_server_name     = "todoapp-ae-sqlserver"
  resource_group_name = "TODOAPP-AE-RG"
  location            = "Australia East"
  key_vault_name      = "TODOAPP-AE-KV"
  secret_username     = "vm-username"
  secret_password     = "vm-password"

}
module "sql_serve3r" {
  depends_on          = [module.resource_group, module.secrets, module.key_vault]
  source              = "../../modules/azurerm_sql_server"
  sql_server_name     = "todoapp-3ae-sqlserver"
  resource_group_name = "TODOAP3P-AE-RG"
  location            = "Austr3alia East"
  key_vault_name      = "TODOAPP-AE-KV"
  secret_username     = "vm-username"
  secret_password     = "vm-password"
}
module "sql_serve1r" {
  depends_on          = [module.resource_group, module.secrets, module.key_vault]
  source              = "../../modules/azurerm_sql_server"
  sql_server_name     = "todoapp-ae-sqlserver"
  resource_group_name = "TODOA1PP-AE-RG"
  location            = "Austra1lia East"
  key_vault_name      = "TODOAPP-AE-KV"
  secret_username     = "vm-username"
  secret_password     = "vm-password"

}

module "sql_database" {
  depends_on          = [module.sql_server]
  source              = "../../modules/azurerm_sql_database"
  sql_database_name   = "TodoApp-AE-SqlDatabase"
  resource_group_name = "TODOAPP-AE-RG"
  sql_server_name     = "todoapp-ae-sqlserver"

}


