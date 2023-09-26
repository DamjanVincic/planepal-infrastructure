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

module "app-service" {
  source = "./modules/appservice"

  resource_group_name = var.resource_group
  instrumentation_key = module.logging.instrumentation_key
  location = var.location
  app_name = var.app_name
  environment = var.environment
  dot_net_version = var.dot_net_version
  app_sku = var.app_sku

}

module "storage" {
  source = "./modules/storage"

  resource_group = var.resource_group
  app_name = var.app_name
  account_tier = var.account_tier
  replication_type = var.replication_type
  location = var.location
  environment = var.environment
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