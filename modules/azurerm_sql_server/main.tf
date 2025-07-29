# data "azurerm_key_vault" "kv_data" {
#   for_each     = var.child_sql_server
#   name         = each.value.key_vault_name
#   resource_group_name = each.value.resource_group_name
# }

# data "azurerm_key_vault_secret" "username" {
#   for_each     = var.child_sql_server
#   name         = each.value.secret_username
#   key_vault_id = data.azurerm_key_vault.kv_data[each.key].id
# }

# data "azurerm_key_vault_secret" "password" {
#   for_each     = var.child_sql_server
#   name         = each.value.secret_password
#   key_vault_id = data.azurerm_key_vault.kv_data[each.key].id
# }



# resource "azurerm_mssql_server" "sqlserver" {
#   for_each                     = var.child_sql_server
#   name                         = each.value.sql_server_name
#   resource_group_name          = each.value.resource_group_name
#   location                     = each.value.location
#   version                      = "12.0"
#   administrator_login          = data.azurerm_key_vault_secret.username[each.key].value
#   administrator_login_password = data.azurerm_key_vault_secret.password[each.key].value
#   # minimum_tls_version          = "1.2"


# }