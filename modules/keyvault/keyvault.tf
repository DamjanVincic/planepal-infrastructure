variable "location" {
  type        = string
  description = "location where zour resource needs provision in azure"
}

variable "resource_group" {
  type        = string
  description = "resource_group name"
}

variable "app_name" {
  type        = string
  description = "Name of Application"
}
variable "outbound_ip_address_list" {
  description = "List of ips used by app service"
}

variable "environment" {
  type        = string
  description = "Name of Environment"
}

variable "kv_app_sku_name" {
  type        = string
  description = "sku name for app key vault"
}

variable "tenant_id" {
  type = string
}

variable "principal_id" {
  type = string
}

variable "devops_kv_name" {
  type = string
}

variable "key_sql_username" {
  type        = string
  description = "Key for SQL username in DevOps database"
}

variable "key_sql_password" {
  type        = string
  description = "Key for SQL password in DevOps database"
}

variable "kv_base_URL_name" {
  type = string
}

variable "kv_base_URL" {
  type = string
}

variable "kv_API_key" {
  type = string
}

variable "kv_email_key" {
  type = string
}

variable "kv_email_pass_key" {
  type = string
}

data "azurerm_key_vault" "devops_kv" {
  name                = var.devops_kv_name
  resource_group_name = var.resource_group
}

data "azurerm_key_vault_secret" "sql_username" {
  name         = var.key_sql_username
  key_vault_id = data.azurerm_key_vault.devops_kv.id
}

data "azurerm_key_vault_secret" "sql_password" {
  name         = var.key_sql_password
  key_vault_id = data.azurerm_key_vault.devops_kv.id
}

data "azurerm_key_vault_secret" "kv_email" {
  name         = var.kv_email_key
  key_vault_id = data.azurerm_key_vault.devops_kv.id
}

data "azurerm_key_vault_secret" "kv_email_password" {
  name         = var.kv_email_pass_key
  key_vault_id = data.azurerm_key_vault.devops_kv.id
}

data "azurerm_key_vault_secret" "kv_api_key" {
  name         = var.kv_API_key
  key_vault_id = data.azurerm_key_vault.devops_kv.id
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv_for_app" {
  name                       = "kvapp${lower(var.app_name)}${var.environment}02"
  location                   = var.location
  resource_group_name        = var.resource_group
  tenant_id                  = var.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  sku_name = var.kv_app_sku_name

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.principal_id

    secret_permissions = [
      "Get", "List", "Set", "Delete",
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete",
    ]
  }

  network_acls {
    # The Default Action to use when no rules match from ip_rules / 
    # virtual_network_subnet_ids. Possible values are Allow and Deny
    default_action = "Deny"

    # Allows all azure services to access your keyvault. Can be set to 'None'
    bypass = "AzureServices"

    # The list of allowed ip addresses.
    ip_rules  = ["13.69.128.0/17", "13.70.192.0/18", "13.74.0.0/16", "13.79.0.0/16", "13.94.64.0/18", "13.104.148.0/25", "13.104.149.128/25", "13.104.150.0/25", "13.104.208.160/28", "13.104.210.0/24", "13.105.18.0/26", "13.105.21.0/24", "13.105.37.192/26", "13.105.60.192/26", "13.105.67.0/25", "20.38.64.0/19", "20.38.102.0/23", "20.47.8.0/24", "20.47.20.0/23", "20.47.32.0/24", "20.47.111.0/24", "20.47.117.0/24", "20.50.64.0/20", "20.54.0.0/17", "20.60.19.0/24", "20.60.40.0/23", "20.135.20.0/22", "20.150.26.0/24", "20.150.47.128/25", "20.150.48.0/24", "20.150.75.0/24", "20.150.84.0/24", "20.150.104.0/24", "20.190.129.0/24", "20.190.159.0/24", "20.191.0.0/18", "23.100.48.0/20", "23.100.128.0/18", "23.101.48.0/20", "23.102.0.0/18", "40.67.224.0/19", "40.69.0.0/18", "40.69.64.0/19", "40.69.192.0/19", "40.77.133.0/24", "40.77.136.32/28", "40.77.136.80/28", "40.77.165.0/24", "40.77.174.0/24", "40.77.175.160/27", "40.77.182.96/27", "40.77.226.128/25", "40.77.229.0/24", "40.77.234.160/27", "40.77.236.0/27", "40.77.236.176/28", "40.77.255.0/25", "40.78.211.0/24", "40.85.0.0/17", "40.85.128.0/20", "40.87.128.0/19", "40.87.188.0/22", "40.90.17.192/27", "40.90.25.64/26", "40.90.25.128/26", "40.90.31.128/25", "40.90.128.16/28", "40.90.129.192/27", "40.90.130.224/28", "40.90.133.64/27", "40.90.136.176/28", "40.90.137.192/27", "40.90.140.64/27", "40.90.141.96/27", "40.90.141.128/27", "40.90.145.0/27", "40.90.145.224/27", "40.90.147.96/27", "40.90.148.160/28", "40.90.149.128/25", "40.90.153.128/25", "40.91.20.0/22", "40.91.32.0/22", "40.112.36.0/25", "40.112.37.64/26", "40.112.64.0/19", "40.113.0.0/18", "40.113.64.0/19", "40.115.96.0/19", "40.126.1.0/24", "40.126.31.0/24", "40.127.96.0/20", "40.127.128.0/17", "51.104.64.0/18", "51.104.128.0/18", "52.108.174.0/23", "52.108.176.0/24", "52.108.196.0/24", "52.108.240.0/21", "52.109.76.0/22", "52.111.236.0/24", "52.112.191.0/24", "52.112.229.0/24", "52.112.232.0/24", "52.112.236.0/24", "52.113.40.0/21", "52.113.48.0/20", "52.113.112.0/20", "52.113.136.0/21", "52.113.205.0/24", "52.114.76.0/22", "52.114.96.0/21", "52.114.120.0/22", "52.114.231.0/24", "52.114.233.0/24", "52.114.248.0/22", "52.115.16.0/21", "52.115.24.0/22", "52.120.136.0/21", "52.120.192.0/20", "52.121.16.0/21", "52.121.48.0/20", "52.125.138.0/23", "52.138.128.0/17", "52.142.64.0/18", "52.143.195.0/24", "52.143.209.0/24", "52.146.128.0/17", "52.155.64.0/19", "52.155.128.0/17", "52.156.192.0/18", "52.158.0.0/17", "52.164.0.0/16", "52.169.0.0/16", "52.178.128.0/17", "52.232.148.0/24", "52.236.0.0/17", "52.239.136.0/22", "52.239.205.0/24", "52.239.248.0/24", "52.245.40.0/22", "52.245.88.0/22", "65.52.64.0/20", "65.52.224.0/21", "94.245.88.0/21", "94.245.104.0/21", "94.245.114.1/32", "94.245.114.2/31", "94.245.114.4/32", "94.245.114.33/32", "94.245.114.34/31", "94.245.114.36/32", "94.245.117.96/27", "94.245.118.0/27", "94.245.118.65/32", "94.245.118.66/31", "94.245.118.68/32", "94.245.118.97/32", "94.245.118.98/31", "94.245.118.100/32", "94.245.118.129/32", "94.245.118.130/31", "94.245.118.132/32", "94.245.120.128/28", "94.245.122.0/24", "94.245.123.144/28", "94.245.123.176/28", "104.41.64.0/18", "104.41.192.0/18", "104.44.88.64/27", "104.44.91.64/27", "104.44.92.192/27", "104.44.94.32/28", "104.45.80.0/20", "104.45.96.0/19", "104.46.8.0/21", "104.46.64.0/19", "104.47.218.0/23", "131.253.40.80/28", "134.170.80.64/28", "137.116.224.0/19", "137.135.128.0/17", "138.91.48.0/20", "157.55.3.0/24", "157.55.10.160/29", "157.55.10.176/28", "157.55.13.128/26", "157.55.107.0/24", "157.55.204.128/25", "168.61.80.0/20", "168.61.96.0/19", "168.63.32.0/19", "168.63.64.0/20", "168.63.80.0/21", "168.63.92.0/22", "191.232.138.0/23", "191.235.128.0/18", "191.235.192.0/22", "191.235.208.0/20", "191.235.255.0/24", "191.237.192.0/23", "191.237.194.0/24", "191.237.196.0/24", "191.237.208.0/20", "191.238.96.0/19", "191.239.208.0/20", "193.149.88.0/21"]
  }
}

# resource "azurerm_key_vault_access_policy" "kv_access_policy" {
#   key_vault_id = azurerm_key_vault.kv_for_app.id
#   tenant_id    = var.tenant_id
#   object_id    = var.principal_id

#   secret_permissions = [
#     "Get", "List"
#   ]
# }

resource "azurerm_key_vault_secret" "kv_API_key" {
  name         = data.azurerm_key_vault_secret.kv_api_key.name
  value        = data.azurerm_key_vault_secret.kv_api_key.value
  key_vault_id = azurerm_key_vault.kv_for_app.id
}

resource "azurerm_key_vault_secret" "kv_base_URL" {
  name         = var.kv_base_URL_name
  value        = var.kv_base_URL
  key_vault_id = azurerm_key_vault.kv_for_app.id
}

resource "azurerm_key_vault_secret" "kv_email" {
  name         = data.azurerm_key_vault_secret.kv_email.name
  value        = data.azurerm_key_vault_secret.kv_email.value
  key_vault_id = azurerm_key_vault.kv_for_app.id
}

resource "azurerm_key_vault_secret" "kv_email_pass" {
  name         = data.azurerm_key_vault_secret.kv_email_password.name
  value        = data.azurerm_key_vault_secret.kv_email_password.value
  key_vault_id = azurerm_key_vault.kv_for_app.id
}

