#Creating our resource group
resource "azurerm_resource_group" "Jul1" {
  name     = var.resource_group_name
  location = var.location

}