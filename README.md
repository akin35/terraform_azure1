# Step by Step creating Resource Group, VM, Storage Account  with Terraform in Azure.
##1.	Resource Group
*	 Open VS Code and create new folder (ctrl+O), 
*	Create new file and name it main.tf
*	In the file past the script 
*	from the terminal, first, login your az portal with using “az login” command.   
*	After login your azure portal, provision below commands:
terraform init
terraform plan
terraform apply
##2.	VM
*	To get VM first we should find Windows virtual machine script from terraform web site;
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine 

*	As a second step copy all code from webpage to VS code:

•	To create VM we should create.
RG
Virtual network
Subnet
NIC
IP
User ID and password
OS
##3.	Storage Account:
*	On the left pane of the terraform website find azurerm_storage_account
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account 
*	copy and paste entire template into VS Code
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
*	and follow the steps as part one. 
(you can see in the last picture on azure portal which is storage account created from terraform.

