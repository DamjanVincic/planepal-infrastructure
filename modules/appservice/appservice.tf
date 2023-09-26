
variable "resource_group_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "location" {
  type = string
}
variable "app_name" {
  type = string
}
variable "instrumentation_key" {
  type = string
}
locals {
  dot_net_version = "v6.0"
  app_sku        = "F1"
}
resource "azurerm_service_plan" "service-plan-planepal-dev-neu-00" {
  name                = "asp-${var.app_name}-${var.environment}-${var.location}-00"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "${local.app_sku}"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "app-PlanePal-dev-northeurope-00" {
  
   identity {
    type = "SystemAssigned"
  }
  
  name                = "app-${var.app_name}-${var.environment}-${var.location}-00"
  resource_group_name = var.var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.service-plan-planepal-dev-neu-00.id


  site_config { 
   always_on = "false"
  }
  identity {
    type = "SystemAssigned"
  }
  app_settings = {
    "dotnet_framework_version" = "${local.dot_net_version}"
    "ApplicationInsights:InstrumentationKey" = "${var.instrumentation_key}"
  }
}

