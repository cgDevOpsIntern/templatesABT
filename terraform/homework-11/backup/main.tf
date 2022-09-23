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

  resource_group_name = var.rgName
  subscription_id = var.subID
  client_id = var.clientID
  client_secret = var.clientSec
  tenant_id = var.tenantID
}

data "azurerm_storage_account" "example" {
  name                = var.storageAccountName
  resource_group_name = var.group
}

data "azurerm_storage_account_sas" "example" {
  connection_string = data.azurerm_storage_account.example.primary_connection_string
  https_only        = true
  signed_version    = "2021-06-08"

  resource_types {
    service   = false
    container = true
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = "2022-01-01T00:00:00Z"
  expiry = "2023-01-01T00:00:00Z"

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = true
    process = true
    tag     = true
    filter  = true
  }
}


resource "azurerm_service_plan" "example" {
  name                = var.appServiceName
  resource_group_name = var.group
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.pricingTier
}

resource "azurerm_linux_web_app" "example" {
  name                = format("%s-%s", var.appServiceName, "webapp")
  resource_group_name = var.group
  location            = var.location
  service_plan_id     = azurerm_service_plan.example.id

  backup {
    name                = "${var.appServiceName}_backup"
    storage_account_url = format("%s%s%s", data.azurerm_storage_account.example.primary_blob_endpoint, "${var.storageAccountName}container", data.azurerm_storage_account_sas.example.sas)
    schedule {
      frequency_interval    = var.schedule.frequency_interval
      frequency_unit        = var.schedule.frequency_unit
      retention_period_days = var.schedule.retentionPolicy
    }
  }

  site_config {
    worker_count = var.nodeNo
    application_stack {
      docker_image     = var.dockerImage
      docker_image_tag = "latest"
    }
  }
}