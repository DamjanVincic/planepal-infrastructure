
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv_for_app" {
  name                        = "kv-app-${var.app_name}-${var.environment}-${var.location}-01"
  location                    = var.location
  resource_group_name         = var.resource_group
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false 

  sku_name = var.kv_app_sku_name


  access_policy {
    tenant_id = azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.identity[0].tenant_id
    object_id = azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.identity[0].principal_id


    secret_permissions = [
      "Get",
    ]

    }
  }


