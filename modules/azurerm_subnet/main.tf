

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet_child
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefixes

}
