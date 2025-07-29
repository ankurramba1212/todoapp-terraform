data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  for_each                    = var.child_kv
  name                        = each.value.key_vault_name
  resource_group_name         = each.value.resource_group_name
  location                    = each.value.location
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Set", "Delete", "List", "Recover", "Purge"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
