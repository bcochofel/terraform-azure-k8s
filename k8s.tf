resource "azurerm_resource_group" "k8s" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_id" "salt" {
  byte_length = 4
}

resource "azurerm_log_analytics_workspace" "test" {
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
  name                = "${var.log_analytics_workspace_name}-${random_id.salt.dec}"
  location            = var.log_analytics_workspace_location
  resource_group_name = azurerm_resource_group.k8s.name
  sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "test" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.test.location
  resource_group_name   = azurerm_resource_group.k8s.name
  workspace_resource_id = azurerm_log_analytics_workspace.test.id
  workspace_name        = azurerm_log_analytics_workspace.test.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  dns_prefix          = var.dns_prefix

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name       = "agentpool"
    node_count = var.agent_count
    vm_size    = "Standard_DS1_v2"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
    }
  }

  tags = {
    Environment = "Development"
  }
}

resource "azurerm_devspace_controller" "k8s" {
  name                = "${var.devspace_name}-${random_id.salt.dec}"
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name

  sku_name = "S1"

  target_container_host_resource_id        = azurerm_kubernetes_cluster.k8s.id
  target_container_host_credentials_base64 = base64encode(azurerm_kubernetes_cluster.k8s.kube_config_raw)

  tags = {
    Environment = "Testing"
  }
}
