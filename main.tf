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

module "storage" {
  source = "./modules/storage"

  resource_group = var.resource_group
  app_name = var.app_name
  account_tier = var.account_tier
  replication_type = var.replication_type
  location = var.location
  environment = var.environment
}