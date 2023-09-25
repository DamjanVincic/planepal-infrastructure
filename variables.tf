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