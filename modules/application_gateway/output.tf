output "ag_backend_pool_ids" {
  value = azurerm_application_gateway.network.backend_address_pool[0].id
}