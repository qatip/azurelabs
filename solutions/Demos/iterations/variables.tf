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
    "rg-test" = "East US"
    "rg-dem" = "West Europe"
    "rg-deo" = "Central US"
  }
}
