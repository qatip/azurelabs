terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "{sub}"
}

# ---------------------------------------------------------
# Resource Group
# ---------------------------------------------------------

resource "azurerm_resource_group" "demo" {
  name     = var.resource_group_name
  location = var.location
}

# ---------------------------------------------------------
# Azure Verified Module - Virtual Network
# ---------------------------------------------------------

module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.22.1"

  name          = var.vnet_name
  location      = azurerm_resource_group.demo.location
  parent_id     = azurerm_resource_group.demo.id
  address_space = var.address_space

  enable_telemetry = var.enable_telemetry

  subnets = {
    web = {
      name             = var.web_subnet_name
      address_prefixes = var.web_subnet_prefixes
    }

    app = {
      name             = var.app_subnet_name
      address_prefixes = var.app_subnet_prefixes
    }

    data = {
      name             = var.data_subnet_name
      address_prefixes = var.data_subnet_prefixes
    }
  }

  tags = var.tags
}

# ---------------------------------------------------------
# Outputs
# ---------------------------------------------------------
/*
output "resource_group_name" {
  description = "Name of the resource group."
  value       = azurerm_resource_group.demo.name
}

output "vnet_name" {
  description = "Name of the virtual network."
  value       = module.vnet.name
}

output "vnet_id" {
  description = "Resource ID of the virtual network."
  value       = module.vnet.resource_id
}

output "subnets" {
  description = "Subnets created by the AVM module."
  value       = module.vnet.subnets
}
*/