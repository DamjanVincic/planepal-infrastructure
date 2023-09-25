variable "location" {
    type = string
    description = "location where zour resource needs provision in azure"
    default = "northeurope"
}
variable "resource_group" {
    type = string
    description = "resource_group name"
    default = "DevOps"
}
variable "app_name" {
    type = string
    description = "Name of Application"
    default = "PlanePal"
}
variable "environment" {
    type = string
    description = "Name of Environment"
    default = "dev"
}
variable "dot_net_version" {
    type = string
    description = "Dot Net Version"
    default = "v6.0"
}
variable "app_sku" {
    type = string
    description = "Plan for application"
    default = "F1"
}
//