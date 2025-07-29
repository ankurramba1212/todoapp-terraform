resource "azurerm_public_ip" "pip" {
  for_each            = var.child_pip
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku

}


output "public_ip_addresses" {
  value = {
    for name, pip in azurerm_public_ip.pip : name => {
      ip_address = pip.ip_address
    }
  }

}
