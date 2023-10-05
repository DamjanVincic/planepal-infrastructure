variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "app_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "location_abbreviation" {
  type = string
}
variable "aa_sku_name" {
  type = string
}
variable "aar_runbook_type" {
  type = string
}
variable "aar_log_verbose" {
  type = string
}
variable "aar_log_progress" {
  type = string
}
variable "start_time" {
  type = string
}
variable "aas_timezone" {
  type = string
}
variable "st_account_tier" {
  type = string
}
variable "st_replication_type" {
  type = string
}
variable "sc_container_access_type" {
  type = string
}

resource "azurerm_automation_account" "aaplanepaldevneu01" {
  name                = "aa${lower(var.app_name)}${var.environment}${var.location_abbreviation}00"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.aa_sku_name
}

resource "azurerm_automation_runbook" "aarplanepaldevneu01" {
  name                = "aar${lower(var.app_name)}${var.environment}${var.location_abbreviation}00"
  automation_account_id = azurerm_automation_account.aaplanepaldevneu01.id
  runbook_type        = var.aar_runbook_type
  log_verbose         = var.aar_log_verbose
  log_progress        = var.aar_log_progress

  publish_content {
    content = <<-EOT
param (
      [string] $SqlServerName,
      [string] $DatabaseName,
      [string] $StorageAccountName,
      [string] $StorageContainerName,
      [string] $StorageBlobName
    )

    # Authenticate to Azure
    Connect-AzAccount

    # Set the context to the subscription where the storage account exists
    Set-AzContext -SubscriptionId "<Your-Subscription-ID>"

    # Set the storage context
    $storageContext = New-AzStorageContext -StorageAccountName $StorageAccountName -UseConnectedAccount

    # Create a BACPAC file
    $bacpacFile = "C:\$DatabaseName.bacpac"
    Export-AzSqlDatabase -ResourceGroupName "<Your-Resource-Group-Name>" -ServerName $SqlServerName -DatabaseName $DatabaseName -AdministratorLogin "<Your-Admin-Login>" -AdministratorLoginPassword (ConvertTo-SecureString -String "<Your-Admin-Password>" -AsPlainText -Force) -StorageContext $storageContext -StorageContainerName $StorageContainerName -DacpacFile $bacpacFile -Force

    # Clean up the BACPAC file
    Remove-Item -Path $bacpacFile

    # Log success
    Write-Output "Database backup completed successfully."
    EOT
  }
}

resource "azurerm_automation_schedule" "aasplanepaldevneu01" {
  name                = "aas${lower(var.app_name)}${var.environment}${var.location_abbreviation}00"
  automation_account_id = azurerm_automation_account.aaplanepaldevneu01.id
  start_time          = formatdate("yyyy-MM-ddT${var.start_time}Z", timestamp())
  description         = "Run daily at ${var.start_time} ${var.aas_timezone}"
  timezone            = var.aas_timezone

  weekly {
    monday    = true
    tuesday   = true
    wednesday = true
    thursday  = true
    friday    = true
  }

  runbook {
    name       = azurerm_automation_runbook.aarplanepaldevneu01.name
    runbook_id = azurerm_automation_runbook.aarplanepaldevneu01.id
    parameters = {
      param1 = "some-value"
    }
  }
}

/*resource "azurerm_storage_account" "stplanepaldevneu02" {
  name                     = "st${lower(var.app_name)}${var.environment}${var.location_abbreviation}02"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.st_account_tier
  account_replication_type = var.st_replication_type
}*/

resource "azurerm_storage_container" "scplanepaldevneu02" {
  name                  = "sc${lower(var.app_name)}${var.environment}${var.location_abbreviation}02"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.sc_container_access_type 
}
