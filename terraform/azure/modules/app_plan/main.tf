resource "azurerm_service_plan" "cicd_app_service_plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.azure_resource_group
  location            = var.region
  os_type             = "Linux"
  sku_name            = "B1"
}