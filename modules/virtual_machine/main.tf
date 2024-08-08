#Creating a Web tier virtual machines (VM) using vmss
resource "azurerm_windows_virtual_machine_scale_set" "vmss1" {
  name                 = "web-vmss"
  resource_group_name  = var.vnet_name
  location             = var.location
  sku                  = "Standard_D2s_v3"
  instances            = 2
  admin_password       = "P@55w0rd1234!"
  admin_username       = "adminuser"
  computer_name_prefix = "vm-"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter-Server-Core"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vmss_nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
      load_balancer_backend_address_pool_ids = var.lb_backend_pool_ids
      application_gateway_backend_address_pool_ids = var.ag_backend_pool_ids

    }

     # Scaling settings
  autoscale_profile {
    name = "vmss-autoscale-profile"

    rule {
      name    = "vmss-scale-out"
      metric  = "Percentage CPU"
      operator = "GreaterThan"
      threshold = 60
      direction = "Increase"
      change_count = 1
      cooldown = "PT5M"
    }

    rule {
      name    = "vmss-scale-in"
      metric  = "Percentage CPU"
      operator = "LessThan"
      threshold = 25
      direction = "Decrease"
      change_count = 1
      cooldown = "PT5M"
    }
  }

  # Scaling configuration
  min_instances = 2
  max_instances = 5
  }
}

#Creating VMs (Windows server) for our database

#Creating network interface for our VMs
resource "azurerm_network_interface" "nic1" {
  name                = vm_nic
  resource_group_name  = var.vnet_name
  location             = var.location

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.net2.id
    private_ip_address_allocation = "Static"
  }
}
#Creating the VM (Windows server)
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "Database_Vm"
  resource_group_name  = var.vnet_name
  location             = var.location
  size                  = "Standard_D4s_v3"
  admin_username        = "adminuser"
  admin_password        = "Pa$$.word97"
  network_interface_ids = [azurerm_network_interface.nic1.id]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

}