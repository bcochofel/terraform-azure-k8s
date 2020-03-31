variable "client_id" {}
variable "client_secret" {}

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

variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD3dddZac8qYuZxfeHHTplx6hh+P3ykAMYf6vMt0n/9KuIY9NvHLfpIqsaQRZpDdP9nZjaATa1nwx8aleV5lgQu4OiPh0I++cREQuKVwzpGNnmX4f0zZN+M8OYSbS2Dar91vkxfNgXhPVygGW0J9RTM4aWYKD3ZJuZjNEDbPkfgwQrS34h09/avOe0pL31yg85Zfo7vswrSBzVurUzjPstdVVcu9LEGvHXbKL+EePuBFScccQYmfqsRNreVEGR18JgrEkeHeCOUekyD42iGYvIfO5Q82Rdc7qe4+UYcq3WHiTVywwBJkqqfpc7yHJn7A4WkPkpngO6HqYAgqwRrE9W9Yw16/dgyj4ErFlKHDC9EDVEckKNJ0Huh+ZS7qrhqSPueclqHKzK71FcsA0mJs5FN9jjl590IOZlHt23WsbECYZ54+Jgr1/hkBMLAVpQOEb56L+r0YsExEQMgikNR1oRHmGW9bJdfqWOOX7ywRWBqkKYMog233agZfNL4X67VWFHEknE2ea8gGy9ix4rLgfpKSYFYRRu7cEKh2/x5P+NCf2jxRV7cHOYYYrgxpcbA5p5j0pbOTFfzcWuBbVLXX8FYAkdfBwrJuDJxSz6komS0P7kmrQISxDmwBsZOlSS4X0XoisffpTzqiIahWd7Si5tUMGELMer0doCSqDxpvNVnLQ== bruno.cochofel@gmail.com"
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
