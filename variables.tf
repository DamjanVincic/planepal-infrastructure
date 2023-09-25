variable "location" {
    type = string
    description = "location where zour resource needs provision in azure"
    default = "North Europe"
}

variable "resource_group" {
    type = string
    description = "resource_group name"
    default = "DevOps"
}

variable "kv_app_sku_name" {
    type = string
    description = "sku name for app key vault"
    default = "standard"
}