#Resource group
variable "rg_name" {
    description = "nombre del grupo de recursos"
}
variable "rg_location" {}
variable "rg_group" {}

# Virtual Network
variable "vnet_name" {}
variable "vnet_address_space" {}
variable "subnet_name" {}
variable "subnet_address_prefixes" {}

#ACR
variable "acr_name" {}
variable "acr_sku" {}
variable "acr_admin_enabled" {}

#AKS
variable "aks_name" {}
variable "aks_dns_prefix" {}
variable "aks_np_name" {}
variable "aks_np_node_count" {}
variable "aks_np_vm_size" {}
variable "aks_sp_client_id" {}
variable "aks_sp_client_secret" {}
variable "aks_kubernetes_version" {}
variable "aks_rback_enabled" {}
variable "aks_np_enable_auto_scaling" {}
variable "aks_np_max_count" {}
variable "aks_np_min_count" {}
variable "aks_net_plugin" {}
variable "aks_net_policy" {}
variable "aks_np_max_pod_count" {}
