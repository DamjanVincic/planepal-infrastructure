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

variable "dot_net_version" {
  type = string
}

variable "app_sku" {
  type = string
}
variable "subneta_id" {
  type = string
}

variable "endpoint_subnet_id" {
  type = string
}

variable "minimum" {
  type = number
}
variable "maximum" {
  type = number
}
variable "default_capacity" {
  type = number
}
variable "cpu_up_threshold" {

}
variable "cpu_down_threshold" {

}
variable "memory_up_threshold" {

}
variable "memory_down_threshold" {

}

resource "azurerm_service_plan" "service-plan-planepal-dev-neu-00" {
  name                = "asp-${var.app_name}-${var.environment}-${var.location}-00"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.app_sku
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "app-PlanePal-dev-northeurope-00" {
  name                      = "app-${var.app_name}-${var.environment}-${var.location}-00"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  service_plan_id           = azurerm_service_plan.service-plan-planepal-dev-neu-00.id
  virtual_network_subnet_id = var.subneta_id

  site_config {
    always_on = "false"
  }
  identity {
    type = "SystemAssigned"
  }
  app_settings = {
    "dotnet_framework_version"               = "${var.dot_net_version}"
    "ApplicationInsights:InstrumentationKey" = "${var.instrumentation_key}"
  }
}

# resource "azurerm_private_endpoint" "private-ep-app-service" {
#   name                = "private-ep-app-service"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   subnet_id           = var.endpoint_subnet_id
#   private_service_connection {
#     name                           = "azurerm_app_service_virtual_network_swift_connection"
#     private_connection_resource_id = azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.id
#     subresource_names              = ["sites"]
#     is_manual_connection           = false
#   }
# }

# resource "azurerm_app_service_virtual_network_swift_connection" "az_vNet" {
#   app_service_id              = azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.id
#   subnet_id =    var.endpoint_subnet_id
# }

# resource "azurerm_monitor_autoscale_setting" "scale_action_setting" {
#   name                = "app-scale-${var.app_name}-${var.environment}-${var.location}-00"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   target_resource_id  = azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.id

#   profile {
#     name = "defaultProfile"

#     capacity {
#       default = var.default_capacity
#       minimum = var.minimum
#       maximum = var.maximum
#     }

#     rule {
#       metric_trigger {
#         metric_name        = "CPU Time"
#         metric_resource_id = azurerm_service_plan.service-plan-planepal-dev-neu-00.id
#         time_grain         = "PT1M"
#         statistic          = "Average"
#         time_window        = "PT10M"
#         time_aggregation   = "Average"
#         operator           = "GreaterThan"
#         threshold          = var.cpu_up_threshold
#       }

#       scale_action {
#         direction = "Increase"
#         type      = "ChangeCount"
#         value     = "1"
#         cooldown  = "PT1M"
#       }
#     }

#     rule {
#       metric_trigger {
#         metric_name        = "Average memory working set"
#         metric_resource_id = azurerm_service_plan.service-plan-planepal-dev-neu-00.id
#         time_grain         = "PT1M"
#         statistic          = "Average"
#         time_window        = "PT15M"
#         time_aggregation   = "Average"
#         operator           = "GreaterThan"
#         threshold          = var.memory_up_threshold
#       }

#       scale_action {
#         direction = "Increase"
#         type      = "ChangeCount"
#         value     = "1"
#         cooldown  = "PT1M"
#       }
#     }
#     rule {
#       metric_trigger {
#         metric_name        = "Average memory working set"
#         metric_resource_id = azurerm_service_plan.service-plan-planepal-dev-neu-00.id
#         time_grain         = "PT1M"
#         statistic          = "Average"
#         time_window        = "PT10M"
#         time_aggregation   = "Average"
#         operator           = "LessThan"
#         threshold          = var.memory_down_threshold
#       }

#       scale_action {
#         direction = "Decrease"
#         type      = "ChangeCount"
#         value     = "1"
#         cooldown  = "PT1M"
#       }
#     }
#     rule {
#       metric_trigger {
#         metric_name        = "CPU Time"
#         metric_resource_id = azurerm_service_plan.service-plan-planepal-dev-neu-00.id
#         time_grain         = "PT1M"
#         statistic          = "Average"
#         time_window        = "PT10M"
#         time_aggregation   = "Average"
#         operator           = "LessThan"
#         threshold          = var.cpu_down_threshold
#       }

#       scale_action {
#         direction = "Decrease"
#         type      = "ChangeCount"
#         value     = "1"
#         cooldown  = "PT1M"
#       }
#     }
#   }

#   notification {
#     email {
#       send_to_subscription_administrator    = true
#       send_to_subscription_co_administrator = true
#     }
#   }
# }
