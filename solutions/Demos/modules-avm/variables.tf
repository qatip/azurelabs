variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
}

variable "location" {
  description = "Azure region in which resources will be created."
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "Address space assigned to the virtual network."
  type        = set(string)
}

variable "web_subnet_name" {
  description = "Name of the web subnet."
  type        = string
}

variable "web_subnet_prefixes" {
  description = "Address prefixes assigned to the web subnet."
  type        = list(string)
}

variable "app_subnet_name" {
  description = "Name of the application subnet."
  type        = string
}

variable "app_subnet_prefixes" {
  description = "Address prefixes assigned to the application subnet."
  type        = list(string)
}

variable "data_subnet_name" {
  description = "Name of the data subnet."
  type        = string
}

variable "data_subnet_prefixes" {
  description = "Address prefixes assigned to the data subnet."
  type        = list(string)
}

variable "enable_telemetry" {
  description = "Controls whether Azure Verified Module telemetry is enabled."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the virtual network."
  type        = map(string)
  default     = {}
}