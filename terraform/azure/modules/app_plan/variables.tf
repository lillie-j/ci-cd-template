variable "azure_resource_group" {
  type        = string
  description = "Name of Resource Group to create App Service Service Plan in"
}

variable "app_service_plan_name" {
  type        = string
  description = "Name of the App Service Service Plan to create"
}

variable "region" {
  type        = string
  description = "Region to create App Service Service Plan in. Non-programmatic formatted e.g. 'UK South', not 'uksouth'"
  default     = "UK South"
}