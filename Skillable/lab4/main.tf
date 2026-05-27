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
  subscription_id = "<your subscription id here>"
}

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "RG1"
  location = "northeurope"
}

output "workspace_name" {
  value = terraform.workspace
}
