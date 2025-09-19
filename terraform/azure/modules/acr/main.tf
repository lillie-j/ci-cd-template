resource "azurerm_container_registry" "ci_cd_repo" {
  name                = var.repo_name
  resource_group_name = var.azure_resource_group
  location            = var.region
  sku                 = "Basic"
  admin_enabled = true
}