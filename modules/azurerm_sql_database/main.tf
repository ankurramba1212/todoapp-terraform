# data "azurerm_mssql_server" "dbserver" {
#   for_each            = var.child_sql_database
#   name                = each.value.sql_server_name
#   resource_group_name = each.value.resource_group_name
# }

# resource "azurerm_mssql_database" "sql_database" {
#   for_each     = var.child_sql_database
#   name         = each.value.sql_database_name
#   server_id    = data.azurerm_mssql_server.dbserver[each.key].id
#   collation    = "SQL_Latin1_General_CP1_CI_AS"
#   license_type = "LicenseIncluded"
#   max_size_gb  = 2
#   sku_name     = "S0"
#   enclave_type = "VBS"

#   # prevent the possibility of accidental data loss
#   # lifecycle {
#   #   prevent_destroy = true
#   # }
# }
