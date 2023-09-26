resource "azurerm_application_insights" "app_insights" {
  name                = "appi-${var.app_name}-${var.environment}-${var.location}-01"
  resource_group_name = data.azurerm_resource_group.devops_rg.name
  location            = var.location
  application_type    = "web"
}