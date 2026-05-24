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
  subscription_id = "{your subscription id}"
}

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-{suffix}-default"
  location = "North Europe"
}

output "workspace_name" {
  value = terraform.workspace
}
