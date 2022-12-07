# Step by Step creating Resource Group, VM, Storage Account  with Terraform in Azure.
##1.	Resource Group
•	 Open VS Code and create new folder (ctrl+O), 
•	Create new file and name it main.tf
•	In the file past below script,
### We strongly recommend using the required providers block to set the
### Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

### Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

### Create a resource group
resource "azurerm_resource_group" "akin123" {
  name     = "akin123"
  location = "West us"
  tags = {
    "terraform" = "value"
  }
}
•	from the terminal, first, login your az portal with using “az login” command.   
•	After login your azure portal, provision below commands:

terraform init
terraform plan
terraform apply
#@2.	VM
•	To get VM first we should find Windows virtual machine script from terraform web site;
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine 

•	As a second step copy all code from webpage to VS code:
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
•	To create VM we should create.
RG
Virtual network
Subnet
NIC
IP
User ID and password
OS
##3.	Storage Account:
•	On the left pane of the terraform website find azurerm_storage_account
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account 
•	copy and paste entire template into VS Code
  resource "azurerm_storage_account" "example" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
•	and follow the steps as part one. 
(you can see in the last picture on azure portal which is storage account created from terraform.

