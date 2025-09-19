resource "azurerm_linux_web_app" "cicd_webapp" {
  name = var.app_name
  location = var.region
  resource_group_name = var.azure_resource_group
  service_plan_id = var.service_plan_id

  site_config {
    linux_fx_version = "DOCKER|https://raw.githubusercontent.com/lillie-j/ci-cd-template/refs/heads/main/app/docker-compose.yml"
  }
}

