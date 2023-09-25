resource "azurerm_service_plan" "service-plan-planepal-dev-neu-00" {
  name                = "service-plan-planepal-dev-neu-00"
  resource_group_name = var.resource_group
  location            = var.location
  sku_name            = "F1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "web-app-planepal-dev-neu-00" {
  name                = "PlanePal"
  resource_group_name = var.resource_group
  location            = var.location
  service_plan_id     = azurerm_service_plan.service-plan-planepal-dev-neu-00.id

  site_config { 
   always_on = "false"
  }
  app_settings = {
    "dotnet_framework_version" = "v6.0"
  }
}

