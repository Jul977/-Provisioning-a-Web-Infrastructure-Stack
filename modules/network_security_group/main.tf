#Creating a Security rule to open port 80 and 443 on our Web tier subnet
resource "azurerm_network_security_group" "net1" {
  name                = "WebRule"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow_port80_and_443"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80,443"
    source_address_prefix      = "*"
    destination_address_prefix = var.snet1_address_space
  }
}

#Attaching our security rule to our VMs subnet
resource "azurerm_subnet_network_security_group_association" "net1" {
  subnet_id                 = azurerm_subnet.net1.id
  network_security_group_id = azurerm_network_security_group.net1.id
}


#Creating a Security rule to open port 1433 on our Database tier subnet
resource "azurerm_network_security_group" "net1" {
  name                = "DBRule"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow_port14333"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "1443"
    source_address_prefix      = "*"
    destination_address_prefix = var.snet2_address_space

  }
}

#Attaching our security rule to our VMs subnet
resource "azurerm_subnet_network_security_group_association" "net2" {
  subnet_id                 = azurerm_subnet.net2.id
  network_security_group_id = azurerm_network_security_group.net2.id
}