#Provisioning a Web Infrastructure Stack

#create resource group (referencing the module)
module "resource_group" {
  source           = "../modules/resource_group"
  resource_group_name = var.resource_group_name
  location = var.location
}


#create virtual network (referencing the module)
module "virtual_network" {
  source = "../modules/virtual_network"
  resource_group_name = module.resource_group.name
  location = var.location
  vnet_address_space     = var.vnet_address_space
  snet1_address_space = var.snet1_address_space
  snet2_address_spacee = var.snet2_address_spacee
  snet3_address_space = var.snet3_address_space

  depends_on = [module.resource_group]
}

#create network security group (referencing the module)
module "network_security_group" {
  source = "../modules/network_security_group"
  resource_group_name = module.resource_group.name
  location = var.location
  snet1_address_space = var.snet1_address_space
  snet2_address_spacee = var.snet2_address_spacee
  

  depends_on = [module.resource_group, module.virtual_network]
}

#create virtual machine (referencing the module)
module "virtual_machine" {
  source = "../modules/virtual_machine"
  resource_group_name = module.resource_group.name
  location = var.location
  lb_backend_pool_ids = [module.load_balancer.lb_backend_pool_id]
  ag_backend_pool_ids = [module.application_gateway.ag_backend_pool_id]
  subnet_id = module.virtual_network.subnet_id

  depends_on = [module.resource_group, module.virtual_network, module.load_balancer, module.application_gateway]
}

#create load balancer (referencing the module)
module "load_balancer" {
  source = "../modules/load_balancer"
  resource_group_name = module.resource_group.name
  location = var.location

  depends_on = [module.resource_group]
}

#create application gateway (referencing the module)
module "application_gateway" {
  source = "../modules/application gateway"
  resource_group_name = module.resource_group.name
  location = var.location
  app_gateway_name = var.app_gateway_name
 
  depends_on = [module.resource_group, module.virtual_network]
}

#create sql database (referencing the module)
module "sql_database" {
  source = "../modules/sql_database"

  depends_on = [module.resource_group]
}

#create key vault (referencing the module)
module "key_vault" {
  source = "../modules/key_vault"
  resource_group_name = var.resource_group_name
  location = var.location
  kv_name = var.kv_name

  depends_on = [module.resource_group]
}


