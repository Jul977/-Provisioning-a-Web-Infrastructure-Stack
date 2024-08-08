# Define an Azure Key Vault
resource "azurerm_key_vault" "vault" {
  name                = var.kv_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  #tenant_id           = data.azurerm_client_config.Jul1.tenant_id
  enabled_for_disk_encryption = true

}

# Define a Key Vault secret for SQL Database credentials
resource "azurerm_key_vault_secret" "db_password" {
  name         = "sql-db-password"
  value        = "P@ssw0rd1234!" # Change to a secure password
  key_vault_id = azurerm_key_vault.vault.id
}

# Define a Key Vault access policy to allow SQL Server to access Key Vault
resource "azurerm_key_vault_access_policy" "sql_server_access" {
  key_vault_id = azurerm_key_vault.vault.id
  #tenant_id    = data.azurerm_client_config.Jul1.tenant_id
  object_id = azurerm_mssql_server.server.identity[0].principal_id

  secret_permissions = [
    "get",
    "list"
  ]
}

# Data source to get client config for tenant ID
#data "azurerm_client_config" "Jul1" {}