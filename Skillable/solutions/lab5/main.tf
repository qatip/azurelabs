terraform {
  required_version = ">=1.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "<your subscription id here>"
}

module "networking" {
  source = "./network_module"
}

#terraform {
#  backend "azurerm" {
#    resource_group_name  = "RG1"
#    storage_account_name = "remotestate{name}"
#    container_name       = "terraform-state"
#    key                  = "terraform.tfstate"
#  }
#}
