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

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_cosmosdb_account" "this" {
  name                = "cosmos-db-${random_integer.ri.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  offer_type          = "Standard"
  kind                = "MongoDB"
  mongo_server_version = "4.0"
  enable_free_tier    = true

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = azurerm_resource_group.this.location
    failover_priority = 0
  }
}

data "azurerm_resource_group" "container-registry" {
  name = var.container_registry_resource_group  
}

data "azurerm_container_registry" "this" {
  name                = var.container_registry_name
  resource_group_name = var.container_registry_resource_group
}

resource "azurerm_app_service_plan" "this" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "this" {
  name                = var.app_service_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  app_service_plan_id = azurerm_app_service_plan.this.id

  site_config {
    linux_fx_version = "DOCKER|${var.container_image}"
    use_32_bit_worker_process = true
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITE_PORT"                        = "5000"
    "DOCKER_ENABLE_CI"                    = "true"
    "DOCKER_REGISTRY_SERVER_URL"          = data.azurerm_container_registry.this.login_server
    "MONGO_DB_URI"                        = azurerm_cosmosdb_account.this.connection_strings.0
    "DOCKER_REGISTRY_SERVER_USERNAME"     = data.azurerm_container_registry.this.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = data.azurerm_container_registry.this.admin_password
  }

  lifecycle {
    ignore_changes = [
      site_config.0.linux_fx_version,
    ]
  }
}

resource "azurerm_role_assignment" "this" {  
  role_definition_name = "AcrPull"
  scope                = data.azurerm_resource_group.container-registry.id
  principal_id         = azurerm_app_service.this.identity.0.principal_id
}
