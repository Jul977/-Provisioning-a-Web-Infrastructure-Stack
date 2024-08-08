#Creating our virtual network
resource "azurerm_virtual_network" "net1" {
  name                = "Hub-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_space]

}

#Creating a Web tier subnet for our virtual machines (VM)
resource "azurerm_subnet" "net1" {
  name                 = "Hub-vnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.net1.name
  address_prefixes     = [var.snet1_address_space]
}

#Creating a Database tier subnet for our virtual machines (VM)
resource "azurerm_subnet" "net2" {
  name                 = "Database_tier_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.net1.name
  address_prefixes     = [var.snet2_address_space]
}

#Creating a dedicated subnet for our application gateway
resource "azurerm_subnet" "net3" {
  name                 = "appgateway_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.net1.name
  address_prefixes     = [var.snet3_address_space]
}