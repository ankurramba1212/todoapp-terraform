data "azurerm_network_interface" "nic" {
    for_each = var.child_nsg_association
    name                = each.value.nic_name
    resource_group_name = each.value.resource_group_name
}
data "azurerm_network_security_group" "nsg" {
    for_each = var.child_nsg_association
    name                = each.value.nsg_name
    resource_group_name = each.value.resource_group_name

}


resource "azurerm_network_interface_security_group_association" "nsg_nic_association" {
  for_each                  = var.child_nsg_association
  network_interface_id      = data.azurerm_network_interface.nic[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsg[each.key].id
}
