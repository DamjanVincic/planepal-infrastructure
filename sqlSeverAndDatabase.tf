resource "azurerm_mssql_server" "sql-planepal-dev-neu-01" {
  name                         = "sql-${var.app_name}-${var.enviornment}-${var.location_abbreviation}-00"
  resource_group_name          = var.resource_group
  location = var.location
  version                      = var.sql_version
  administrator_login          = var.sql_login
  administrator_login_password = var.sql_password
}

resource "azurerm_mssql_database" "sqldb-planepal-dev-neu-01" {
  name                = "sqldb-${var.app_name}-${var.enviornment}-${var.location_abbreviation}-00"
  sku_name     = var.sqldb_sku_name
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = var.sqldb_sku_max_gb_size
  server_id = azurerm_mssql_server.sql-planepal-dev-neu-01.id

  tags = {
    environment = "development"
  }
}