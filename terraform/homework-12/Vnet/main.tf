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

  subscription_id = var.subID
  client_id       = var.clientID
  client_secret   = var.clientSec
  tenant_id       = var.tenantID
}

resource "azurerm_virtual_network" "vnetName" {
  name                = var.vnetName
  location            = var.location
  resource_group_name = var.rgName
  address_space       = [var.addressSpace]
}

resource "azurerm_subnet" "subnetsName" {
  count                = length(var.arrayOfSubnets)
  name                 = var.arrayOfSubnets[count.index].name
  resource_group_name  = var.rgName
  virtual_network_name = azurerm_virtual_network.vnetName.name
  address_prefixes     = [var.arrayOfSubnets[count.index].adressPrefix]
}
