data "azurerm_resource_group" "devops_rg" {
  name = var.resource_group
}

resource "azurerm_monitor_action_group" "action_group" {
  name                = "ag-${var.app_name}-${var.environment}-${var.location}-01"
  resource_group_name = data.azurerm_resource_group.devops_rg.name
  short_name          = "devops_ag"
  enabled = true

  email_receiver {
    name = "Stefan"
    email_address = "stefanzivkov78@gmail.com"
  }

  email_receiver {
    name = "Branislav"
    email_address = "branislav.zuber@levi9.com"
  }
}

resource "azurerm_monitor_metric_alert" "alert_app_service" {
  name                = "ma-${var.app_name}-${var.environment}-${var.location}-01"
  resource_group_name = data.azurerm_resource_group.devops_rg.name
  scopes              = [azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.id]
  description         = "Action will be triggered when CpuPercentage is greater than 60."

  criteria {
    metric_namespace  = "Microsoft.Web/sites"
    metric_name       = "CpuPercentage"
    aggregation       = "Average"
    operator          = "GreaterThan"
    threshold         = 60
    time_aggregation  = "Average"
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "alert_storage_account" {
  name                = "ma-${var.app_name}-${var.environment}-${var.location}-02"
  resource_group_name = data.azurerm_resource_group.devops_rg.name
  scopes              = [azurerm_storage_account.storage_account.id]
  description         = "Action will be triggered when Transactions count is greater than 50."

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Transactions"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 50
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "alert_database" {
  name                = "ma-${var.app_name}-${var.environment}-${var.location}-03"
  resource_group_name = data.azurerm_resource_group.devops_rg.name
  scopes              = [azurerm_mssql_database.sqldb-planepal-dev-neu-01.id]
  description         = "Action will be triggered when DTU is greater than 60."

criteria {
    metric_namespace  = "Microsoft.Sql/servers/databases"
    metric_name       = "dtu_consumption_percent"
    aggregation       = "Maximum"
    operator          = "GreaterThan"
    threshold         = 90
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_activity_log_alert" "alert_serviceHealth" {
  name                = "ala-${var.app_name}-${var.environment}-${var.location}-01"
  resource_group_name = data.azurerm_resource_group.devops_rg.name
  scopes              = [data.azurerm_resource_group.devops_rg.id]

  criteria {
    category = "ServiceHealth"
  }

  action {
    action_group_id = azurerm_monitor_action_group.example.id
  }
}