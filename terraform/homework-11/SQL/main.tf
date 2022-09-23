terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}

  # resource_group_name = var.rgName
  subscription_id = var.subID
  client_id       = var.clientID
  client_secret   = var.clientSec
  tenant_id       = var.tenantID
}

resource "azurerm_resource_group" "rgName" {
  name     = var.rgName
  location = var.location
}

resource "azurerm_mssql_server" "sqldb" {
  name                         = var.serverName
  resource_group_name          = var.rgName
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admName
  administrator_login_password = var.logpass
}

resource "azurerm_mssql_database" "Database" {
  name                 = var.dbName
  server_id            = azurerm_mssql_server.sqldb.id
  sku_name             = var.pricingTier
  storage_account_type = var.dbBackupPolicy
}

resource "azurerm_mssql_firewall_rule" "firewallRules" {
  count            = length(var.firewallRules)
  name             = var.firewallRules[count.index].name
  server_id        = azurerm_mssql_server.sqldb.id
  start_ip_address = var.firewallRules[count.index].start
  end_ip_address   = var.firewallRules[count.index].end
}
