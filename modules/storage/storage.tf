data "azurerm_resource_group" "devops_rg" {
  name = var.resource_group
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "st${lower(var.app_name)}${var.environment}01"
  resource_group_name      = data.azurerm_resource_group.devops_rg.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
}

resource "azurerm_storage_container" "storage_container" {
  name                 = "sc-${lower(var.app_name)}-${var.environment}-${var.location}-01"
  storage_account_name = azurerm_storage_account.storage_account.name
}