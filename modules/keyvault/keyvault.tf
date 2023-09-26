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

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv_for_app" {
  name                       = "kvapp${lower(var.app_name)}${var.environment}02"
  location                   = var.location
  resource_group_name        = var.resource_group
  tenant_id                  = var.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  sku_name = var.kv_app_sku_name

}

resource "azurerm_key_vault_access_policy" "kv_access_policy" {
  key_vault_id = azurerm_key_vault.kv_for_app.id
  tenant_id    = var.tenant_id
  object_id    = var.principal_id

  secret_permissions = [
    "Get",
  ]
}



