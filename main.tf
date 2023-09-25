resource "azurerm_mssql_server" "sql-planepal-dev-neu-01" {
  name                         = "sql-planepal-dev-neu-01"
  resource_group_name          = var.resource_group
  location = var.location
  version                      = "12.0"
  administrator_login          = "devops"
  administrator_login_password = "TzLKisoNPk3e!"
}

resource "azurerm_mssql_database" "sqldb-planepal-dev-neu-01" {
  name                = "sqldb-planepal-dev-neu-01"
  sku_name     = "Basic"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 1
  server_id = azurerm_mssql_server.sql-planepal-dev-neu-01.id

  tags = {
    environment = "development"
  }
}