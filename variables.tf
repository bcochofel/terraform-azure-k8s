variable "client_id" {}
variable "client_secret" {}

variable resource_group_name {
  default = "azure-k8stest"
}

variable location {
  default = "West Europe"
}

variable cluster_name {
  default = "k8stest"
}

variable "agent_count" {
  default = 3
}

variable "dns_prefix" {
  default = "k8stest"
}

variable enable_devspace {
  type    = bool
  default = true
}

variable devspace_name {
  default = "dsk8stest"
}

variable "storage_account_name" {
  default = "thanossc"
}

variable "storage_container_name" {
  default = "thanosc"
}
