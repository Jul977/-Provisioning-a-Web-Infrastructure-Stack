# Instructing terraform to use the remote backend for our state file
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-rg-statefile"
    storage_account_name = "jultfstorage"
    container_name       = "jultfstate"
    key                  = "terraform.tfstate"
  }
}