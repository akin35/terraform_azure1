# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "akin123" {
  name     = "akin123"
  location = "West us"
  tags = {
    "terraform" = "value"
  }
}
resource "azurerm_virtual_network" "vnet123" {
  name                = "vnet123"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.akin123.location
  resource_group_name = azurerm_resource_group.akin123.name
}

resource "azurerm_subnet" "subnet123" {
  name                 = "subnet123"
  resource_group_name  = azurerm_resource_group.akin123.name
  virtual_network_name = azurerm_virtual_network.vnet123.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic123" {
  name                = "nic123"
  location            = azurerm_resource_group.akin123.location
  resource_group_name = azurerm_resource_group.akin123.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet123.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm123" {
  name                = "vm123"
  resource_group_name = azurerm_resource_group.akin123.name
  location            = azurerm_resource_group.akin123.location
  size                = "Standard_F2"
  admin_username      = "akin3540"
  admin_password      = "Adnan.123"
  network_interface_ids = [
    azurerm_network_interface.nic123.id,
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

resource "azurerm_storage_account" "storage_account" {
  name                     = "akin123"
  resource_group_name      = azurerm_resource_group.akin123.name
  location                 = azurerm_resource_group.akin123.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  }
