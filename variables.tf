variable "location" {
  type        = string
  description = "Location for resources"
  default     = "northeurope"
}

variable "resource_group" {
  type        = string
  description = "Resource group name"
  default     = "DevOps"
}

variable "app_name" {
  type        = string
  description = "Application name"
  default     = "PlanePal"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "dot_net_version" {
  type        = string
  description = "Dotnet Version"
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

variable "devops_kv_name" {
  type        = string
  description = "Name of DevOps Key Vault for infrastructure"
  default     = "kv-devops-dev-neu-00"
}

variable "key_sql_username" {
  type        = string
  description = "Key for SQL username in DevOps database"
  default     = "sqllogin"
}

variable "key_sql_password" {
  type        = string
  description = "Key for SQL password in DevOps database"
  default     = "sqlpassword"
}

variable "kv_base_URL_name" {
  type = string
  default = "kv-base-url"
}

variable "kv_base_URL" {
  type        = string
  default     = "http://api.aviationstack.com/v1/"
}

variable "kv_API_key" {
  type        = string
  default     = "api-key"
}

variable "kv_email_key" {
  type        = string
  default     = "kv-email"
}

variable "kv_email_pass_key" {
  type        = string
  default     = "kv-email-password"
}