
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv-for-app" {
  name                        = "kv-automation-dev-neu-01"
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
      Get
    ]

  }
  }
}

