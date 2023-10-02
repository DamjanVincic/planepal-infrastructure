variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "address_space" {
  type = string
}

variable "subnets" {
  type = map(object({
    name                = string
    resource_group_name = string
    address_prefixes    = string
  }))
}


resource "azurerm_virtual_network" "az_vNet" {
  name                = "vnet-${var.app_name}-${var.environment}-${var.location}-01"
  address_space       = [var.address_space]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "az_subnet" {
  for_each             = var.subnets
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = azurerm_virtual_network.az_vNet.name
  address_prefixes     = [each.value.address_prefixes]
  enforce_private_link_endpoint_network_policies = true
}
/*
resource "azurerm_private_dns_zone" "az_dns_zone" {
  name                = "planePal.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "az_virtual_network_link" {
  name                  = "${azurerm_private_dns_zone.az_dns_zone}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.az_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.az_vNet.id
  registration_enabled  = false
}*/

private_dns_zone_group {
    name                 = "default"
  private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zones["privatelink-vaultcore-azure-net"].id]
  }

