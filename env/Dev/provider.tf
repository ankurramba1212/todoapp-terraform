terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
     key_vault {
      purge_soft_delete_on_destroy    = true
    }
  }
  subscription_id =  "193a80b5-b916-4c17-b06d-cfc310d07a2c"
}
