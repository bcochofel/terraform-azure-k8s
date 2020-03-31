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

# aks default node pool
variable "default_node_pool" {
  type = object({
    name       = string
    node_count = number
    vm_size    = string
  })
  default = {
    name       = "default_pool"
    node_count = 3
    vm_size    = "Standard_D1_v2"
  }
}

# azure dev spaces
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
