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
  type    = string
  default = "kv-base-url"
}

variable "kv_base_URL" {
  type    = string
  default = "http://api.aviationstack.com/v1/"
}

variable "kv_API_key" {
  type    = string
  default = "api-key"
}

variable "kv_email_key" {
  type    = string
  default = "kv-email"
}

variable "kv_email_pass_key" {
  type    = string
  default = "kv-email-password"
}

variable "address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "ip_range_azure" {
  default = [
    "13.69.0.0/17", "13.73.128.0/18", "13.73.224.0/21", "13.80.0.0/15", "13.88.200.0/21",
    "13.93.0.0/17", "13.94.128.0/17", "13.95.0.0/16", "13.104.145.192/26", "13.104.146.0/26",
    "13.104.146.128/25", "13.104.158.176/28", "13.104.209.0/24", "13.104.214.0/25", "13.104.218.128/25",
    "13.105.22.0/24", "13.105.23.128/25", "13.105.60.48/28", "13.105.60.96/27", "13.105.60.128/27",
    "13.105.66.144/28", "20.38.108.0/23", "20.38.200.0/22", "20.47.7.0/24", "20.47.18.0/23", "20.47.30.0/24",
    "20.47.96.0/23", "20.47.115.0/24", "20.47.118.0/24", "20.50.0.0/18", "20.50.128.0/17",
    "20.54.128.0/17", "20.56.0.0/16", "20.60.26.0/23", "20.60.130.0/24", "20.61.0.0/16", "20.135.24.0/22",
    "20.150.8.0/23", "20.150.37.0/24", "20.150.42.0/24", "20.150.74.0/24", "20.150.76.0/24",
    "20.150.83.0/24", "20.150.122.0/24", "20.157.33.0/24", "20.190.137.0/24", "20.190.160.0/24",
    "23.97.128.0/17", "23.98.46.0/24", "23.100.0.0/20", "23.101.64.0/20", "40.67.192.0/19",
    "40.68.0.0/16", "40.74.0.0/18", "40.78.210.0/24", "40.82.92.0/22", "40.87.184.0/22", "40.90.17.64/27",
    "40.90.18.192/26", "40.90.20.128/25", "40.90.21.0/25", "40.90.130.0/27", "40.90.133.0/27",
    "40.90.134.64/26", "40.90.134.128/26", "40.90.138.0/27", "40.90.141.32/27", "40.90.141.160/27",
    "40.90.142.224/28", "40.90.144.192/27", "40.90.145.192/27", "40.90.146.16/28", "40.90.146.128/27",
    "40.90.150.128/25", "40.90.157.64/26", "40.90.159.0/24", "40.91.28.0/22", "40.91.192.0/18",
    "40.112.36.128/25", "40.112.37.0/26", "40.112.38.192/26", "40.112.96.0/19", "40.113.96.0/19",
    "40.113.128.0/18", "40.114.128.0/17", "40.115.0.0/18", "40.118.0.0/17", "40.119.128.0/19",
    "40.126.9.0/24", "40.126.32.0/24", "51.105.96.0/19", "51.105.128.0/17", "51.124.0.0/17",
    "51.124.128.0/18", "51.136.0.0/16", "51.137.0.0/17", "51.137.192.0/18", "51.138.0.0/17",
    "51.144.0.0/16", "51.145.128.0/17", "52.108.24.0/21", "52.108.56.0/21", "52.108.80.0/24",
    "52.108.108.0/23", "52.108.110.0/24", "52.109.88.0/22", "52.111.243.0/24", "52.112.14.0/23",
    "52.112.17.0/24", "52.112.18.0/23", "52.112.71.0/24", "52.112.83.0/24", "52.112.97.0/24",
    "52.112.98.0/23", "52.112.110.0/23", "52.112.144.0/20", "52.112.197.0/24", "52.112.216.0/21",
    "52.112.233.0/24", "52.112.237.0/24", "52.112.238.0/24", "52.113.9.0/24", "52.113.37.0/24",
    "52.113.83.0/24", "52.113.130.0/24", "52.113.144.0/21", "52.113.199.0/24", "52.114.64.0/21",
    "52.114.72.0/22", "52.114.116.0/22", "52.114.241.0/24", "52.114.242.0/24", "52.114.252.0/22",
    "52.115.0.0/21", "52.115.8.0/22", "52.120.128.0/21", "52.120.208.0/20", "52.121.24.0/21",
    "52.121.64.0/20", "52.125.140.0/23", "52.136.192.0/18", "52.137.0.0/18", "52.142.192.0/18",
    "52.143.0.0/18", "52.143.194.0/24", "52.143.208.0/24", "52.148.192.0/18", "52.149.64.0/18",
    "52.157.64.0/18", "52.157.128.0/17", "52.166.0.0/16", "52.174.0.0/16", "52.178.0.0/17",
    "52.232.0.0/17", "52.232.147.0/24", "52.233.128.0/17", "52.236.128.0/17", "52.239.140.0/22",
    "52.239.212.0/23", "52.239.242.0/23", "52.245.48.0/22", "52.245.124.0/22", "65.52.128.0/19",
    "104.40.128.0/17", "104.44.89.160/27", "104.44.90.192/27", "104.44.93.0/27", "104.44.93.192/27",
    "104.44.95.80/28", "104.44.95.96/28", "104.45.0.0/18", "104.45.64.0/20", "104.46.32.0/19",
    "104.47.128.0/18", "104.47.216.64/26", "104.214.192.0/18", "137.116.192.0/19", "137.117.128.0/17",
    "157.55.8.64/26", "157.55.8.144/28", "157.56.117.64/27", "168.61.56.0/21", "168.63.0.0/19",
    "168.63.96.0/19", "191.233.64.0/19", "191.233.96.0/20", "191.233.112.0/21", "191.237.232.0/22",
    "191.239.200.0/22", "193.149.80.0/21", "213.199.128.0/20", "213.199.180.32/28", "213.199.180.96/27",
    "213.199.180.192/27", "213.199.183.0/24"
  ]


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
    delegation          = string
  }))
  default = {
    "subnet_app" = {
      name                = "snet-PlanePal-dev-neu-01"
      resource_group_name = "DevOps"
      address_prefixes    = "10.0.0.0/24"
      delegation          = "subnet1_delegation"
    }

    "subnet_sql" = {
      name                = "snet-PlanePal-dev-neu-02"
      resource_group_name = "DevOps"
      address_prefixes    = "10.0.1.0/24"
      delegation          = "subnet2_delegation"
    }
    "subnet_storage" = {
      name                = "snet-PlanePal-dev-neu-03"
      resource_group_name = "DevOps"
      address_prefixes    = "10.0.2.0/24"
      delegation          = "subnet3_delegation"
    }
    "subnet_app_storage" = {
      name                = "snet-PlanePal-dev-neu-04"
      resource_group_name = "DevOps"
      address_prefixes    = "10.0.3.0/24"
      delegation          = "subnet4_delegation"
    }
  }
}