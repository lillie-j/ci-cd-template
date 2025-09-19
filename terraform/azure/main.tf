module "acr" {
  source               = "./modules/acr"
  azure_resource_group = var.azure_resource_group
  region               = var.region
  repo_name            = var.repo_name
}

module "app_plan" {
    source = "./modules/app_plan"
    azure_resource_group = var.azure_resource_group
    region = var.region
    app_service_plan_name = var.app_service_plan_name
}

# module "web_app" {
#     source = "./modules/web_app"
#     azure_resource_group = var.azure_resource_group
#     region = var.region
#     service_plan_id = module.app_plan.app_service_plan_id
#     app_name = var.app_name
# }

module "iam" {
  source = "./modules/iam"
  resource_group = var.azure_resource_group
  acr_id = module.acr.acr_resource_id
}