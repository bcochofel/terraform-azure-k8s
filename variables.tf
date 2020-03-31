variable "client_id" {}
variable "client_secret" {}
variable "ssh_public_key" {}

variable resource_group_name {
  type    = string
  default = "akslabrg"
}

variable location {
  type    = string
  default = "West Europe"
}

variable "aks_vnet_name" {
  type    = string
  default = "aksvnet"
}

variable cluster_name {
  type    = string
  default = "akslab"
}

variable "dns_prefix" {
  type    = string
  default = "akslab"
}

variable "admin_username" {
  type    = string
  default = "aksadmin"
}

# specify a valid kubernetes version
variable "kubernetes_version" {
  type    = string
  default = "1.15.10"
}

# AKS agent pools
variable "agent_pools" {
  default = [
    {
      name            = "pool1"
      count           = 3
      vm_size         = "Standard_D1_v2"
      os_type         = "Linux"
      os_disk_size_gb = "30"
    }
  ]
}

variable enable_devspace {
  type    = bool
  default = false
}

variable devspace_name {
  type    = string
  default = "dsakslab"
}

variable "storage_account_name" {
  type    = string
  default = "aksthanosstorage"
}

variable "storage_container_name" {
  type    = string
  default = "aksthanosc"
}
