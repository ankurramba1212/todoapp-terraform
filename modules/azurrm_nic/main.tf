data "azurerm_subnet" "subnet_data" {
  for_each             = var.child_nic
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name

}
data "azurerm_public_ip" "pip_data" {
  for_each            = var.child_nic
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.child_nic
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_configuration_name
    subnet_id                     = data.azurerm_subnet.subnet_data[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pip_data[each.key].id
  }
}
