resource "azurerm_service_plan" "service-plan-planepal-dev-neu-00" {
  name                = "asp-${var.app_name}-${var.environment}-${var.location}-00"
  resource_group_name = var.resource_group
  location            = var.location
  sku_name            = "${var.app_sku}"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "app-PlanePal-dev-northeurope-00" {
  
   identity {
    type = "SystemAssigned"
  }
  
  name                = "app-${var.app_name}-${var.environment}-${var.location}-00"
  resource_group_name = var.resource_group
  location            = var.location
  service_plan_id     = azurerm_service_plan.service-plan-planepal-dev-neu-00.id


  site_config { 
   always_on = "false"
  }
  identity {
    type = "SystemAssigned"
  }
  app_settings = {
    "dotnet_framework_version" = "${var.dot_net_version}"
 //  "ApplicationInsights:InstrumentationKey" = azurerm_application_insights.app_insights.instrumentation_key
  }
}

