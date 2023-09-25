data "azurerm_resource_group" "devops_rg" {
  name = var.resource_group
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "st${var.app_name}01"
  resource_group_name      = data.azurerm_resource_group.devops_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage_container" {
  name                 = "sc-${var.app_name}-${var.environment}-${var.location}-01"
  storage_account_name = azurerm_storage_account.storage_account.name
}