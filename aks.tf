resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_id" "salt" {
  byte_length = 4
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  dynamic "agent_pool_profile" {
    for_each = var.agent_pools
    iterator = pool
    content {
      name            = pool.value.name
      count           = pool.value.count
      vm_size         = pool.value.vm_size
      os_type         = pool.value.os_type
      os_disk_size_gb = pool.value.os_disk_size_gb
      type            = "VirtualMachineScaleSets"
      max_pods        = 5
      vnet_subnet_id  = azurerm_subnet.aks_subnet.id
    }
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "lab"
  }
}

resource "azurerm_devspace_controller" "aks" {
  count = var.enable_devspace ? 1 : 0

  name                = "${var.devspace_name}-${random_id.salt.dec}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "S1"

  target_container_host_resource_id        = azurerm_kubernetes_cluster.aks.id
  target_container_host_credentials_base64 = base64encode(azurerm_kubernetes_cluster.aks.kube_config_raw)

  tags = {
    Environment = "lab"
  }
}
