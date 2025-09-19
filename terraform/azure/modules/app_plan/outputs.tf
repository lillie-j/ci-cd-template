output "app_service_plan_id" {
    description = "ID of the App Service Service Plan"
    value = azurerm_service_plan.cicd_app_service_plan.id
}