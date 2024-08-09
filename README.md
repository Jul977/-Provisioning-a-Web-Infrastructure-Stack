# Provisioning a Web Infrastructure Stack

This project is a Terraform configuration for deploying a resilient and scalable Architecture in Azure.

## Prerequisites
Before you can use this project, you will need to have the following installed:

Azure Account - If you don't have one, you can sign up for a free trial on the Azure website

Terraform Installed - download the latest version from the Terraform website and follow the installation instructions.

Visual Studio Code and The Official Terraform Extension

Azure CLI

Azure Service Principal (Recommended) - Follow the instructions on Microsoft Learn to create a Service Principal and authenticate Terraform to use it

## Implementation Steps

The first step to configuring Terraform Backend to store the state management file (backend.tf) in Azure Storage is to create an Azure Storage Account and a container.

The Azure Storage Account and container can easily be created using the Azure Portal.

Once you've successfully created the storage account and container, the next step involves configuring the backend.tf file. This file should include the names of the resource group, storage account, and container that you defined earlier.

Proceed to define the terraform provider which is azurerm in the providers.tf file

##### Creating the Project Directory

Begin by creating a dedicated directory for your Terraform project. This directory will serve as the root of your project and will house all the necessary files and subdirectories.

## Here's a quick rundown of these files:

### Main folder
main.tf: This file aggregates the modules you've defined and sets up any additional resources that span across multiple modules, such as global networking components.

variables.tf: Similar to the module-level variables, root-level variables allow you to customize the overall configuration of your project.

terraform.tfvars: Store variable values in this file to make it easy to manage and share different configurations.

providers.tf: Specify the providers you're using, along with any provider-specific settings.

backend.tf: The backend.tf file is crucial when configuring remote state management. It establishes the backend settings, such as where and how the Terraform state should be stored remotely, often in cloud storage like Azure Storage which we already had set up previously.


## Dividing Your Infrastructure into Modules

Modules allow you to simplify specific configurations and logically separate different components of your architecture.

Inside the modules/ directory, you'll create subdirectories for each module you plan to create.

Finally, it's time to write your infrastructure.

Now we are ready to deploy our infrastructure on the cloud

Get into the project directory

Proceed to use az login to authenticate into our azure environment using the details of the service principal earlier created

cd main

👉 Let install dependency to deploy the infrastructure 
terraform init

Type the below command to see the plan of the execution
terraform plan

✨Finally, HIT the below command to deploy the application...

terraform apply -auto-approve

### Resource created
Resource group,
Virtual network,
Network security group,
Virtual machine,
Load balancer,
Application gateway,
key vault



