variable "resource_group_name" {
  type = string
}

variable "app_name" {
  type = string
}
variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "location_abbreviation" {
  type = string
}

variable "sql_version" {
  type = string
}
variable "sql_login" {

}
variable "sql_password" {

}
variable "sqldb_sku_name" {
  type = string
}
variable "sqldb_sku_max_gb_size" {
  type = number
}

variable "subnet_id" {
  type = string
}

variable "sr_source_adress" {
  type = string
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

resource "azurerm_mssql_server" "sql-planepal-dev-neu-01" {
  name                         = "sql${lower(var.app_name)}${var.environment}${var.location_abbreviation}00"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.sql_login.value
  administrator_login_password = var.sql_password.value
  timeouts {
    create = "2h30m"
    update = "2h"
    delete = "20m"
  }

}

resource "azurerm_mssql_firewall_rule" "FirewallRule" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.sql-planepal-dev-neu-01.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
resource "azurerm_mssql_firewall_rule" "FirewallRule1" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.sql-planepal-dev-neu-01.id
  start_ip_address = chomp(data.http.myip.body)
  end_ip_address   = chomp(data.http.myip.body)
}

resource "azurerm_mssql_database" "sqldb-planepal-dev-neu-01" {
  name        = "sqldb${lower(var.app_name)}${var.environment}${var.location_abbreviation}00"
  sku_name    = var.sqldb_sku_name
  collation   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb = var.sqldb_sku_max_gb_size
  server_id   = azurerm_mssql_server.sql-planepal-dev-neu-01.id
  timeouts {
    create = "2h30m"
    update = "2h"
    delete = "20m"
  }
  tags = {
    environment = "development"
  }
}

resource "azurerm_network_security_group" "st_sql_nsg" {
  name                = "nsg-sql-${lower(var.app_name)}-${var.environment}-${var.location}-01"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "allow-app"
    protocol                   = "Tcp"
    access                     = "Allow"
    priority                   = 200
    direction                  = "Inbound"
    source_port_range          = "*"
    destination_port_ranges    = [443]
    source_address_prefixes    = "10.0.1.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-all"
    protocol                   = "Tcp"
    access                     = "Deny"
    priority                   = 205
    direction                  = "Inbound"
    source_port_range          = "*"
    destination_port_ranges    = "*"
    source_address_prefixes    = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.st_sql_nsg.id
}