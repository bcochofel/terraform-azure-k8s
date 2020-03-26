provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = var.storage_account_name
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
    access_key           = var.storage_access_key
  }
}
