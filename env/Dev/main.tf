module "rg" {
  source   = "../../Modules/azurerm_resource_group"
  child_rg = var.parent_rg

}
module "vnet" {
  depends_on = [ module.rg ]
  source     = "../../Modules/azurerm_virtual_network"
  child_vnet = var.parent_vnet

}
module "subnet" {
  depends_on = [ module.vnet ]
  source       = "../../Modules/azurerm_subnet"
  child_subnet = var.parent_subnet

}
module "pip" {
  depends_on = [ module.subnet ]
  source    = "../../Modules/azurerm_public_ip_address"
  child_pip = var.parent_pip

}
output "public_ip_addresses" {
  value       = module.pip.public_ip_addresses
  description = "Outputs the public IP addresses created by the pip module"
}

module "kv" {
  depends_on = [ module.pip ]
  source     = "../../Modules/azurerm_key_vault"
  child_kv  = var.parent_kv

}
module "kv_secrets" {
  depends_on = [ module.kv ]
  source     = "../../Modules/azurerm_key_vault_secrets"
  child_kv_secrets = var.parent_kv_secrets

}
module "nic" {
  depends_on = [ module.subnet, module.pip ]
  source     = "../../Modules/azurrm_nic"
  child_nic = var.parent_nic

}
module "vm" {
  depends_on = [ module.nic, module.kv_secrets, module.kv ]
  source     = "../../Modules/azurerm_virtual_machine"
  child_vm   = var.parent_vm

}
module "nsg" {
  depends_on = [ module.nic ]
  source     = "../../Modules/azurerm_nsg"
  child_nsg = var.parent_nsg

}
module "nsg_association" {
  depends_on = [ module.nic , module.vm ]
  source     = "../../Modules/azurerm_nsg_nic_assc"
  child_nsg_association = var.parent_nsg_association
}
# module "sql_server" {
#   depends_on = [ module.kv_secrets, module.kv, module.vm ]
#   source     = "../../Modules/azurerm_sql_server"
#   child_sql_server = var.parent_sql_server
# }

# module "sql_database" {
#   depends_on = [ module.vm , module.sql_server ]
#   source     = "../../Modules/azurerm_SQL_database"
#   child_sql_database = var.parent_sql_database
  
# }