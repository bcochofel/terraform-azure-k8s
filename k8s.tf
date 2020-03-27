resource "azurerm_resource_group" "k8s" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_id" "salt" {
  byte_length = 4
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "agentpool"
    node_count = var.agent_count
    vm_size    = "Standard_DS1_v2"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    environment = "lab"
  }
}

resource "azurerm_devspace_controller" "k8s" {
  count = var.enable_devspace ? 1 : 0

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
