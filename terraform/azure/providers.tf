terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "4.40"
        }
    }
}


# Creds pulled from AZ CLI, no need to configure here
provider "azurerm" {
    features {}
    subscription_id = var.azure_subscription_id
}