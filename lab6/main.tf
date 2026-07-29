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

terraform {
  backend "azurerm" {
    resource_group_name  = "jenkins-sa-{suffix}"
    storage_account_name = "jenkinsstate-{suffix}"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "rg-{suffix}-test-1"
  location = "westeurope"
}
