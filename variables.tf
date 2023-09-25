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
variable "location_abbreviation" {
      type = string
      default = "neu"
}
variable "sql_login" {
      type = string
      default = "admin"
}
variable "sql_password" {
      type = string
      default = "admin"
}
variable "sql_version" {
      type = string
      default = "12.0"
}
variable "sqldb_sku_name" {
      type = string
      default= "basic"
}
variable "sqldb_sku_max_gb_size" {
      type = number
      default = 1
}