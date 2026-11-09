terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "{sub}"
}
/*
# Create Resource Groups dynamically using count
resource "azurerm_resource_group" "example1" {
  count    = var.resource_group_count

  name     = "rg-demo-${count.index + 1}"
  location = var.location
}

# Output: Example 1 - Resource group names and regions
output "resource_groups_example_1" {
  description = "Resource group names with their locations"
  value = [
    for rg in azurerm_resource_group.example1 : 
    "${rg.name} is in ${rg.location}"
  ]
}
*/

# Create multiple Resource Groups using for_each
resource "azurerm_resource_group" "example2" {
  for_each = var.resource_groups
  name     = each.key
  location = each.value
}

# Outputs
output "resource_groups_example_2" {
  description = "Resource groups created with their locations"
  value = { for rg_name, rg in azurerm_resource_group.example2 : 
    rg_name => rg.location
  }
}

