variable "azure_resource_group" {
  type        = string
  description = "Name of Resource Group to create ACR Repo in"
}

variable "repo_name" {
  type        = string
  description = "Name of the Repo to create in ACR"
}

variable "region" {
  type        = string
  description = "Region to create ACR repo in. Non-programmatic formatted e.g. 'UK South', not 'uksouth'"
  default     = "UK South"
}