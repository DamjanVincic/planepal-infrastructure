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
