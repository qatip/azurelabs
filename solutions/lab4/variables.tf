variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
#  default     = "rg-{suffix}"
}

variable "location" {
  description = "The Azure region to deploy the Resource Group"
  type        = string
#  default     = "North Europe"
}

