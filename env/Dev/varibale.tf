# Structured, reusable code
# is map ke ander multiple object ho sakte hai
variable "parent_rg" {
  description = "Map of child resource groups to create"
  type        = map(object({
    resource_group_name = string
    location            = string
  }))
}
# Dynamic or unstructured input
# variable "rg_child" {
#   type = map(any)

  
# }

variable "parent_vnet" {
  description = "Map of parent virtual networks to create"
  type        = map(object({
    vnet_name           = string
    address_space       = list(string)
    location            = string
    resource_group_name = string
  }))
  
}

variable "parent_subnet" {
  description = "Map of parent subnets to create"
  type        = map(object({
    subnet_name         = string
    resource_group_name = string
    vnet_name           = string
    address_prefixes    = list(string)
  }))
  
}
variable "parent_pip" {
  description = "Map of parent public IP addresses to create"
  type        = map(object({
    pip_name            = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    sku                 = string
  }))
  
}

variable "parent_kv" {
  description = "Map of parent key vaults to create"
  type        = map(object({
    key_vault_name      = string
    resource_group_name = string
    location            = string
  }))
  
}

variable "parent_kv_secrets" {
  description = "Map of parent key vault secrets to create"
  type        = map(object({
    key_vault_name      = string
    secret_name         = string
    secret_value        = string
    resource_group_name = string
  }))
  
}

variable "parent_nic" {
  description = "Map of parent network interfaces to create"
  type        = map(object({
    nic_name                = string
    location                = string
    resource_group_name     = string
    ip_configuration_name   = string
    subnet_name             = string
    vnet_name               = string
    pip_name                = string
  }))
  
}

variable "parent_vm" {
  description = "Map of parent virtual machines to create"
  type        = map(object({
    vm_name                = string
    resource_group_name    = string
    location               = string
    size                   = string
    custom_data_script     = optional(string)
    key_vault_name         = string
    secret_username        = string
    secret_password        = string
    nic_name               = string
    vm_publisher           = string
    vm_offer               = string
    vm_sku                 = string
    vm_version             = string
  }))
  
}
variable "parent_nsg" {
  description = "Map of parent network security groups to create"
  type        = map(object({
    nsg_name            = string
    location            = string
    resource_group_name = string
    security_rule       = map(object({
      name                       = string
      destination_port_range     = string
    }))
  }))
  
}
variable "parent_nsg_association" {
  description = "Map of parent network security group associations to create"
  type        = map(object({
    nic_name            = string
    nsg_name            = string
    resource_group_name = string
  }))
  
}
# variable "parent_sql_server" {
#   description = "Map of parent SQL servers to create"
#   type        = map(object({
#     sql_server_name     = string
#     resource_group_name = string
#     location            = string
#     key_vault_name      = string
#     secret_username     = string
#     secret_password     = string
#   }))
  
# }

# variable "parent_sql_database" {
#   description = "Map of parent SQL databases to create"
#   type        = map(object({
#     sql_database_name   = string
#     sql_server_name     = string
#     resource_group_name = string
#   }))
  
# }
