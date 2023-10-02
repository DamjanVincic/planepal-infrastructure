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
  default     = "B1"
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
  default = "Basic"
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
  type    = string
  default = "kv-base-url"
}

variable "kv_base_URL" {
  type    = string
  default = "http://api.aviationstack.com/v1/"
}

variable "app_secrets_keys" {
  type    = list(string)
  default = ["api-key", "kv-email", "kv-email-password"]
}

variable "email_receiver" {
  type = map(object({
    name  = string
    email = string
  }))
  default = {
    "receiver1" = {
      name  = "Stefan Zivkov"
      email = "s.zivkov-int@levi9.com"
    }

    "receiver2" = {
      name  = "Branislav"
      email = "branislav.zuber@levi9.com"
    }
  }
}

variable "alerts_map" {
  type = map(object({
    name             = string
    message          = string
    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number
  }))
  default = {
    "alert_app_service" = {
      name             = "ma-PlanePal-dev-neu-01"
      message          = "Action will be triggered when CpuTime is greater than 80."
      metric_namespace = "Microsoft.Web/sites"
      metric_name      = "CpuTime"
      aggregation      = "Total"
      operator         = "GreaterThan"
      threshold        = 80
    }

    "alert_storage_account" = {
      name             = "ma-PlanePal-dev-neu-02"
      message          = "Action will be triggered when Transactions count is greater than 50."
      metric_namespace = "Microsoft.Storage/storageAccounts"
      metric_name      = "Transactions"
      aggregation      = "Total"
      operator         = "GreaterThan"
      threshold        = 50
    }

    "alert_database" = {
      name             = "ma-PlanePal-dev-neu-03"
      message          = "Action will be triggered when DTU is greater than 60."
      metric_namespace = "Microsoft.Sql/servers/databases"
      metric_name      = "dtu_consumption_percent"
      aggregation      = "Maximum"
      operator         = "GreaterThan"
      threshold        = 90
    }
  }
}

variable "subnets" {
  type = map(object({
    name                = string
    resource_group_name = string
    address_prefixes    = string
  }))
  default = {
    "subnet_app" = {
      name                = "snet-PlanePal-dev-neu-01"
      resource_group_name = "DevOps"
      address_prefixes    = "10.0.0.0/24"
    }
    "subnet_sql" = {
      name                = "snet-PlanePal-dev-neu-02"
      resource_group_name = "DevOps"
      address_prefixes    = "10.0.1.0/24"
    }
    "subnet_app_keyvault" = {
      name                = "snet-PlanePal-dev-neu-03"
      resource_group_name = "DevOps"
      address_prefixes    = "10.0.2.0/24"
    }
    "subnet_app_storage" = {
      name                = "snet-PlanePal-dev-neu-04"
      resource_group_name = "DevOps"
      address_prefixes    = "10.0.3.0/24"
    }
  }
}

variable "address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "levi9_public_ip" {
  type    = string
  default = "178.220.237.81"
}