terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.74"
    }
  }
  backend "azurerm" {
    
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "app_service" {
  source = "./modules/appservice"

  resource_group_name = var.resource_group
  instrumentation_key = module.logging.instrumentation_key
  location            = var.location
  app_name            = var.app_name
  environment         = var.environment
  dot_net_version     = var.dot_net_version
  app_sku             = var.app_sku
}

module "storage" {
  source = "./modules/storage"

  resource_group   = var.resource_group
  app_name         = var.app_name
  account_tier     = var.account_tier
  replication_type = var.replication_type
  location         = var.location
  environment      = var.environment
  outbound_ip_address_list = module.app_service.outbound_ip_address_list
}

module "key_vault" {
  source = "./modules/keyvault"


  location         = var.location
  resource_group   = var.resource_group
  app_name         = var.app_name
  environment      = var.environment
  kv_app_sku_name  = var.kv_app_sku_name
  tenant_id        = module.app_service.tenant_id
  principal_id     = module.app_service.object_id
  devops_kv_name   = var.devops_kv_name
  key_sql_username = var.key_sql_username
  key_sql_password = var.key_sql_password
  kv_API_key       = var.kv_API_key
  kv_email         = var.kv_email
  kv_email_pass    = var.kv_email_pass

  outbound_ip_address_list = module.app_service.outbound_ip_address_list
}

module "logging" {
  source = "./modules/logging"

  resource_group_name  = var.resource_group
  location             = var.location
  app_name             = var.app_name
  environment          = var.environment
  location_abbravation = var.location_abbreviation
  app_service_id       = module.app_service.web_app_id
  storage_account_id   = module.storage.account_id
  database_id          = module.sql.sqldb_id
}

module "sql" {
  source                = "./modules/sql"
  resource_group_name   = var.resource_group
  app_name              = var.app_name
  environment           = var.environment
  location              = var.location
  location_abbreviation = var.location_abbreviation
  sql_version           = var.sql_version
  sqldb_sku_name        = var.sqldb_sku_name
  sqldb_sku_max_gb_size = var.sqldb_sku_max_gb_size
  sql_login             = module.key_vault.sql_username
  sql_password          = module.key_vault.sql_password
}
