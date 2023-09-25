
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv_for_app" {
  name                        = "kv-${var.app_name}-${var.environment}-${var.location}-01"
  #"kv-planepal-dev-neu-01"
  location                    = var.location
  resource_group_name         = var.resource_group
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false 

  sku_name = "standard"


  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id


    secret_permissions = [
      "Get",
    ]

    }
  }


