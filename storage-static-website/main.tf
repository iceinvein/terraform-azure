terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.82"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "this" {
  name                      = var.storage_account_name
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  access_tier               = "Hot"
  account_replication_type  = "LRS"
  min_tls_version           = "TLS1_2"
  shared_access_key_enabled = true

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"

  }

  blob_properties {
    versioning_enabled = true

  }

}
