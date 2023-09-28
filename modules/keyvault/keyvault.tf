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
      "Get", "List", "Create",
    ]
  }

  # network_acls {
  #   # The Default Action to use when no rules match from ip_rules / 
  #   # virtual_network_subnet_ids. Possible values are Allow and Deny
  #   default_action = "Deny"

  #   # Allows all azure services to access your keyvault. Can be set to 'None'
  #   bypass = "AzureServices"

  #   # The list of allowed ip addresses.
  #   ip_rules = var.outbound_ip_address_list

  # }
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

