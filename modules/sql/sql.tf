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

resource "azurerm_mssql_server" "sql-planepal-dev-neu-01" {
  name                         = "sql${lower(var.app_name)}${var.environment}${var.location_abbreviation}00"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.sql_login.value
  administrator_login_password = var.sql_password.value
}

resource "azurerm_mssql_database" "sqldb-planepal-dev-neu-01" {
  name        = "sqldb${lower(var.app_name)}${var.environment}${var.location_abbreviation}00"
  sku_name    = var.sqldb_sku_name
  collation   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb = var.sqldb_sku_max_gb_size
  server_id   = azurerm_mssql_server.sql-planepal-dev-neu-01.id

  tags = {
    environment = "development"
  }
}