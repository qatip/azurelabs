variable "resource_group_count" {
  description = "The number of Resource Groups to create"
  type        = number
  default     = 3
}

variable "location" {
  description = "The Azure region"
  type        = string
  default     = "East US"
}

variable "resource_groups" {
  description = "Map of resource group names to their locations"
  type        = map(string)
  default = {
    "rg-demo-1" = "East US"
    "rg-demo-2" = "West Europe"
    "rg-demo-3" = "Central US"
  }
}
