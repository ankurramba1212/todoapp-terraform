
resource "azurerm_network_security_group" "nsg" {
    for_each = var.child_nsg
    name                = each.value.nsg_name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name

   dynamic "security_rule" {
    for_each = each.value.security_rule

    content {
      name                       = security_rule.value.name
      priority                   = 100 + index(keys(each.value.security_rule), security_rule.key)
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

 
}