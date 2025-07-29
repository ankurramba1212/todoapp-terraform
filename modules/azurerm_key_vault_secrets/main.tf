data "azurerm_key_vault" "kv_secret_data" {
  for_each            = var.child_kv_secrets
  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name

}

resource "azurerm_key_vault_secret" "kv_secret" {
  for_each     = var.child_kv_secrets
  name         = each.value.secret_name
  value        = each.value.secret_value
  key_vault_id = data.azurerm_key_vault.kv_secret_data[each.key].id
}
