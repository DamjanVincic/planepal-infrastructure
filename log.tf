resource "azurerm_log_analytics_workspace" "log-a-w" {
  name                = "log-planepal-dev-neu-01"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
  retention_in_days   = 30
}