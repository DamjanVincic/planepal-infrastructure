data "azurerm_resource_group" "devops_rg" {
  name = var.resource_group
}

resource "azurerm_application_insights" "app_insights" {
  name                = "appi-planepal-dev-northeurope-01"
  resource_group_name = data.azurerm_resource_group.devops_rg.name
  location            = var.location
  application_type    = "web"
}