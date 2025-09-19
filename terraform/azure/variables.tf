variable "azure_subscription_id" {
    type = string
    description = "Azure Subscription ID to create resources with"
}

variable "azure_resource_group" {
  type        = string
  description = "Name of Resource Group to create resources in"
  default     = "github_asset_managemnet_ci_Cd"
}

variable "region" {
  type        = string
  description = "Region to create resources in. Non-programmatic format e.g. 'UK South', not 'uksouth'"
  default     = "UK South"
}

variable "repo_name" {
  type        = string
  description = "Name of the Repo to create in ACR"
}

variable "app_service_plan_name" {
  type        = string
  description = "Name of the App Service Service Plan to create"
}

variable "app_name" {
  type        = string
  description = "Name of the Web App to create"
}


