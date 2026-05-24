terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "<sub here>"
}

# Resource Group
resource "azurerm_resource_group" "example" {
  # hard coded - not great !
  #name     = "RG1"
  #ocation = "East US"
  # variables - better :-)
  name     = var.resource_group_name
  location = var.location
}

# Outputs
output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

output "resource_group_location" {
  value = azurerm_resource_group.example.location
}

#output "workspace_name" {
#  value = terraform.workspace
#}



