variable "location" {
  type        = string
  description = "location where zour resource needs provision in azure"
  default     = "northeurope"
}

variable "resource_group" {
  type        = string
  description = "resource_group name"
  default     = "DevOps"
}

variable "app_name" {
  type        = string
  description = "Name of Application"
  default     = "PlanePal"
}

variable "environment" {
  type        = string
  description = "Name of Environment"
  default     = "dev"
}

variable "dot_net_version" {
  type        = string
  description = "Dot Net Version"
  default     = "v6.0"
}

variable "app_sku" {
  type        = string
  description = "Plan for application"
  default     = "F1"
}

variable "location_abbreviation" {
  type    = string
  default = "neu"
}

variable "sql_login" {
  type    = string
  default = "JakoTajnoIme"
}

variable "sql_password" {
  type    = string
  default = "JakoTajnaSifra123!"
}

variable "sql_version" {
  type    = string
  default = "12.0"
}

variable "sqldb_sku_name" {
  type    = string
  default = "basic"
}

variable "sqldb_sku_max_gb_size" {
  type    = number
  default = 1
}

variable "log_sku" {
  type    = string
  default = "PerGB2018"
}

variable "kv_app_sku_name" {
  type        = string
  description = "sku name for app key vault"
  default     = "standard"
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "replication_type" {
  type    = string
  default = "LRS"
}

variable "tenant_id" {
  type = string
  default = "40758481-7365-442c-ae94-563ed1606218"
}