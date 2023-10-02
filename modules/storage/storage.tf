variable "resource_group" {
  description = "Resource group name"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "account_tier" {
  description = "Account tier"
  type        = string
}

variable "replication_type" {
  description = "Replication type"
  type        = string
}

variable "location" {
  description = "Location"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "outbound_ip_address_list" {
  description = "List of ips used by app service"
}

variable "subnet_id" {
  description = "Subnet ID"
  type = string
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "st${lower(var.app_name)}${var.environment}01"
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
}

resource "azurerm_storage_container" "storage_container" {
  name                 = "sc-${lower(var.app_name)}-${var.environment}-${var.location}-01"
  storage_account_name = azurerm_storage_account.storage_account.name
}

resource "azurerm_private_endpoint" "storage_account_endpoint" {
  name                = "pe-st-${lower(var.app_name)}-${var.environment}-${var.location}-01"
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "storage-account-connection-01"
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    is_manual_connection           = false
  }
}