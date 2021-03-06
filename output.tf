output "client_key" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
}

output "cluster_username" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.username
}

output "cluster_password" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.password
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "host" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "storage_account_name" {
  value = azurerm_storage_account.thanos.name
}

output "storage_account_key" {
  value = azurerm_storage_account.thanos.primary_access_key
}

output "storage_endpoint" {
  value = azurerm_storage_account.thanos.primary_blob_host
}

output "thanos_storage_config" {
  value = data.template_file.thanos.rendered
}
