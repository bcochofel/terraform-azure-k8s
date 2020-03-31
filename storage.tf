# create storage account
resource "azurerm_storage_account" "thanos" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

# generate thanos config
data "template_file" "thanos" {
  template = "${file("templates/thanos-config.yaml.tpl")}"
  vars = {
    storage_name     = azurerm_storage_account.thanos.name
    storage_key      = azurerm_storage_account.thanos.primary_access_key
    storage_endpoint = "blob.core.windows.net"
    container_name   = var.storage_container_name
  }
}
