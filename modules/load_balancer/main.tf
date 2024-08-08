#Creating the public IP of the external load balancer
resource "azurerm_public_ip" "pip" {
  name                = "pip1"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}


#Creating an external load balancer to distribute traffic between the VMs
resource "azurerm_lb" "lb" {
  name                = "JulLb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"


  frontend_ip_configuration {
    name                 = "PublicLb"
    public_ip_address_id = "azurerm_public_ip.pip.id"
  }

}

#Creating the backend pool
resource "azurerm_lb_backend_address_pool" "pool1" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "VmPool"
}

/*Associating the VM to the backend pool of the load balancer
resource "azurerm_network_interface_backend_address_pool_association" "pool1" {
  network_interface_id    = azurerm_network_interface.example.id
  ip_configuration_name   = "testconfiguration1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.pool1.id
}*/

#Creating the health probe 
resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "vm-probe"
  port            = 80
}

#Creating a load balacncing rule to probe the IIS server on port 80 since IIS listens on port 80 by default
resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "Lbrule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicLb"
  probe_id                       = azurerm_lb_probe.probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.Pool1.id]
}