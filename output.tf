output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.this.default_site_hostname}"
}

output "cosmosdb_connectionstring" {
  value = azurerm_cosmosdb_account.this.connection_strings
  sensitive = true
}
