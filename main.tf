variable "resource_group" {}
variable "location" {}

resource "azurerm_mssql_server" "example" {
  name                         = "devops-mssql-server"
  resource_group_name          = var.resource_group
  location = var.location
  version                      = "12.0"
  administrator_login          = "devops"
  administrator_login_password = "TzLKisoNPk3e!"
}

resource "azurerm_mssql_database" "example" {
  name                = "devops-mssql-database"
  sku_name     = "Basic"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 1
  server_id = azurerm_mssql_server.example.id

  tags = {
    environment = "development"
  }
}