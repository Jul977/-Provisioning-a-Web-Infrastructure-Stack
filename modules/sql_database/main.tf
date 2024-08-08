# Define an SQL Server with system-assigned managed identity
resource "azurerm_mssql_server" "server" {
  name                         = "db-sqlserver"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = azurerm_key_vault_secret.db_password.value

   identity {
    type = "SystemAssigned"
}
}


resource "azurerm_mssql_database" "database" {
  name           = "server-db"
  server_id      = azurerm_mssql_server.server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0" # Standard tier, S0 pricing tier
  zone_redundant = true
  enclave_type   = "VBS"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}


# Define a firewall rule to allow access to Azure services
resource "azurerm_mssql_server_firewall_rule" "allow_azure_services" {
  name                = "allow-azure-services"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"  # This allows access from Azure services
}

# Data source to get client config for tenant ID
data "azurerm_client_config" "example" {}
