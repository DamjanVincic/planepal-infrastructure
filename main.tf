terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.74"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "key_vault" {
  source = "./modules/keyvault"

  location = var.location
  resource_group = var.resource_group
  app_name = var.app_name
  environment = var.environment
  kv_app_sku_name = var.kv_app_sku_name
  tenant_id = var.tenant_id
  principal_id = module.app-service.object_id
    
  
}