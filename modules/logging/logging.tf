
variable "resource_group_name" {
  type        = string
  description = "DevOps"
}

variable "location" {
  type        = string
  description = "northeurope"
}

variable "app_name" {
  type        = string
  description = "PlanePal"
}

variable "environment" {
  type        = string
  description = "Abbravation for environment, used for defining name of resources"
}

variable "location_abbravation" {
  type        = string
  description = "Abbravation for resource group location, used for defining name of resources"
}

variable "app_service_id" {
  type        = string
  description = "App service id, used for creating service app alert"
}

variable "database_id" {
  type        = string
  description = "Database id, used for creating database alert"
}

variable "storage_account_id" {
  type        = string
  description = "Storage account id, used for creating storage account alert"
}

variable "app_service_plan_id" {
  type        = string
  description = "App service plan id, used for creating storage account alert"
}

variable "alerts_map" {
  type = map()
  description = "Map with informations for creating metrics alerts"
}

variable "email_receiver" {
  type = map()
  description = "Map with informations for creating email receivers in action group"
}


data "azurerm_resource_group" "devops_rg" {
  name = var.resource_group_name
}

data "azurerm_subscription" "subscription" {}

resource "azurerm_log_analytics_workspace" "log-a-w" {
  name                = "log-${var.app_name}-${var.environment}-${var.location}-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# variable "email_receiver" {
#   type = map(object({
#     name = string
#     email = string
#   }))
#   default = {
#     "receiver1" = {
#       name = "Stefan Zivkov"
#       email = "s.zivkov-int@levi9.com"
#     }

#     "receiver2" = {
#       name          = "Branislav"
#       email_address = "branislav.zuber@levi9.com"
#     }
#   }
# }


resource "azurerm_monitor_action_group" "action_group" {
  for_each = var.email_receiver
  
  name                = "ag-${var.app_name}-${var.environment}-${var.location}-01"
  resource_group_name = var.resource_group_name
  short_name          = "devops_ag"
  enabled             = true

  dynamic "email_receiver" {
    for_each = var.email_receiver

    content {
      name          = each.value.name
      email_address = each.value.email
    }
    
  }
}

# variable "alerts_map" {

#   type = map(object({
#     name = string
#     scope = string
#     message = string
#     metric_namespace = string
#     metric_name = string
#     aggregation = string
#     operator = string
#     threshold = number
#   }))
#   default = {
#     "alert_app_service" = {
#       name = "ma-${var.app_name}-${var.environment}-${var.location}-01"
#       scope = var.app_service_id
#       message = "Action will be triggered when CpuTime is greater than 80."
#       metric_namespace = "Microsoft.Web/sites"
#       metric_name = "CpuTime"
#       aggregation = "Total"
#       operator = "GreaterThan"
#       threshold = 80
#     }

#     "alert_storage_account" = {
#       name = "ma-${var.app_name}-${var.environment}-${var.location}-02"
#       scope = var.storage_account_id
#       message = "Action will be triggered when Transactions count is greater than 50."
#       metric_namespace = "Microsoft.Storage/storageAccounts"
#       metric_name = "Transactions"
#       aggregation = "Total"
#       operator = "GreaterThan"
#       threshold = 50
#     }

#     "alert_database" = {
#       name = "ma-${var.app_name}-${var.environment}-${var.location}-03"
#       scope = var.database_id
#       message = "Action will be triggered when DTU is greater than 60."
#       metric_namespace = "Microsoft.Sql/servers/databases"
#       metric_name = "dtu_consumption_percent"
#       aggregation = "Maximum"
#       operator = "GreaterThan"
#       threshold = 90
#     }
#   }
  
# }

resource "azurerm_monitor_metric_alert" "alert_app_service" {
  for_each = var.alerts_map

  name                = each.value.name
  resource_group_name = var.resource_group_name
  scopes              = [each.value.scope]
  description         = each.value.message

  criteria {
    metric_namespace = each.value.metric_namespace
    metric_name      = each.value.metric_name
    aggregation      = each.value.agreggation
    operator         = each.value.operator
    threshold        = each.value.threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group.id
  }
}

# resource "azurerm_monitor_metric_alert" "alert_app_service" {
#   name                = "ma-${var.app_name}-${var.environment}-${var.location}-01"
#   resource_group_name = var.resource_group_name
#   scopes              = [var.app_service_id]
#   description         = "Action will be triggered when CpuTime is greater than 80."

#   criteria {
#     metric_namespace = "Microsoft.Web/sites"
#     metric_name      = "CpuTime"
#     aggregation      = "Total"
#     operator         = "GreaterThan"
#     threshold        = 80
#   }

#   action {
#     action_group_id = azurerm_monitor_action_group.action_group.id
#   }
# }

# resource "azurerm_monitor_metric_alert" "alert_app_service-02" {
#   name                = "ma-${var.app_name}-${var.environment}-${var.location}-04"
#   resource_group_name = var.resource_group_name
#   scopes              = [var.app_service_plan_id]
#   description         = "Action will be triggered when average MemoryPercentage is greater than 80."

#   criteria {
#     metric_namespace = "Microsoft.Web/serverfarms"
#     metric_name      = "MemoryPercentage"
#     aggregation      = "Average"
#     operator         = "GreaterThan"
#     threshold        = 80
#   }

#   action {
#     action_group_id = azurerm_monitor_action_group.action_group.id
#   }
# }

# resource "azurerm_monitor_metric_alert" "alert_storage_account" {
#   name                = "ma-${var.app_name}-${var.environment}-${var.location}-02"
#   resource_group_name = data.azurerm_resource_group.devops_rg.name
#   scopes              = [var.storage_account_id]
#   description         = "Action will be triggered when Transactions count is greater than 50."

#   criteria {
#     metric_namespace = "Microsoft.Storage/storageAccounts"
#     metric_name      = "Transactions"
#     aggregation      = "Total"
#     operator         = "GreaterThan"
#     threshold        = 50
#   }

#   action {
#     action_group_id = azurerm_monitor_action_group.action_group.id
#   }
# }

# resource "azurerm_monitor_metric_alert" "alert_database" {
#   name                = "ma-${var.app_name}-${var.environment}-${var.location}-03"
#   resource_group_name = data.azurerm_resource_group.devops_rg.name
#   scopes              = [var.database_id]
#   description         = "Action will be triggered when DTU is greater than 60."

#   criteria {
#     metric_namespace = "Microsoft.Sql/servers/databases"
#     metric_name      = "dtu_consumption_percent"
#     aggregation      = "Maximum"
#     operator         = "GreaterThan"
#     threshold        = 90
#   }

#   action {
#     action_group_id = azurerm_monitor_action_group.action_group.id
#   }
# }

resource "azurerm_monitor_activity_log_alert" "alert_serviceHealth" {
  name                = "ala-${var.app_name}-${var.environment}-${var.location}-01"
  resource_group_name = data.azurerm_resource_group.devops_rg.name
  scopes              = [data.azurerm_subscription.subscription.id]

  criteria {
    category = "ServiceHealth"
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group.id
  }
}

resource "azurerm_application_insights" "app_insights" {
  name                = "appi-${var.app_name}-${var.environment}-${var.location}-01"
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = "web"
}