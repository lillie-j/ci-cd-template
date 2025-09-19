variable "azure_resource_group" {
  type        = string
  description = "Name of Resource Group to create Web App in"
}

variable "app_name" {
  type        = string
  description = "Name of the Web App to create"
}

variable "region" {
  type        = string
  description = "Region to create Web App in. Non-programmatic formatted e.g. 'UK South', not 'uksouth'"
  default     = "UK South"
}

variable "service_plan_id" {
  type        = string
  description = "ID of the Service Plan to create Web App in"
}

# variable "acr_login_server" {
#   type        = string
#   description = "Login Server of ACR Repo where Images are stored"
# }

# variable "acr_username" {
#   type        = string
#   description = "Username to authenticate into ACR Repo"
#   sensitive = true
# }

# variable "acr_password" {
#   type        = string
#   description = "Password to authenticate into ACR Repo"
#   sensitive = true
# }

# variable "frontend_image" {
#   type = string
#   description = "URL to Frontend Image"
# }

# variable "backend_image" {
#   type = string
#   description = "URL to Backend Image"
# }